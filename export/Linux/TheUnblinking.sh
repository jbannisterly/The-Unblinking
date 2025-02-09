#!/bin/sh
echo -ne '\033c\033]0;GameJam2025\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/TheUnblinking.x86_64" "$@"
