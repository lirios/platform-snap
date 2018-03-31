Liri App Platform for Snap
==========================

[![License](https://img.shields.io/badge/license-GPLv3.0-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)
[![GitHub release](https://img.shields.io/github/release/lirios/platform-snap.svg)](https://github.com/lirios/platform-snap)
[![Build Status](https://travis-ci.org/lirios/platform-snap.svg?branch=develop)](https://travis-ci.org/lirios/platform-snap)
[![GitHub issues](https://img.shields.io/github/issues/lirios/platform-snap.svg)](https://github.com/lirios/platform-snap/issues)
[![Maintained](https://img.shields.io/maintenance/yes/2017.svg)](https://github.com/lirios/platform-snap/commits/develop)

Liri App Platform package for [snap][snapcraft-io]. This snap package
serves as bundle for libraries commonly used by Liri Apps.

## Dependencies

* [Docker][docker-com]

## Build

It is recommended to use Docker to build the platform snap.

From the root of the repository, run:

```bash
docker run --privileged --rm -ti -v $(pwd):/home --workdir /home liridev/ci-ubuntu bash
```

Then, inside the container, run:

```bash
apt install snapcraft
snapcraft
```

## Install

From your build directory, run:

```bash
sudo snap install --dangerous liri-platform*.snap
```

## Usage

To run the included [Fluid][fluid-gh] demo:

```bash
snap run liri-platform-<version>.fluid-demo
```

[docker-com]: https://www.docker.com/
[snapcraft-io]: https://snapcraft.io
[snapcraft-gh]: https://github.com/snapcore/snapcraft
[fluid-gh]: http://github.com/lirios/fluid
