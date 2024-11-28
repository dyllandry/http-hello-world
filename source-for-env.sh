#!/usr/bin/env sh

# grep will print any lines from a file that don't start with "#".
# xargs will join the multiple lines into a single line
# export will set those env variables so they are accessible to child processes
# export works like: `export VAR=VAL VAR2=VAL ...`
export $(grep -v '^#' .env | xargs)
