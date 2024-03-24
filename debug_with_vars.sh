#!/bin/bash

DEBUG=true

$DEBUG && echo 'Debug is on'
if $DEBUG; then
    echo 'Debug mode enabled'
else
    echo 'Debug mode off'
fi

debug(){

echo 'Executing: $@'
$@

}

