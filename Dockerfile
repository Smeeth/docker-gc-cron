FROM alpine:latest

LABEL maintainer="Eibo Richter <eibo.richter@gmail.com>"
LABEL date="2024-11-01"

ENV DOCKER_GC_GRACE_PERIOD_SECONDS=3600
ENV DOCKER_GC_INTERVAL="0 2 * * *"

RUN apk add --no-cache \
    bash \
    tzdata \
    tini \
    curl \
    git \
    bash \
    docker \
    openrc \

ADD https://raw.githubusercontent.com/spotify/docker-gc/master/docker-gc /usr/bin/docker-gc
COPY build/default-docker-gc-exclude /etc/docker-gc-exclude
COPY build/executed-by-cron.sh /executed-by-cron.sh
COPY build/generate-crontab.sh /generate-crontab.sh

RUN chmod 0755 /usr/bin/docker-gc /generate-crontab.sh /executed-by-cron.sh \
    && chmod 0644 /etc/docker-gc-exclude

HEALTHCHECK --interval=5m --timeout=3s \
  CMD pgrep crond || exit 1

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/bin/sh", "-c", "/generate-crontab.sh && crond -f"]
