#! /bin/bash

# usage:
#  ag -g .elm src tests | entr -r ./heath.sh


clear
date

time (elm make ./src/Main.elm --output /dev/null )


echo "====================="

