#!/bin/bash
CHUNK_SIZE=16
WORLD_SIZE=2
SEA_LEVEL=0.6
for ((k=1;k<=WORLD_SIZE;k++)); do
    for ((l=1;l<=WORLD_SIZE;l++)); do
        chunk_x=$(( WORLD_SIZE - $k ))
        chunk_y=$(( WORLD_SIZE - $l ))
        chunk_path="../world/chunks/chunk_${k}_${l}"
        echo -n "" > "$chunk_path"
        perlin_table=$(./perlin $CHUNK_SIZE $k $l)
        for ((i=1;i<=CHUNK_SIZE;i++)); do
            for ((j=1;j<=CHUNK_SIZE;j++)); do
                inverted_x=$(( $CHUNK_SIZE + 1 - $i ))
                tile_height=$(echo "$perlin_table" |awk -v x=$inverted_x -v y=$j 'BEGIN { FS="," } NR==y{print $x}')
                symbol=" "
                id=$RANDOM
                if (( $(echo "$tile_height > $SEA_LEVEL" |bc -l) )); then
                    symbol="~"
                fi
                echo -n "$symbol" >> "$chunk_path" 
            done
            echo "" >> "$chunk_path"
        done
    done 
done 
