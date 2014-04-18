#!/bin/bash
# Converts an image in a multi-resolution favicon
# Requires Imagemagick

if [[ "$#" != "2" ]]; then
    echo "Usage: $0 input.png output.ico" >&2
    exit 1
fi

input="$1"
output="$2"
sizes="16 32 64 128 256"
tmp_dir=$(mktemp -d /tmp/favicon.XXXXXXXXXX)
files=""

for size in $sizes; do
    file="$tmp_dir/$size.png"
    convert "$input" -resize "${size}x${size}" -background transparent -colors 256 -flatten "$file"
    files="$files $file"
done

convert $files $output
rm -R $tmp_dir
