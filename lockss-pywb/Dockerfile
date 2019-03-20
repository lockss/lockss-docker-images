# Copyright (c) 2000-2019, Board of Trustees of Leland Stanford Jr. University
# All rights reserved.
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

# webrecorder/pywb:2.2.20190311 is debian:stretch based
FROM lockss/lockss-debian:stretch-20190228-2 AS lockss-debian

FROM lockss/webrecorder-pywb:2.2.20190311-3.6.8-jessie

MAINTAINER "LOCKSS Buildmaster" <buildmaster@lockss.org>

ENV PYWB_COLLECTION=lockss \
    PYWB_HDFSMNT=/mnt/hdfs \
    PYWB_DATA=/webarchive \
    PYWB_PORT=8080

COPY /docker/bin/* /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]

HEALTHCHECK --retries=1 --start-period=60s CMD ["/usr/local/bin/docker-healthcheck"]

# Inherit IPM from lockss-debian
COPY --from=lockss-debian /usr/local/etc/ipm/* /usr/local/etc/ipm/
COPY --from=lockss-debian /usr/local/bin/* /usr/local/bin/
RUN ipm-setup apt-transport-https

# USER directive commented out in webrecorder/pywb:2.2.20190311 
#USER root

# Install curl and add Cloudera signing key
RUN ipm-update \
 && ipm-install curl \
                gnupg \
                netcat \
 && curl -L https://archive.cloudera.com/cdh5/debian/jessie/amd64/cdh/archive.key | apt-key add -

# Add Cloudera repository
COPY /docker/apt/etc/cloudera.list /etc/apt/sources.list.d/
COPY /docker/apt/etc/cloudera.pref /etc/apt/preferences.d/

# Install hadoop-hdfs-fuse
RUN ipm-update \
 && ipm-install-native hadoop-hdfs-fuse \
 && ipm-clean

# Commented out in webrecorder/pywb:2.2.20190311 also
#USER archivist
