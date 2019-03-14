# LOCKSS Spring Base Image

This Dockerfile defines a base Docker image based on Alpine Linux 3.9, that encapsulates a LOCKSS service JAR built on the Spring Framework.

## Docker Build Arguments

Mandatory build arguments in the child:

*   `LOCKSS_MAVEN_GROUP`: the Maven `groupId` of the encapsulated JAR
*   `LOCKSS_MAVEN_ARTIFACT`: the Maven `artifactId` of the encapsulated JAR
*   `LOCKSS_MAVEN_VERSION`: the Maven `version` of the encapsulated JAR
*   `LOCKSS_REST_PORT`: the REST port of the encapsulated service

Optional build arguments in the child:

*   `LOCKSS_UI_PORT`: the HTTP port of the encapsulated service's LOCKSS UI

*The `lockss-parent-pom` POM file used to build LOCKSS services passes these values accordingly to the Docker build.*

## Environment Variables

The following environment variables are defined:

*   `CONFIGS`: the expected root of Docker configs (`/run/configs`); see **Docker Configs**
*   `LOCKSS_HOME`: the service installation directory (`/usr/local/share/lockss`)
*   `LOCKSS_PIDS`: the PID directory for `lockss.pid` (`/var/run`)
*   `LOCKSS_DATA`: the data directory (`/data`); see **Docker Volumes**
*   `LOCKSS_LOGS`: the log directory (`/var/log/lockss`); see **Docker Volumes**

### LOCKSS Configuration Service

If the encapsulated service is the LOCKSS Configuration Service, the environment variable `LOCKSS_IS_CONFIG` should be set to `true`, and the environment variable `LOCKSS_PROPS_URL` should be set to the correct value.

### Other Services

If the encapsulated service is not the LOCKSS Configuration Service, the environment variable `LOCKSS_CONFIG_URL` should be set to the LOCKSS Configuration Service's API URL stem.

## Docker Volumes

The container expects two volumes:

*   A data volume, mounted at `/data` (`$LOCKSS_DATA`). *In a LAAWS environment, this volume is typically called `lockss-<svc>-data` for some service abbreviate `<svc>`.*
*   A logs volume, mounted at `/var/log/lockss` (`$LOCKSS_LOGS`). *In a LAAWS environment, this volume is typically called `lockss-<svc>-logs` for some service abbreviate `<svc>`.*

## Docker Configs

The container expects a number of Docker configs.

**These are found under `/run/configs` (`$CONFIGS`) rather than the default `/`. Use the long form of `configs:` in the Compose file.**

*   A bootstrap config file named `lockss_bootstrap` (`/run/configs/lockss_bootstrap`)
*   If the service is the LOCKSS Configuration Service, a cluster config file named `lockss_cluster` (`/run/configs/lockss_cluster`); see **LOCKSS Configuration Service**
*   A service config file named `lockss_service` (`/run/configs/lockss_service`)
*   An optional service config user file named `lockss_service_opt` (`/run/configs/lockss_service_configs`)
