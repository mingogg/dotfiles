#!/bin/bash

# Turns off the system closing brave first
# this allows opening brave & reload the tabs
# automatically

killall brave
sleep 0.5

/usr/bin/poweroff
