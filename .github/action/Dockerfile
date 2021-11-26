FROM alpine:latest
RUN apk add -U --no-cache zsh coreutils curl expect git ncurses perl gnuplot
# Change default shell from ash to zsh
RUN sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd
ENV TERM=xterm-256color
ENTRYPOINT ["zsh", "-c"]
