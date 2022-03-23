#!/bin/bash

NUM_TRIALS=3
OUTPUT=excuses.txt

n=0
until [ "$n" -gt $NUM_TRIALS ]
do
    excuse=$(curl http://programmingexcuses.com/ -s | grep -oE "<a.+>.+</a>" | sed -E 's:</?a([^>]*)?>::g')
    grep -q "$excuse" "$OUTPUT" || (echo "$excuse" >> "$OUTPUT") && break
    n=$((n+1))
    sleep 30
done

git add "$OUTPUT"
(git commit -m "Updated at $(date -R)" && git push) || echo NONE!
