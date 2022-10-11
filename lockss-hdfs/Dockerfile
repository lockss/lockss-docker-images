# Copyright (c) 2000-2022, Board of Trustees of Leland Stanford Jr. University
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
# this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its contributors
# may be used to endorse or promote products derived from this software without
# specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

FROM lockss/lockss-ubuntu:xenial-20190222-1

MAINTAINER "LOCKSS Buildmaster" <buildmaster@lockss.org>

# JAVA_HOME depends on the Linux flavor
ENV HDFS_JNHTTP=8480 \
    HDFS_JNHTTPS=8481 \
    HDFS_JN=8485 \
    HDFS_FS=9000 \
    HDFS_DNHTTP=9864 \
    HDFS_DNHTTPS=9865 \
    HDFS_DN=9866 \
    HDFS_DNIPC=9867 \
    HDFS_SNNHTTP=9868 \
    HDFS_SNNHTTPS=9869 \
    HDFS_NNHTTP=9870 \
    HDFS_NNHTTPS=9871 \
    HDFS_BNN=50100 \
    HDFS_BNNHTTP=50105 \
    JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk \
    HADOOP_HOME=/usr/local/share/hadoop \
    HADOOP_DATA=/hadoop \
    HADOOP_CONF=/usr/local/etc/hadoop \
    HADOOP_LOGS=/var/log/hadoop \
    HADOOP_PIDS=/var/run

EXPOSE ${HDFS_FS}

# Install packages
RUN ipm-update \
 && ipm-install bash \
                gettext \
                openjdk8-jre \
                openssh-client \
                openssh-server \
 && ipm-clean \
 && cp /etc/ssh/ssh_config /etc/ssh/ssh_config.orig \
 && cp /etc/ssh/sshd_config /etc/ssh/sshd_config.orig
COPY /docker/ssh/etc/* /etc/ssh/

# Install Hadoop + make root use Bash + clean up
COPY /docker/temp/* /tmp/tmpfiles/
RUN tar xzf /tmp/tmpfiles/hadoop.tgz -C /usr/local/share \
 && ln -s /usr/local/share/hadoop-* "${HADOOP_HOME}" \
 && cd "${HADOOP_HOME}" \
 && mv etc etc.orig \
 && mkdir -p etc.base \
 && sed -i.orig -e 's@^\(root:.*:\)[^:]\+$@\1/bin/bash@' /etc/passwd \
 && rm -rf /tmp/tmpfiles
COPY /docker/hadoop/etc/* /usr/local/share/hadoop/etc.base/hadoop/

# Add scripts including entry point and health check
COPY /docker/bin/* /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]

HEALTHCHECK --retries=1 --start-period=60s CMD ["/usr/local/bin/docker-healthcheck"]
