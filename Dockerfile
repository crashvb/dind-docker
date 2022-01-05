# docker:20.10.12-dind
FROM docker:20.10.12-dind@sha256:4e04836731b7100e8bd5e0b35756f53d0b6211ddb3cc7ec326ae3640adcfa004
LABEL maintainer "Richard Davis <crashvb@gmail.com>"

USER root

# Install packages, download files ...
ADD docker-* entrypoint healthcheck /sbin/
ADD dockerd-wrapper /usr/local/bin/
ADD entrypoint.sh /usr/local/lib/
RUN apk add --no-cache bash && \
	docker-apk curl gettext wget

# Configure: bash profile
ADD bashrc.root /root/.bashrc
RUN sed -e "s/\/ash/\/bash/g" -i /etc/passwd && \
	echo '[[ -n "$BASH_VERSION" && -f "$HOME/.bashrc" ]] && source "$HOME/.bashrc"' > /root/.profile

# Configure: docker
RUN addgroup -S docker

# Configure: entrypoint
RUN mkdir --mode=0755 --parents /etc/entrypoint.d/ /etc/healthcheck.d/ /etc/ssl/private/
ADD entrypoint.dind /etc/entrypoint.d/10dind

# Configure: healthcheck
ADD healthcheck.dind /etc/healthcheck.d/dind

HEALTHCHECK CMD /sbin/healthcheck

ENTRYPOINT ["/sbin/entrypoint"]
CMD ["/usr/local/bin/dockerd-wrapper"]
