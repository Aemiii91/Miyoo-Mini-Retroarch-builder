#!/bin/bash

script_dir=$(cd -- "$(dirname "$0")" > /dev/null 2>&1 && pwd -P)
recipe_dir="$script_dir/$1"
build_name=$(basename "$1")
build_dir="$script_dir/build/$build_name"
recipe="$recipe_dir/libretro-cores"

# Detect CSV recipe and convert if needed
if [ -f "$recipe_dir/libretro-cores.csv" ]; then
    "$script_dir/csv2recipe.py" "$recipe_dir/libretro-cores.csv" "$recipe"
elif [ ! -f "$recipe" ]; then
    echo "Error: No valid recipe found in $recipe_dir"
    exit 1
fi

cd "$script_dir/libretro-super"
./libretro-buildbot-recipe.sh "$recipe"

mkdir -p "$build_dir"

cd dist/unix
for i in *.so; do
    info_file="../info/${i%.*}.info"
    if [ -f "$info_file" ]; then
        cp "$info_file" "$build_dir"
    fi
done

ls -lah ./

cd "$script_dir"
cp -arf libretro-super/dist/unix/. "$build_dir"

rm "$recipe"
