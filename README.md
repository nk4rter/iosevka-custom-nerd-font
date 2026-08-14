# Iosevka Custom Nerd Font

Terminal-spacing, sans-serif variant with the `Fira Mono Style (ss05)` character variants,
discretionary ligatures, narrowed and with the leading adjusted to Hack's proportions.

Styles: Regular, Italic, Bold and BoldItalic.

## Versions

| Submodule                                              | Version   |
| ------------------------------------------------------ | --------- |
| [Iosevka](https://github.com/be5invis/Iosevka)         | `v34.8.0` |
| [nerd-fonts](https://github.com/ryanoasis/nerd-fonts)  | `v3.5.0`  |

## Get the sources

Nerd Fonts repo is huge, it's encouraged to use `git submodule update` separately from `git clone`
to make sure the submodule is cloned in a shallow manner.

```sh
git clone https://github.com/nk4rter/iosevka-custom-nerd-font
cd iosevka-custom-nerd-font
git submodule update --init --recursive --depth 1 --progress
```

## Build in Docker

Make sure you have access to the docker daemon, if you haven't done it already
(log out and back in afterwards):

```sh
sudo usermod -aG docker "$USER"
```

Build the docker image:

```sh
docker build -t iosevka-buildenv etc/buildenv
```

Run the build:

```sh
./run-docker/run-docker.sh -R -i iosevka-buildenv ./build.sh
```

## Calculate Iosevka's parameters to match other font's grid

```sh
2>/dev/null ./run-docker/run-docker.sh -R -i iosevka-buildenv ./etc/scripts/font-grid.py \
  nerd-fonts/src/unpatched-fonts/Hack/Hack-Regular.ttf
```

## License

Files in this repo are under MIT license. Iosevka and Nerd Fonts are under their own licenses.
