#!/usr/bin/env bash
DIR="${1:-.}"

# максимальное количество экземпляров в одном заказе (5-е поле query5)
max=$(tr -d '\r' < "$DIR/query5" | tr -s ' ' | cut -d' ' -f5 | sort -nr | head -1)

echo "Максимальное количество экземпляров в одном заказе: $max"
echo "Товары, заказанные в этом количестве:"

# коды товаров с этим количеством извлекаются из данных автоматически,
# по ним берём названия из каталога query3 (коды нигде не вписываются вручную)
tr -d '\r' < "$DIR/query5" | tr -s ' ' | cut -d' ' -f3,5 \
  | grep " $max\$" | cut -d' ' -f1 | sort -u \
  | while read code; do
      name=$(tr -d '\r' < "$DIR/query3" | grep "^$code!" | cut -d'!' -f2 | sed 's/ *$//')
      echo "    $code: $name"
    done
