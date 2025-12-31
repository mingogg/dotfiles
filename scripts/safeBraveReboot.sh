#!/bin/bash

# Reboots the system closing brave first
# this allows opening brave & reload the tabs
# automatically

killall brave
sleep 2

/usr/bin/reboot
