#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage: $0 <URL>"
	exit 1
fi

url="$1"

filename=$(curl -s "$url" | grep -oP 'Filename:\s+\K.+')

echo "$filename"
