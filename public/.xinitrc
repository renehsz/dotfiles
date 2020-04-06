#!/bin/sh

# xprofile is also sourced by display managers (usually)
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile
exec ssh-agent emacs

