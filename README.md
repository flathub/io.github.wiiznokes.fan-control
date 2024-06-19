# How to make a new release

```sh
just
```

# Generate rust sources

```sh
git clone https://github.com/wiiznokes/fan-control.git
git clone https://github.com/flatpak/flatpak-builder-tools
# pip install aiohttp toml
python3 flatpak-builder-tools/cargo/flatpak-cargo-generator.py fan-control/Cargo.lock -o cargo-sources.json
```

# Install flatpak SDKs

```sh
flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --noninteractive --user flathub \
    org.freedesktop.Platform//23.08 \
    org.freedesktop.Sdk//23.08 \
    org.freedesktop.Sdk.Extension.rust-stable//23.08 \
    org.freedesktop.Sdk.Extension.llvm17//23.08
```

# Build and install app

```sh
# sudo apt install flatpak-builder git-lfs
# or flatpak install -y flathub org.flatpak.Builder
flatpak uninstall io.github.wiiznokes.fan-control -y || true

flatpak-builder \
    --force-clean \
    --verbose \
    --ccache \
    --user --install \
    --install-deps-from=flathub \
    --repo=repo \
    flatpak-out \
    io.github.wiiznokes.fan-control.json
```

# Run app

```sh
flatpak run io.github.wiiznokes.fan-control
```

# Udev rules

https://github.com/wiiznokes/fan-control/blob/master/res/linux/udev_rules.md
