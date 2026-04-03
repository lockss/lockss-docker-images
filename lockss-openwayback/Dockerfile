# Copyright (c) 2000-2026, Board of Trustees of Leland Stanford Jr. University
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

FROM lockss/lockss-debian9:9.13-slim-6-SNAPSHOT AS lockss-debian9

FROM lockss/lockss-files-log4j:2.25.4-2-SNAPSHOT AS lockss-files-log4j

FROM iipc/openwayback:2.4.1-2-SNAPSHOT

MAINTAINER "LOCKSS Buildmaster" <buildmaster@lockss.org>

ENV LOCKSS_WAIT_FOR_PORT_TIMEOUT=3 \
    LOCKSS_WAIT_FOR_PORT_SLEEP=10 \
    LOCKSS_WAIT_FOR_200_TIMEOUT=3 \
    LOCKSS_WAIT_FOR_200_SLEEP=10 \
    SECRETS=/run/secrets \
    OPENWB_COLLECTION=lockss \
    LOCKSS_LOGS=/var/log/lockss

# Debian 9.13 is too old, its package repositories have been archived
COPY --from=lockss-debian9 /etc/apt/sources.list /etc/apt/sources.list

# Inherit IPM from lockss-debian9
COPY --from=lockss-debian9 /usr/local/etc/ipm/* /usr/local/etc/ipm/
COPY --from=lockss-debian9 /usr/local/bin/* /usr/local/bin/
RUN ipm-setup apt-transport-https

# Log4j mitigation
RUN rm /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/log4j*.jar
COPY --from=lockss-files-log4j /lockss-files-log4j/log4j-api-*.jar \
                               /lockss-files-log4j/log4j-core-*.jar \
                               /lockss-files-log4j/log4j-1.2-api-*.jar \
                               /lockss-files-log4j/jspecify*.jar \
                               /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/

COPY /docker/openwayback/* /usr/local/share/lockss-openwayback/
COPY /docker/bin/* /usr/local/bin/

# Install curl, envsubst, nc and tzdata
RUN ipm-update \
 && ipm-install curl \
                gettext \
                netcat \
                tzdata \
 && ipm-clean

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]
