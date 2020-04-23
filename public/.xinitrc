#!/bin/sh

# xprofile is also sourced by display managers (usually)
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

SESS=${1:-emacs}
exec ssh-agent $SESS

