#!/bin/bash

pkill polybar
polybar --config=/home/zetsuen/.config/polybar/konpik satu &
polybar --config=/home/zetsuen/.config/polybar/konpik dua &

exit 0
