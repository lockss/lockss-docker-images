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

FROM lockss/lockss-debian11:11.1-slim-SNAPSHOT AS lockss-debian11

FROM lockss/lockss-files-log4j:2.17.1-2-SNAPSHOT AS lockss-files-log4j

FROM solr:8.9.0-slim

MAINTAINER "LOCKSS Buildmaster" <buildmaster@lockss.org>

USER root

# Inherit IPM from lockss-debian11
COPY --from=lockss-debian11 /usr/local/etc/ipm/* /usr/local/etc/ipm/
COPY --from=lockss-debian11 /usr/local/bin/* /usr/local/bin/
RUN ipm-setup apt-transport-https

# Install curl and tzdata
RUN ipm-update \
 && ipm-install curl \
                tzdata \
 && ipm-clean

# Log4j mitigation
RUN rm /opt/solr-8.9.0/server/lib/ext/log4j*.jar
COPY --from=lockss-files-log4j /lockss-files-log4j/log4j-1.2-api-*.jar \
                               /lockss-files-log4j/log4j-api-*.jar \
                               /lockss-files-log4j/log4j-core-*.jar \
                               /lockss-files-log4j/log4j-slf4j-impl-*.jar \
                               /lockss-files-log4j/log4j-web-*.jar \
                               /opt/solr-8.9.0/server/lib/ext/
RUN rm /opt/solr-8.9.0/contrib/prometheus-exporter/lib/log4j*.jar
COPY --from=lockss-files-log4j /lockss-files-log4j/log4j-api-*.jar \
                               /lockss-files-log4j/log4j-core-*.jar \
                               /lockss-files-log4j/log4j-slf4j-impl-*.jar \
                               /opt/solr-8.9.0/contrib/prometheus-exporter/lib/

COPY /docker/bin/* /usr/local/bin/

USER solr
