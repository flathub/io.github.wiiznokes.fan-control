#!/bin/sh

set -e
set -x

prev_rev=$(cat rev)
new_rev=$(git -C fan-control rev-parse HEAD)

patch=$(cat commit.patch)

patch=$(echo "$patch" | sed "s/###1/$prev_rev/")
patch=$(echo "$patch" | sed "s/###2/$new_rev/")



echo "$patch" | git apply

echo $new_rev > rev

echo 'sha applied successfully'