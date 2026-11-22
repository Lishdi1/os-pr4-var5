#!/usr/bin/env bash
DIR="${1:-/student}"
find "$DIR" -maxdepth 1 -type f ! -type l | wc -l
