#!/usr/bin/env bash
SRC="${1:-input.txt}"

tr -d '\r' < "$SRC" \
  | sed -e 's/^\([^ ]\{1,\}\) \([^ ]\{1,\}\) .*/\1 \2/' \
  | sed '/ /!s/$/=/' > result1.txt

tr -d '\r' < "$SRC" \
  | nl -ba -w1 -s' ' \
  | sed -n 's/^\([0-9]\{1,\}\) [^ ]\{1,\} [^ ]\{1,\} \(.*\)/\1 \2/p' > result2.txt
