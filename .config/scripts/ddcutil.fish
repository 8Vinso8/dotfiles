#! /bin/fish

ddcutil --bus 7 --skip-ddc-checks --sleep-multiplier=.1 setvcp 10 $argv

set value $(ddcutil --bus 7 --skip-ddc-checks --sleep-multiplier=.1 --brief getvcp 10 | grep -oP "C \K\d+")

notify-send Brightness $value -h string:x-canonical-private-synchronous:osd
