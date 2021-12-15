# Copyright (c) 2000-2021, Board of Trustees of Leland Stanford Jr. University
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

# FIXME

FROM lockss/lockss-alpine:3.15.0-SNAPSHOT AS lockss-alpine

FROM lockss/lockss-files-log4j:2.16.0-SNAPSHOT AS lockss-files-log4j

FROM solr:7.2.1-alpine

MAINTAINER "LOCKSS Buildmaster" <buildmaster@lockss.org>

# Inherit IPM from lockss-alpine
COPY --from=lockss-alpine /usr/local/etc/ipm/* /usr/local/etc/ipm/
COPY --from=lockss-alpine /usr/local/bin/* /usr/local/bin/
USER root
RUN ipm-setup

# Install curl and tzdata
RUN ipm-update \
 && ipm-install curl \
                tzdata \
 && ipm-clean
USER solr

# Log4j mitigation
RUN rm /opt/solr/server/lib/ext/log4j*.jar
COPY --from=lockss-files-log4j /lockss-files-log4j/log4j*.jar /opt/solr/server/lib/ext/

COPY /docker/bin/* /usr/local/bin/

 