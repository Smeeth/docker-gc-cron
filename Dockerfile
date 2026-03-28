# Use the latest Docker CLI version based on Alpine
FROM docker:29.3.1-dind-alpine3.23

# Maintainer information
LABEL maintainer="Eibo Richter <eibo.richter@gmail.com>"
LABEL version="0.3.6"
LABEL date="2026-03-28"

# Install additional packages if needed
RUN apk add --no-cache tzdata

# Copy the docker-prune.sh script to the container
COPY build/docker-prune.sh /usr/local/bin/docker-prune.sh

# Set executable permissions for the script
RUN chmod +x /usr/local/bin/docker-prune.sh

# Set the entry point for the container
ENTRYPOINT ["/usr/local/bin/docker-prune.sh"]
