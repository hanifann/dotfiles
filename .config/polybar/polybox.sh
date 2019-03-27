
#!/bin/bash

pkill polybar
polybar --config=/home/zetsuen/.config/polybar/topi &
polybar --config=/home/zetsuen/.config/polybar/bottomi &

exit 0
