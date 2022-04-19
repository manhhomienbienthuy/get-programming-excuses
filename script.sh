#!/bin/bash

NUM_TRIALS=5
OUTPUT=excuses.txt

n=0
until [ $n -ge $NUM_TRIALS ]
do
    echo "TRY $n"
    excuse=$(curl http://programmingexcuses.com/ -s | grep -oE "<a.+>.+</a>" | sed -E 's:</?a([^>]*)?>::g')
    echo "$excuse"
    if ! grep -q "$excuse" "$OUTPUT"; then
        echo "$excuse" >> "$OUTPUT"
        break
    else
        echo "Already taken"
    fi
    n=$((n+1))
    sleep $(( ( RANDOM % 15 )  + 15 ))
done

sort -o "$OUTPUT" "$OUTPUT"
git add "$OUTPUT"
(git commit -m "Updated at $(date -R)" && git push) || echo NONE!
