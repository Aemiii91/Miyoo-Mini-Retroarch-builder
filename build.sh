#!/bin/bash
script_dir=$(
    cd -- "$(dirname "$0")" > /dev/null 2>&1
    pwd -P
)
recipe="$script_dir/$1/libretro-cores"
build_name=$(basename "$1")
build_dir="$script_dir/build/$build_name"

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

rm -rf libretro-super/dist/unix
