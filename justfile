branch := "master"


default: setup generate apply-patch

setup:
    rm -rf fan-control
    rm -rf flatpak-builder-tools
    git clone https://github.com/wiiznokes/fan-control.git --branch {{branch}}
    git clone https://github.com/flatpak/flatpak-builder-tools
    pip install aiohttp toml

generate:
    python3 flatpak-builder-tools/cargo/flatpak-cargo-generator.py fan-control/Cargo.lock -o cargo-sources.json

apply-patch:
    ./apply_patch.sh