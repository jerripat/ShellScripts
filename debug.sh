#!/bin/bash -v

#Built-in Bash Debug options
# From Udemy Bash Scripting Module 10 debugging
# -x : Prints command as executable
# +x stops debugging
# -e : prints errors and exits
# -v : prints Displays commands as exactly as they appear

# with -x
# TEST_VAR='test'
# echo "$TEST_VAR"
# TEST_VAR='test'
# set -x
# echo "$TEST_VAR"
# set +x
# hostname

# with -e
# FILE_NAME='/not/here/'
# ls $FILE_NAME
# echo $FILE_NAME

# with -ex
# FILE_NAME='/not/here'
# ls $FILE_NAME
# echo $FILE_NAME

# with -vx
# TEST_VAR='test'
# echo '$TEST_VAR'

# with variables
DEBUG=true
STOP_DEBUG=false
╰─❯
