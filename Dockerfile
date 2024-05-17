FROM crashvb/base:22.04-202402150049@sha256:2cff2d14bc6af6e394356da2794a81a4799228c712d6739fcf12ccf7d0a58006 AS parent

FROM docker:26.1.3-dind@sha256:ca2dd9db425230285567123ce06dbd3c2aed0eae23d58a1dd5787523a4329eea
ARG org_opencontainers_image_created=undefined
ARG org_opencontainers_image_revision=undefined
LABEL \
	org.opencontainers.image.authors="Richard Davis <crashvb@gmail.com>" \
	org.opencontainers.image.base.digest="sha256:ca2dd9db425230285567123ce06dbd3c2aed0eae23d58a1dd5787523a4329eea" \
	org.opencontainers.image.base.name="docker:26.1.3-dind" \
	org.opencontainers.image.created="${org_opencontainers_image_created}" \
	org.opencontainers.image.description="Image containing docker." \
	org.opencontainers.image.licenses="Apache-2.0" \
	org.opencontainers.image.source="https://github.com/crashvb/dind-docker" \
	org.opencontainers.image.revision="${org_opencontainers_image_revision}" \
	org.opencontainers.image.title="crashvb/dind" \
	org.opencontainers.image.url="https://github.com/crashvb/dind-docker"

# hadolint ignore=DL3002
USER root

# Install packages, download files ...
COPY --from=parent /sbin/entrypoint /sbin/healthcheck /sbin/
COPY --from=parent /usr/local/lib/entrypoint.sh /usr/local/lib/
COPY alpine-fixes docker-* /sbin/
COPY dockerd-wrapper /usr/local/bin/
# hadolint ignore=DL3018
RUN apk add --no-cache bash && \
	docker-apk curl gettext wget && \
	alpine-fixes

# Configure: bash profile
COPY bashrc.root /root/.bashrc
# hadolint ignore=SC2016
RUN sed -e "s|/ash|/bash|g" -i /etc/passwd && \
	echo '[[ -n "$BASH_VERSION" && -f "$HOME/.bashrc" ]] && source "$HOME/.bashrc"' > /root/.profile

# Configure: entrypoint
# hadolint ignore=DL3059,SC2174
RUN mkdir --mode=0755 --parents /etc/entrypoint.d/ /etc/healthcheck.d/ /etc/ssl/private/
COPY entrypoint.dind /etc/entrypoint.d/dind

# Configure: healthcheck
COPY healthcheck.dind /etc/healthcheck.d/dind

HEALTHCHECK CMD /sbin/healthcheck

ENTRYPOINT ["/sbin/entrypoint"]
CMD ["/usr/local/bin/dockerd-wrapper"]
