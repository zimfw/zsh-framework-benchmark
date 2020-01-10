() {
if (( SHLVL > 1 )); then
  print "run: cannot be executed on a nested shell. SHLVL is ${SHLVL}." >&2
  return 1
fi
# ensure that we're not running zsh from THREE AND A HALF YEARS AGO
if ! autoload -Uz is-at-least || ! is-at-least '5.2'; then
  print "run: running zsh < 5.2. Any further tests would be meaningless.\nYour shell has been outdated for over three and a half years." >&2
  return 1
fi

local test_dir="${PWD:A}/tmp/${RANDOM}"
local -i keep_frameworks=0
local -i iterations=100
local -i has_antibody=0
local frameworks=()
# adding vanilla first, because it should always be the baseline
local available_frameworks=(vanilla)
local f
for f in ./frameworks/*; do
  if [[ ${f:t:r} != 'vanilla' ]]; then
    available_frameworks+=${f:t:r}
  fi
done

# ensure to use dot ('.') as decimal separator, because some locale (ex: it_IT) use comma (',')
unset LC_NUMERIC

local usage="source run.zsh [options]
Options:
    -h                  Show this help
    -k                  Keep the frameworks (don't delete) after the tests are complete (default: delete)
    -p <path>           Set the path to where the frameworks should be 'installed' (default: auto-generated)
    -n <num>            Set the number of iterations to run for each framework (default: 100)
    -f <framework>      Select a specific framework to benchmark (default: all; can specify more than once)"

while [[ ${#} -gt 0 ]]; do
  case ${1} in
    -h) print ${usage}
        return 0
        ;;
    -k) keep_frameworks=1
        shift
        ;;
    -p) shift
        command mkdir -p ${1}
        if [[ -d ${1} ]]; then
          test_dir=${1}
        else
          print "run: directory ${1} specified by option '-p' is invalid" >&2
          return 1
        fi
        shift
        ;;
    -n) shift
        iterations=${1}
        shift
        ;;
    -f) shift
        if [[ ${available_frameworks[(r)${1}]} == ${1} ]]; then
          frameworks+=${1}
        else
          print "run: framework \"${1}\" is not a valid framework.\nAvailable frameworks are: ${available_frameworks}" >&2
          return 1
        fi
        shift
        ;;
    *) print ${usage}
       return 1
       ;;
  esac
done

if (( # )); then
  print ${usage}
  return 1
fi

if (( ! ${#frameworks} )); then
  frameworks=($available_frameworks)
fi

# do some checks of the current environment so we can do cleanups later
#NOTE: these are workarounds, and are not the ideal solution to the problem of 'leftovers'
if [[ -e /usr/local/bin/antibody ]]; then
  has_antibody=1
fi

# the test_dir will be created by any (and every) framework's init script
# create the directory for the results.
local results_dir=${test_dir}-results
command mkdir -p ${results_dir}

set_up() {
  # first delete any old instances of the frameworks
  command rm -rf "${test_dir}/${1}"

  # setup the directory for the framework
  command mkdir -p ${test_dir}/${1}

  # source the installer
  print -n "\033[2K\rSetting up ${1} …"
  source ./frameworks/${1}.zsh ${test_dir}/${1}
}
benchmark() {
  local zdotdir_bak=${ZDOTDIR}
  {
    export ZDOTDIR=${test_dir}/${1}
    local TIMEFMT=%E
    # warmup
    print -n "\033[2K\rWarming up ${1} …"
    for i in {1..3}; do time zsh -ic 'exit'; done &>/dev/null
    # run
    print -n "\033[2K\rBenchmarking ${1} …"
    for i in {1..${iterations}}; do time zsh -ic 'exit'; done >/dev/null 2>!${results_dir}/${1}.log
  } always {
    ZDOTDIR=#{zdotdir_bak}
  }
  print -n "\033[2K\r${1}  "
  command sed 's/s$//' ${results_dir}/${1}.log | awk '
count == 0 || $1 < min { min = $1 }
count == 0 || $1 > max { max = $1 }
{
  sum += $1
  sumsq += $1**2
  count++
}
END {
  if (count > 0) {
    mean = sum/count
    if (min < max) { stddev = sqrt(sumsq/count - mean**2) } else { stddev = 0 }
  }
  print mean " ± " stddev "  " min " … " max
}'
}

# Useful for debugging.
print "Frameworks: ${test_dir}"
print "Results: ${results_dir}\n"

print "This may take a LONG time, as it runs each framework startup ${iterations} times.
Average startup times for each framework will be printed as the tests progress.\n"

print "Using Zsh ${ZSH_VERSION}\n"

for framework in ${frameworks}; do
  set_up ${framework} || return 1
done
for framework in ${frameworks}; do
  benchmark ${framework} || return 1
done

# cleanup frameworks unless '-k' was provided
if (( ! keep_frameworks )); then
  command rm -rf ${test_dir}
fi

# cleanup any corpses/leftovers
if (( ! has_antibody )); then
  command rm -f /usr/local/bin/antibody
fi
} "${@}"
