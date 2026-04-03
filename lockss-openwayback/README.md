# LOCKSS OpenWayback Docker Image

This Dockerfile is used to build the LOCKSS-customized OpenWayback Docker image based on a fork of `iipc/openwayback`.

# Building

1. Download the latest `lockss/lockss-ipm` and `lockss/lockss-debian9` Docker images into your development environment.
   Alternatively, build these images (recommended).
2. Build the `iipc/openwayback:2.4.1-1-SNAPSHOT` image from our clone of the official IIPC project:
   * `git clone git@github.com:lockss/openwayback.git && cd openwayback`
   * `git switch feature-basicauth`
   * `docker build -t 'iipc/openwayback:2.4.1-1-SNAPSHOT' .`
3. Build the `lockss/lockss-openwayback` Docker image:
   * `cd lockss-docker-images/lockss-openwayback`
   * `bin/build`