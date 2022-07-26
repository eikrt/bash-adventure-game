#!/bin/bash
WORLD_SIZE=$1
SEA_LEVEL=0.7
TILES_PATH="../world/tiles.csv"
echo "id,x,y,type" > $TILES_PATH
perlin_table=$(./perlin $WORLD_SIZE $WORLD_SIZE)
for ((i=1;i<=WORLD_SIZE;i++)); do
    for ((j=1;j<=WORLD_SIZE;j++)); do
        tile_height=$(echo "$perlin_table" |awk -v x=$i -v y=$j 'BEGIN { FS="," } NR==y{print $x}')
        tile_type="sand"
        id=$RANDOM
        if (( $(echo "tile_height > $SEA_LEVEL" |bc -l) )); then
            $tile_type = "rock"
        fi
        echo "$id,$j,$i,$tile_height,$tile_type" > $TILES_PATH
    done 
done 
