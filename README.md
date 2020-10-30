# LOCKSS Docker Images

This project is a collection of utility Docker images used in the making of the LOCKSS 2.0 suite of containerized software.

*   The `master` branch contains a stable codebase.
*   The `develop` branch contains the day-to-day development work.

## IPM Base Image

The `lockss-ipm` image implements IPM, the "Idealized Package Manager", a simplistic abstraction for the package managers of various flavors of Linux for use by the various [base OS images](#base-os-images).

*   [`lockss-ipm`](lockss-ipm)

## Base OS Images

These base OS images have IPM and a few other needful elements.

*   [`lockss-alpine`](lockss-alpine) ([Alpine Linux](https://alpinelinux.org/))
*   [`lockss-centos`](lockss-centos) ([CentOS](https://www.centos.org/))
*   [`lockss-debian`](lockss-debian) ([Debian](https://www.debian.org/))
*   [`lockss-ubuntu`](lockss-ubuntu) ([Ubuntu](https://ubuntu.com/))

## LOCKSS Spring Base Image

The `lockss-spring` image contains a JRE and sets up an environment common to all LOCKSS 2.0 containers, which are based on the Spring Framework.

*   [`lockss-spring`](lockss-spring)

## Repackaged Applications

This collection of images contains versions of official images repackaged to have startup scripts or apply custom settings that fit the LOCKSS 2.0 cluster. These include:

*   [`lockss-hdfs`](lockss-hdfs) ([Apache Hadoop HDFS](http://hadoop.apache.org/)) (experimental)
*   [`lockss-openwayback`](lockss-openwayback) ([OpenWayback](https://github.com/iipc/openwayback))
*   [`lockss-pywb`](lockss-pywb) ([Pywb](https://github.com/webrecorder/pywb))

## LOCKSS on Docker Hub

You can find the LOCKSS Program on [Docker Hub](https://hub.docker.com/) in the [`lockss` organization](https://hub.docker.com/u/lockss).