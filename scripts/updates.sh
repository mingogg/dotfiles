#!/usr/bin/env bash

script_name=$(basename "$0")
instance_count=$(ps aux | grep -f "$script_name" | grep -v grep | grep -v $$ | wc -l)
if [ "$instance_count" -gt 1 ]; then sleep 1; fi

official=$(pacman -qu 2>/dev/null | wc -l)
aur=$(yay -qua 2>/dev/null | wc -l)

total=$(( official + aur ))

css="updates"
(( total > 25 )) && css="warning"
(( total > 100 )) && css="urgent"

if (( total > 0 )); then
    printf '{"text":"%d","alt":"%d","tooltip":"%d updates","class":"%s"}' \
           "$total" "$total" "$total" "$css"
else
    printf '{"text":"0","alt":"0","tooltip":"no updates","class":"green"}'
fi
