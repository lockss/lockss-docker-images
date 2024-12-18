# LOCKSS OpenWayback Docker Image

This Dockerfile defines a slightly LOCKSS-specialized OpenWayback Docker image based on `iipc/openwayback`.

See Docker Hub for available tags: <https://hub.docker.com/r/lockss/lockss-openwayback>

# Building

1. Build (github:lockss/)openwayback/openwayback-core with Java 8
2. Copy openwayback/openwayback-core/target/openwayback-core-2.4.0.jar to lockss-docker-images/lockss-openwayback/docker/openwayback-core
3. bin/build