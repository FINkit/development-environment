#!/usr/bin/env bash

function wait_procnames {
    while true; do
        alive_pids=()
        for pname in "$@"; do
            if [ "$(pgrep "$pname")" ]; then
                alive_pids+=("$pname ")
            fi
        done
        if [ "${#alive_pids[@]}" -eq 0 ]; then
            break
        else
            printf "waiting for: %s\n" "${alive_pids[@]}"
        fi
        sleep 1
    done
}

wait_procnames dpkg apt unattended-upgrade
