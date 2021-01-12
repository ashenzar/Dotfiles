#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color
TMP_IDX_FOLDER_NAME="/tmp/spotify_title_idx"
MAX_TITLE_LEN=14
if [ "$(playerctl status >>/dev/null 2>&1; echo $?)" == "1" ]
then
    echo
      exit 0
fi

status=$(playerctl -p spotify status)

if [ "$status"  == "Playing" ] || [ "$status" == "Paused" ]
then
    title=$(playerctl -p spotify metadata xesam:title )
    artist=$(playerctl -p spotify metadata xesam:artist)
    album=$(playerctl -p spotify metadata xesam:album )
    title_len=$(echo $title | wc -c)

    if [ $title_len -gt $MAX_TITLE_LEN ]
    then
        title_idx=1
        title_idx_fname="$TMP_IDX_FOLDER_NAME/$title"

        mkdir -p $TMP_IDX_FOLDER_NAME
        if [ -e "$title_idx_fname" ]
        then
            title_idx=$(cat "$title_idx_fname")
        else
            rm -rf $TMP_IDX_FOLDER_NAME/*
        fi
        title_left=$(echo $title | cut -c $title_idx-$(($title_idx+$MAX_TITLE_LEN)))

        if [ $title_idx -gt $title_len ]
        then
            title_idx=1
        fi

        if [ $(($title_idx+$MAX_TITLE_LEN)) -gt $title_len ]
        then
            title_right=$(echo $title | cut -c 1-$(($MAX_TITLE_LEN-$title_len+$title_idx)))
            title="$title_left. $title_right"
        else
            title=$title_left
        fi

        title_idx=$((title_idx+1))
        echo $title_idx > "$title_idx_fname"
    else
        rm -rf $TMP_IDX_FOLDER_NAME/*
    fi

    if [ $status == "Playing" ]
    then
        echo -e "  $title"
    else
        echo -e "%{F#A54242}  $title"
    fi
fi
