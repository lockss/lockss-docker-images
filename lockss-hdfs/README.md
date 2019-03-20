# LOCKSS HDFS Docker Image

This Dockerfile defines an Ubuntu-based image that runs a Hadoop 3.0.3-based HDFS cluster with one namenode, one datanode (and one secondary namenode).

## Volumes

This container expects two volumes:

*   A data volume, mounted to `/hadoop` (`$HADOOP_DATA`) *In a LAAWS environment, traditionally this volume is named lockss-hdfs-data.*
*   A logs volume, mounted to `/var/log/hadoop` (`$HADOOP_LOGS`) *In a LAAWS environment, traditionally this volume is named lockss-hdfs-logs.*

## Configuration

Execute `/usr/local/bin/lockss-hdfs-orig-config` or `/usr/local/bin/lockss-hdfs-base-config` (or just `lockss-hdfs-orig-config` or `lockss-hdfs-base-config`, because they are on the `PATH`) and pipe the output to `tar xf -` to obtain and study a recursive copy of, respectively, the unaltered Hadoop configuration directory from the Hadoop installation archive, and the base configuration directory from this image layered on top of its.

The runtime configuration of the cluster is built into `$HADOOP_HOME/etc/hadoop`, by layering three directory structures on top of each other:

*   The unaltered Hadoop configuration durectory from the Hadoop installation archive (found at `$HADOOP_HOME/etc.orig/hadoop`).
*   The base configuration directory from this image (found at `$HADOOP_HOME`)
*   An optional user-supplied configuration directory, mounted at `/usr/local/etc/hadoop` (`$HADOOP_CONF`).

These directories can contains files (and if that's a file found in a previous layer, it shadows the previous version), or templates that are processed with `envsubst` from the environment (where `foo.ext.tpl` gets generated into `foo.ext`).

## Ports

The HDFS file system port 9000 is exposed (and represented in the image by the environment variable `HDFS_FS`). *In a LAAWS environment, traditionally, this port is externally 24619.*
