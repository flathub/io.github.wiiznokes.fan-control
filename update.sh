#!/bin/sh

set -e
set -x

rm -rf fan-control
rm -rf flatpak-builder-tools


git clone https://github.com/wiiznokes/fan-control.git
git clone https://github.com/flatpak/flatpak-builder-tools

pip install aiohttp toml
python3 flatpak-builder-tools/cargo/flatpak-cargo-generator.py fan-control/Cargo.lock -o cargo-sources.json

prev_rev=$(cat rev)
new_rev=$(git -C fan-control rev-parse HEAD)
echo $new_rev > rev

patch=$(cat commit.patch)

patch=$(echo "$patch" | sed "s/###1/$prev_rev/")
patch=$(echo "$patch" | sed "s/###2/$new_rev/")


echo "$patch" | git apply