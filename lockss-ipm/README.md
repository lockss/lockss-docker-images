# LOCKSS IPM Docker Image

This Dockerfile defines a Docker image with IPM, the Idealized Package Manager, a simplistic abstraction for typical Linux package managers. The abstracted operations are:

*   Initial setup (`ipm-setup`)
*   Refresh package definitions (`ipm-update`)
*   List known packages (`ipm-list`)
*   Upgrade installed packages (`ipm-upgrade`)
*   Install packages (`ipm-install`)
*   Uninstall packages unless originally installed (`ipm-uninstall`)
*   Clear out cache and impermanent data (`ipm-clean`)
*   Check if a package is currently installed (`ipm-check`)
*   Check if a package was originally installed (`ipm-originally`)

Use `ipm-list` to learn about packages: `o` for originally installed, `i` for installed, `n` for not installed. Each command displays a short help message when invoked with `--help`.

## How To Use

See `lockss/lockss-alpine`, `lockss/lockss-centos` and `lockss/lockss-ubuntu` for IPM implementations for Alpine, CentOS and Ubuntu, respectively.

If you want to start from these base images, simply use them, for example:

```
FROM lockss/lockss-alpine:3.9

RUN ipm-update && ipm-install python3 && ipm-clean
```

If you want to use your existing Dockerfile based on the same OSes, you can install the IPM portions, for instance:

```
FROM lockss/lockss-alpine:3.9 as lockss-ipm

FROM myorg/myalpine:mytag

COPY --from=lockss-ipm /usr/local/etc/ipm/* /usr/local/etc/ipm/
COPY --from=lockss-ipm /usr/local/bin/* /usr/local/bin/

RUN ipm-update && ipm-install python3 && ipm-clean
```

## How To Implement

In order to work, a conforming implementation must provide:

*   `ipm-translate.txt`. This file contains one line for each line in `/usr/local/etc/ipm/ipm-packages.txt`, of the form `<ipkg> <tab> <npkg1> <spaces> <npkg2> ... <spaces> <npkgN> <newline>`, where `<ipkg>` is the name of an idealized package, and `<npkg1>`, ..., `<npkgN>` are native packages corresponding to the idealized package. The idealized package and the list of native packages are separated by a tab. The native packages are separated by one or more spaces (but not tabs).
*   `ipm-update-native`: causes the package manager to refresh its package definitions
*   `ipm-upgrade-native`: causes the package manager to upgrade installed packages
*   `ipm-install-native`: accepts one or more native package names, causes the package manager to install them
*   `ipm-uninstall-native`: accepts one or more native package names, causes the package manager to uninstall them
*   `ipm-clean-native`: causes the package manager to clear out its cache and other impermanent data
*   `ipm-check-native`: accepts one native package name, produces absolutely no output, exits with `0` if the native package is installed or `>0` otherwise

The `ipm-translate.txt` file is expected to be `docker/ipm/etc/ipm-translate.txt` in the build context.

The various `ipm-*-native` executables are expected to be in `docker/ipm/bin/` in the build context.

A typical Dockerfile looks like this:

```
FROM lockss/ipm:2.0 AS lockss-ipm

FROM myorg/mylinux:mytag

# Install IPM
COPY --from=lockss-ipm /usr/local/etc/ipm/* /usr/local/etc/ipm/
COPY --from=lockss-ipm /usr/local/bin/* /usr/local/bin/

# Set up IPM
RUN ipm-setup npkg1 npkg2
```

where `npkg1`, `npkg2`... are additional native packages to be installed at the same time.

### Dependencies

Note that IPM depends on a POSIX shell and:

*   `awk`
*   `which` (not pre-installed in `centos:7.6.1810`)
