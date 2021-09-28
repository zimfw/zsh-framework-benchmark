() {
if (( SHLVL > 1 )); then
  print -u2 "run: cannot be executed on a nested shell. SHLVL is ${SHLVL}."
  return 1
fi
# ensure that we're not running zsh from THREE AND A HALF YEARS AGO
if ! autoload -Uz is-at-least || ! is-at-least '5.2'; then
  print -u2 "run: running zsh < 5.2. Any further tests would be meaningless.\nYour shell has been outdated for over three and a half years."
  return 1
fi

local test_dir=${PWD:A}/results
local -i keep_frameworks=0
local -i iterations=100
# adding vanilla first, because it should always be the baseline
setopt LOCAL_OPTIONS EXTENDED_GLOB
local -r available_frameworks=(vanilla frameworks/(^vanilla.*)(N:t:r))
local frameworks=()

# ensure to use dot ('.') as decimal separator, because some locale (ex: it_IT) use comma (',')
unset LC_NUMERIC

local -r usage="source run.zsh [options]
Options:
    -h                  Show this help
    -k                  Keep the frameworks (don't delete) after the tests are complete (default: delete)
    -p <path>           Set the path to where the frameworks should be 'installed' (default: results)
    -n <num>            Set the number of iterations to run for each framework (default: 100)
    -f <framework>      Select a specific framework to benchmark (default: all; can specify more than once)"

while (( # )); do
  case ${1} in
    -h) print ${usage}
        return 0
        ;;
    -k) keep_frameworks=1
        shift
        ;;
    -p) shift
        test_dir=${1:A}
        shift
        ;;
    -n) shift
        iterations=${1}
        shift
        ;;
    -f) shift
        if [[ ${available_frameworks[(r)${1}]} == ${1} ]]; then
          frameworks+=(${1})
        else
          print -u2 "run: framework \"${1}\" is not a valid framework.\nAvailable frameworks are: ${available_frameworks}"
          return 1
        fi
        shift
        ;;
    *) print -u2 "run: invalid option \"${1}\"\n"
       print -u2 ${usage}
       return 1
       ;;
  esac
done

if (( # )); then
  print -u2 ${usage}
  return 1
fi

command mkdir -p ${test_dir} || return 1
if [[ ! -d ${test_dir} ]]; then
  print -u2 "run: directory ${1} is invalid"
  return 1
fi
if (( ! ${#frameworks} )); then
  frameworks=(${available_frameworks})
fi

set_up() {
  local -r home_dir=${test_dir}/${1}

  # first delete any old instances of the frameworks
  command rm -rf ${home_dir} || return 1

  # setup the directory for the framework
  command mkdir -p ${home_dir} || return 1

  # source the installer
  print "::group::Setting up ${1} ..."
  {
    source frameworks/${1}.zsh ${home_dir}
  } always {
    print '\n::endgroup::'
  }
}

benchmark() {
  local -r home_dir=${test_dir}/${1}
  local -r TIMEFMT=%mE
  local -r timeunit=ms
  local -r timediv=1000
  local i
  # warmup
  for i in {1..3}; do time HOME=${home_dir} zsh -lic 'exit'; done &>/dev/null
  # run
  for i in {1..${iterations}}; do time HOME=${home_dir} zsh -lic 'exit'; done >/dev/null 2>!${test_dir}/${1}.log
  if grep -v '^[0-9]\+\(\.[0-9]\+\)\?'"${timeunit}\$" ${test_dir}/${1}.log; then
    print "::error::Unexpected output when benchmarking ${1}"
    return 1
  fi
  command sed "s/${timeunit}\$//" ${test_dir}/${1}.log | command awk -v framework=${1} -v timediv=${timediv} '
count == 0 || $1 < min { min = $1 }
count == 0 || $1 > max { max = $1 }
{
  sum += $1
  sumsq += $1^2
  count++
}
END {
  if (count > 0) {
    mean = sum/count
    if (min < max) { stddev = sqrt(sumsq/count - mean^2) } else { stddev = 0 }
  }
  print framework "," mean/timediv "," stddev/timediv "," min/timediv "," max/timediv
}' | command tee -a ${results_file}
}

# Useful for debugging.
local -r results_file=${test_dir}/results.csv
print "Results: ${results_file}\n"

print "This may take a LONG time, as it runs each framework startup ${iterations} times.
Average startup times for each framework will be printed as the tests progress.\n"

print "Using Zsh ${ZSH_VERSION}\n"

{
  local framework
  for framework in ${frameworks}; do
    set_up ${framework} || return 1
  done
  print -P "\n%F{green}Benchmarking ...%f"
  print 'framework,mean,stddev,min,max' | command tee ${results_file}
  for framework in ${frameworks}; do
    benchmark ${framework} || return 1
  done
} always {
  # cleanup frameworks unless '-k' was provided
  if (( ! keep_frameworks )); then
    command rm -rf ${test_dir}/*(/) || return 1
  fi
}
} "${@}"
