# LOCKSS IPM Docker Image

This Dockerfile defines a Docker image with IPM, the Idealized Package Manager, a simplistic abstraction for typical Linux package managers. The abstracted operations are:

*   Initial setup (`ipm-setup`)
*   Refresh package data (`ipm-update`)
*   List known packages with description and installation status (`ipm-list`)
*   Install packages (`ipm-install`)
*   Uninstall packages unless originally installed (`ipm-uninstall`)
*   Check if a package is currently installed (`ipm-check`)
*   Check if a package was originally installed (`ipm-originally`)

Use `ipm-list` to learn about packages: `o` for originally installed, `i` for installed, `n` for not installed. Each command displays has a short help message when invoked with `--help`.

In order to work, a conforming implementation must provide:

*   `/usr/local/etc/ipm/ipm-translate.txt`. This file contains one line for each line in `/usr/local/etc/ipm/ipm-packages.txt`, of the form `<ipkg> <tab> <spkg1> <spaces> <spkg2> ... <spaces> <spkgN> <newline>`, where `<ipkg>` is the name of an idealized package, and `<spkg1>`, `<spkg2>`, ..., `<spkgN>` are actual system packages corresponding to the idealized package. The idealized package and the list of system packages are separated by a tab. The system packages are separated by one or more spaces (but not tabs).
*   `ipm-check-impl`: accepts one systempackage name, produces absolutely no output, exits with `0` if the actual package is installed or `>0` otherwise
*   `ipm-install-impl`: accepts one or more system package names, causes the package manager to install them
*   `ipm-uninstall-impl`: accepts one or more system package names, causes the package manager to uninstall them
*   `ipm-update-impl`: causes the package manager to update and reload its package definitions, usually from the network
*   `ipm-clean`: causes the package manager to clear out its cache and other impermanent data

To implement your own, use this image as a build stage, weave your `ipm-*-impl` files, and run `ipm-setup`:

```
# Empty build stage: get lockss-ipm files
FROM lockss/ipm:1 AS lockss-ipm
# Actual build stage
FROM myorg/mylinux:mytag
# Get config files and weave additional config files (e.g. ipm-translate.txt)
COPY --from=lockss-ipm /usr/local/etc/ipm/* /usr/local/etc/ipm/
ADD /local/path/to/etc/* /usr/local/etc/ipm/
# Get executables and weave additional executables (e.g. ipm-*-impl)
COPY --from=lockss-ipm /usr/local/bin/* /usr/local/bin/
ADD local/path/to/bin/* /usr/local/bin/
# Set up IPM
RUN ipm-setup
```

See `lockss-alpine` (`lockss/ubuntu` on Docker Hub) and `lockss-ubuntu` (`lockss/ubuntu` on Docker Hub) for IPM implementations for Alpine and Ubuntu.
