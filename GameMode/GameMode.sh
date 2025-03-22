#!/usr/bin/env sh

# Check if the process "sunshine" is running to block reload on RemoteSeason:
if pgrep -x "sunshine" > /dev/null; then # IS RUNNING:
    echo "The sunshine process is running."
else # IS NOT RUNNING

    # Current State:
    HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==2{print $2}')

    if [ -z $1 ] || [ "$HYPRGAMEMODE" = 1]; then 
        #No Parameter == GAMEMODE!
        #keyword decoration:drop_shadow 0;\
        hyprctl --batch "\
            keyword animations:enabled 0;\
            keyword decoration:shadow 0;\
            keyword decoration:blur:enabled 0;\
            keyword general:gaps_in 0;\
            keyword general:gaps_out 0;\
            keyword general:border_size 1;\
            keyword decoration:rounding 0"
        exit
    else #Parameter == OFF!
        hyprctl reload
        sleep 1
    fi
fi

exit
