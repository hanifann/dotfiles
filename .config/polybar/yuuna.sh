
#!/bin/bash

pkill polybar
polybar --config=/home/zetsuen/.config/polybar/yuu-windowchef &
polybar --config=/home/zetsuen/.config/polybar/yuu-openbox &

exit 0
