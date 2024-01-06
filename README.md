# flutterbox

A [Distrobox](https://distrobox.it) image for containerized Flutter installation.

## Usage

Install distrobox and run the following commands:

``` sh
distrobox create -n flutter -i ghcr.io/flexagoon/flutterbox:latest
distrobox enter flutter
distrobox-export --bin /opt/flutter/bin/dart
distrobox-export --bin /opt/flutter/bin/flutter
```

You can now use the `flutter` and `dart` commands from your host system.
