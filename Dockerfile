# Erste Phase: Installieren der Abhängigkeiten
FROM alpine:3.20.3 AS builder

LABEL maintainer="Eibo Richter <eibo.richter@gmail.com>"
LABEL version="0.1.0"
LABEL date="2024-11-01"

# Installieren der erforderlichen Pakete
RUN apk add --no-cache \
    bash \
    docker \
    git \
    openrc \
    shadow \
    tini \
    tzdata

# Herunterladen des docker-gc Skripts und Kopieren der Dateien
ADD https://raw.githubusercontent.com/spotify/docker-gc/master/docker-gc /usr/bin/docker-gc
COPY build/default-docker-gc-exclude /etc/docker-gc-exclude
COPY build/executed-by-cron.sh /executed-by-cron.sh
COPY build/generate-crontab.sh /generate-crontab.sh

# Berechtigungen setzen
RUN chmod 0755 /usr/bin/docker-gc /generate-crontab.sh /executed-by-cron.sh \
    && chmod 0644 /etc/docker-gc-exclude

# Zweite Phase: Erstellen des finalen Images
FROM alpine:3.20.3

# Erstellen des nicht-root Benutzers und Hinzufügen zur Docker-Gruppe im finalen Image
RUN addgroup -S docker-gc && adduser -S -G docker-gc docker-gc && addgroup docker-gc docker

# Kopieren der notwendigen Dateien aus der Builder-Phase
COPY --from=builder /usr/bin/docker-gc /usr/bin/docker-gc
COPY --from=builder /etc/docker-gc-exclude /etc/docker-gc-exclude
COPY --from=builder /executed-by-cron.sh /executed-by-cron.sh
COPY --from=builder /generate-crontab.sh /generate-crontab.sh

# Installieren der minimalen Abhängigkeiten für den finalen Container und Erstellen des Docker-Socket-Verzeichnisses
RUN apk add --no-cache tini docker-cli \
    && mkdir -p /var/run/docker

# Wechseln zum nicht-root Benutzer
USER docker-gc

HEALTHCHECK --interval=5m --timeout=3s CMD ["pgrep", "crond"]

# Starten des Containers mit Tini als Init-System
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/bin/sh", "-c", "/generate-crontab.sh && crond -f"]
