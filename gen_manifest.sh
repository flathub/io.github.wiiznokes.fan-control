#!/bin/sh

set -e
set -x

new_rev=$(git -C fan-control rev-parse HEAD)


cat io.github.wiiznokes.fan-control.json.template | sed "s/###commit/$new_rev/" > io.github.wiiznokes.fan-control.json


echo 'sha applied successfully'