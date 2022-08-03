#! /vendor/bin/sh

function configure_read_ahead_kb_values() {
    MemTotalStr=`cat /proc/meminfo | grep MemTotal`
    MemTotal=${MemTotalStr:16:8}

    dmpts=$(ls /sys/block/dm*/queue/read_ahead_kb | grep -e dm -e mmc)

    # Set 128 for <= 3GB &
    # set 512 for >= 4GB targets.
    if [ $MemTotal -le 3145728 ]; then
        for dm in $dmpts; do
            echo 128 > $dm
        done
    else
        for dm in $dmpts; do
            echo 512 > $dm
        done
    fi
}

configure_read_ahead_kb_values;

