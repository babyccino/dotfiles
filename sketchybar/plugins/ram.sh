#!/bin/bash

memory_stats=$(vm_stat)

pages_active=$(echo "$memory_stats" | awk '/Pages active:/ {print $3}' | tr -d '.')
pages_wired=$(echo "$memory_stats" | awk '/Pages wired down:/ {print $4}' | tr -d '.')
pages_compressed=$(echo "$memory_stats" | awk '/Pages occupied by compressor:/ {print $5}' | tr -d '.')
pages_inactive=$(echo "$memory_stats" | awk '/Pages inactive:/ {print $3}' | tr -d '.')

total_used_pages=$((pages_active + pages_wired + pages_compressed + pages_inactive))

memory_gb=$(echo "scale=1; $total_used_pages * $(pagesize) / 1024^3" | bc)

sketchybar --set $NAME label="$memory_gb GB"
