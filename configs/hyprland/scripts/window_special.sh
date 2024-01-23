#!/usr/bin/env bash

CACHE_DIR="/tmp/hypr"
CACHE_FILE_LIMIT=100

# Prepare
mkdir -p "$CACHE_DIR"
dump=$(hyprctl activewindow -j)
is_float=$(jq .floating <<<"$dump")
is_on_special=$(jq '.workspace.name == "special"' <<<"$dump")
pos_orig=$(jq '.at[]' <<<"$dump")

# Create cache file
address=$(hyprctl activewindow -j | jq -r .address)
temp_fname="$CACHE_DIR/$address"
! $is_on_special && echo -e "$is_float\n$pos_orig" >"$temp_fname"
[[ -z $temp_fname ]] && echo -e "false\n$pos_orig" >"$temp_fname"

if [[ $1 = "-f" ]]; then
    # Send window to special workspace
    if $is_float; then
        hyprctl dispatch movetoworkspace special
    else
        hyprctl --batch "dispatch togglefloating active; dispatch movetoworkspace special;"
    fi

    # Send window back from special workspace
    if $is_on_special; then
        read -r state <"$temp_fname"
        if $state; then
            hyprctl dispatch movetoworkspacesilent +0
        else
            hyprctl --batch "\
            dispatch movetoworkspacesilent +0; \
            dispatch togglefloating address:$address"
        fi
    fi
fi

if [[ $1 = "-t" ]]; then
    # Send window to special workspace
    if $is_float; then
        hyprctl --batch "dispatch togglefloating active; dispatch movetoworkspacesilent special"
    else
        hyprctl dispatch movetoworkspacesilent special
    fi

    # Send window back from special workspace
    if $is_on_special; then
        IFS=$'\n' read -r -d '' state x y <"$temp_fname"
        if $state; then
            hyprctl --batch "\
                dispatch movetoworkspacesilent +0; \
                dispatch togglefloating address:$address; \
                dispatch movewindowpixel exact $x $y,address:$address" #restore original position
        else
            hyprctl dispatch movetoworkspacesilent +0
        fi
    fi
fi
# If cache file limit is exceeded:
# Delete any exceeding cache file starting by the oldest.
cache_files=$(find /tmp/hypr -maxdepth 1 -type f -printf '%T@ %p\n' | sort -n | cut -d' ' -f2- | tail -n +$((CACHE_FILE_LIMIT + 1)))
n_cache_files=$(echo "$cache_files" | wc -l)
if [ "$n_cache_files" -gt "$CACHE_FILE_LIMIT" ]; then
    echo "INFO: Deleting cache files..."
    echo "$cache_files" | xargs rm
else
    echo "INFO: Cache files not found or below the limit."
fi
