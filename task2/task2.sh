#!/usr/bin/env bash
DIR="${1:-.}"

norm5=$(tr -d '\r' < "$DIR/query5" | tr -s ' ' | sed 's/^ *//')
maxqty=$(printf '%s\n' "$norm5" | sort -t' ' -k5,5 -nr | head -n1 | cut -d' ' -f5)

echo "Максимальное количество экземпляров товара в одном заказе: $maxqty"
echo "Позиции заказов с этим количеством:"
echo

qre=$(printf '%s\n' "$maxqty" | sed 's/\./\\./g')
printf '%s\n' "$norm5" \
  | grep "^[^ ]* [^ ]* [^ ]* [^ ]* ${qre} " \
  | while read -r pos ord code price qty rest; do
      name=$(tr -d '\r' < "$DIR/query3" | grep "^${code}!" | head -n1 | cut -d'!' -f2 | sed 's/ *$//')
      echo "    заказ № ${ord}: товар «${name}» (код ${code}) — ${qty} шт."
    done
