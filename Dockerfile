# Use the latest Docker CLI version based on Alpine
FROM docker:27.5.0-cli-alpine3.21

# Maintainer information
LABEL maintainer="Eibo Richter <eibo.richter@gmail.com>"
LABEL version="0.3.0"
LABEL date="2025-01-18"

# Install additional packages if needed
RUN apk add --no-cache tzdata

# Copy the docker-prune.sh script to the container
COPY docker-prune.sh /usr/local/bin/docker-prune.sh

# Set executable permissions for the script
RUN chmod +x /usr/local/bin/docker-prune.sh

# Set the entry point for the container
ENTRYPOINT ["/usr/local/bin/docker-prune.sh"]
