# flutterbox

A [Distrobox](https://distrobox.it) image for containerized Flutter installation.

Based on [boxkit](https://github.com/ublue-os/boxkit)

## Usage

Install distrobox and run the following commands:

``` sh
distrobox create -n flutter -i ghcr.io/flexagoon/flutterbox:latest --home ~/.local/share/flutterbox
distrobox enter flutter
distrobox-export --bin /usr/bin/dart
distrobox-export --bin /usr/bin/flutter
```

**NOTE:** You need to make sure that the `~/.local/share/flutterbox` directory is empty before you install flutterbox. There are multiple configuration files in `/etc/skel` which only get copied when a new home directory is created.

You can now use the `flutter` and `dart` commands from your host system.
