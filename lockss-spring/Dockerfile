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

FROM lockss/lockss-alpine:3.15.0 as lockss-alpine

FROM adoptopenjdk/openjdk8:jdk8u292-b10-alpine

COPY --from=lockss-alpine /usr/local/etc/ipm/* /usr/local/etc/ipm/
COPY --from=lockss-alpine /usr/local/bin/* /usr/local/bin/
RUN ipm-setup

#
# MANDATORY BUILD ARGUMENTS (CHILD)
#

ONBUILD ARG LABEL_BUILD_DATE
ONBUILD ARG LABEL_DESCRIPTION
ONBUILD ARG LABEL_GIT_DIRTY
ONBUILD ARG LABEL_LOCKSS_RELEASE
ONBUILD ARG LABEL_MAVEN_ARTIFACT
ONBUILD ARG LABEL_MAVEN_GROUP
ONBUILD ARG LABEL_MAVEN_VERSION
ONBUILD ARG LABEL_NAME
ONBUILD ARG LABEL_URL
ONBUILD ARG LABEL_VCS_REF
ONBUILD ARG LABEL_VCS_URL
ONBUILD ARG LABEL_VENDOR
ONBUILD ARG LABEL_VERSION
ONBUILD RUN test -n "${LABEL_BUILD_DATE}"     || exit  1 \
         && test -n "${LABEL_DESCRIPTION}"    || exit  2 \
         && test -n "${LABEL_GIT_DIRTY}"      || exit  3 \
         && test -n "${LABEL_LOCKSS_RELEASE}" || exit  4 \
         && test -n "${LABEL_MAVEN_ARTIFACT}" || exit  5 \
         && test -n "${LABEL_MAVEN_GROUP}"    || exit  6 \
         && test -n "${LABEL_MAVEN_VERSION}"  || exit  7 \
         && test -n "${LABEL_NAME}"           || exit  8 \
         && test -n "${LABEL_URL}"            || exit  9 \
         && test -n "${LABEL_VCS_REF}"        || exit 10 \
         && test -n "${LABEL_VCS_URL}"        || exit 11 \
         && test -n "${LABEL_VENDOR}"         || exit 12 \
         && test -n "${LABEL_VERSION}"        || exit 13

#
# ENVIRONMENT VARIABLES (CHILD)
#

ONBUILD ENV LABEL_MAINTAINER="buildmaster@lockss.org" \
            LABEL_SCHEMA_VERSION="1.0" \
            \
            LABEL_BUILD_DATE="${LABEL_BUILD_DATE}" \
            LABEL_DESCRIPTION="${LABEL_DESCRIPTION}" \
            LABEL_GIT_DIRTY="${LABEL_GIT_DIRTY}" \
            LABEL_LOCKSS_RELEASE="${LABEL_LOCKSS_RELEASE}" \
            LABEL_MAVEN_ARTIFACT="${LABEL_MAVEN_ARTIFACT}" \
            LABEL_MAVEN_GROUP="${LABEL_MAVEN_GROUP}" \
            LABEL_MAVEN_VERSION="${LABEL_MAVEN_VERSION}" \
            LABEL_NAME="${LABEL_NAME}" \
            LABEL_URL="${LABEL_URL}" \
            LABEL_VCS_REF="${LABEL_VCS_REF}" \
            LABEL_VCS_URL="${LABEL_VCS_URL}" \
            LABEL_VENDOR="${LABEL_VENDOR}" \
            LABEL_VERSION="${LABEL_VERSION}"

#
# LABELS (CHILD)
#

ONBUILD LABEL maintainer="${LABEL_MAINTAINER}" \
              org.label-schema.schema-version="${LABEL_SCHEMA_VERSION}" \
              \
              org.label-schema.build-date="${LABEL_BUILD_DATE}" \
              org.label-schema.description="${LABEL_DESCRIPTION}" \
              org.lockss.label.git-dirty="${LABEL_GIT_DIRTY}" \
              org.lockss.label.lockss-release="${LABEL_LOCKSS_RELEASE}" \
              org.lockss.label.maven-artifact="${LABEL_MAVEN_ARTIFACT}" \
              org.lockss.label.maven-group="${LABEL_MAVEN_GROUP}" \
              org.lockss.label.maven-version="${LABEL_MAVEN_VERSION}" \
              org.label-schema.name="${LABEL_NAME}" \
              org.label-schema.url="${LABEL_URL}" \
              org.label-schema.vcs-ref="${LABEL_VCS_REF}" \
              org.label-schema.vcs-url="${LABEL_VCS_URL}" \
              org.label-schema.vendor="${LABEL_VENDOR}" \
              org.label-schema.version="${LABEL_VERSION}"

# Obsolete?
ONBUILD EXPOSE ${LOCKSS_REST_PORT} ${LOCKSS_UI_PORT}

# Environment variables
ENV LOCKSS_WAIT_FOR_PORT_TIMEOUT=5 \
    LOCKSS_WAIT_FOR_PORT_SLEEP=5 \
    LOCKSS_WAIT_FOR_200_TIMEOUT=5 \
    LOCKSS_WAIT_FOR_200_SLEEP=5 \
    CONFIGS=/run/configs \
    SECRETS=/run/secrets \
    LOCKSS_HOME=/usr/local/share/lockss \
    LOCKSS_PIDS=/var/run \
    LOCKSS_DATA=/data \
    LOCKSS_TMP=/tmp/lockss \
    LOCKSS_LOGS=/var/log/lockss \
    LOCKSS_USER=lockss \
    LOCKSS_GROUP=lockss

WORKDIR /tmp

RUN ipm-update \
 && ipm-install curl \
                gettext \
                jq \
                netcat \
                tzdata \
 && ipm-clean \
 && mkdir -m 0755 "${LOCKSS_HOME}" \
 && mkdir -m 0777 "${LOCKSS_HOME}/etc"

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]

#HEALTHCHECK --retries=1 --start-period=60s CMD ["/usr/local/bin/docker-healthcheck"]

COPY /docker/bin/* /usr/local/bin/
COPY /docker/lockss/etc.base/* "${LOCKSS_HOME}/etc.base/"
ONBUILD COPY /docker/lockss/etc.base/* "${LOCKSS_HOME}/etc.base/"
ONBUILD COPY /target/current-with-deps.jar "${LOCKSS_HOME}/lib/lockss.jar"
