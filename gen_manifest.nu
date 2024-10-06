#!/usr/bin/env nu

let new_rev = (git -C fan-control rev-parse HEAD)

let manifest = "io.github.wiiznokes.fan-control.json"

open $manifest | update modules.2.sources.0.commit $new_rev | to json | save -f $manifest

echo 'sha applied successfully'