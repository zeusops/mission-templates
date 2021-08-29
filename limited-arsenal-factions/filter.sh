#!/bin/bash

set -euo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: $(basename $0) FILE"
    echo "FILE: filename to filter"
    echo "Filters lines not included in the blank template"
    exit 1
fi

file=$1

BLANK=00-blank.txt

previous_line=""

echo \[
while read line; do
    if [ "$line" == "[" ] || [ "$line" == "]" ]; then
        continue
    fi
    if [ ! -z "$previous_line" ]; then
        echo "$previous_line",
    fi
    class=$(echo $line | sed 's/,//')
    if ! grep -q "$line" "$BLANK"; then
        previous_line="$class"
    else
        previous_line=""
    fi
done < $file
echo "$previous_line"
echo \]
