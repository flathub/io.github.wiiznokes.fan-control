branch := "master"


default: setup sources-gen manifest-gen

setup:
    rm -rf fan-control
    rm -rf flatpak-builder-tools
    git clone https://github.com/wiiznokes/fan-control.git --branch {{branch}}
    git clone https://github.com/flatpak/flatpak-builder-tools
    pip install aiohttp toml

sources-gen:
    python3 flatpak-builder-tools/cargo/flatpak-cargo-generator.py fan-control/Cargo.lock -o cargo-sources.json

manifest-gen:
    ./gen_manifest.sh

install-sdk:
    flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install --noninteractive --user flathub \
        org.freedesktop.Platform//23.08 \
        org.freedesktop.Sdk//23.08 \
        org.freedesktop.Sdk.Extension.rust-stable//23.08 \
        org.freedesktop.Sdk.Extension.llvm17//23.08

uninstall:
    flatpak uninstall io.github.wiiznokes.fan-control -y || true

# deps: flatpak-builder git-lfs
build-and-install: uninstall
    flatpak-builder \
        --force-clean \
        --verbose \
        --ccache \
        --user --install \
        --install-deps-from=flathub \
        --repo=repo \
        flatpak-out \
        io.github.wiiznokes.fan-control.json

run:
    flatpak run io.github.wiiznokes.fan-control