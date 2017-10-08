Liri App Platform for Snap
============

[![License](https://img.shields.io/badge/license-GPLv3.0-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)
[![GitHub release](https://img.shields.io/github/release/lirios/platform-snap.svg)](https://github.com/lirios/platform-snap)
[![Snap Status](https://build.snapcraft.io/badge/lirios/platform-snap.svg)](https://build.snapcraft.io/user/lirios/platform-snap)
[![GitHub issues](https://img.shields.io/github/issues/lirios/platform-snap.svg)](https://github.com/lirios/platform-snap/issues)
[![Maintained](https://img.shields.io/maintenance/yes/2017.svg)](https://github.com/lirios/platform-snap/commits/develop)

Liri App Platform package for [snap][snapcraft-io]. This snap package
serves as bundle for libraries commonly used by Liri Apps.

## Dependencies

* [Ubuntu][ubuntu-com] == 16.04
  * Qt dependencies are currently tailored for 16.04
* [snapcraft][snapcraft-gh]

## Build

From the root of the repository, run:
```sh
snapcraft
```

Note that this will clone and build Qt from source which will take several hours and use
multiple gigabytes of hard disk space.

## Install

From your build directory, run:
```sh
sudo snap install --dangerous liri-platform*.snap
```

## Usage

To run the included [Fluid][fluid-gh] demo:
```sh
snap run liri-platform-<version>.fluid-demo
```

[ubuntu-com]: https://www.ubuntu.com/
[snapcraft-io]: https://snapcraft.io
[snapcraft-gh]: https://github.com/snapcore/snapcraft
[fluid-gh]: http://github.com/lirios/fluid
