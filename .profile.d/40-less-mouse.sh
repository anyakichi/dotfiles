#!/bin/sh

if [ "$(less -V | awk 'NR==1 {print (int($2) >= 549)}')" = 1 ]; then
    LESS="${LESS} --mouse"
fi
