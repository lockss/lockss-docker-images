
## Conforming Implementation

A conforming implementation needs to provide the following executables:

*   `ipm-check-impl`: accepts one actual package name, produces absolutely no
    output, exits with `0` if the actual package is installed or `>0` otherwise
*   `ipm-clean`: causes the package manager to clear out its cache and other
     impermanent data
*   `ipm-install-impl`: accepts one or more actual package names, causes the
    package manager to install them
*   `ipm-uninstall`: accepts one or more actual package names, causes the
    package manager to uninstall them
*   `ipm-update`: cases the package manager to update and reload its package
    definitions, usually from the network

Additionally, a conforming implementation needs to provide the file
`/etc/ipm/ipm-translate.txt`. This file contains lines of the form:

```
<ipkg> <tab> <apkg> <newline>
```

where `<ipkg>` is the name of an idealized package from `/etc/ipm-packages.txt`,
and `<apkg>` is the corresponding actual package.
