# Use the latest Alpine version as the base image
FROM alpine:3.21.2

# Maintainer information
LABEL maintainer="Eibo Richter <eibo.richter@gmail.com>"
LABEL version="0.2.1"
LABEL date="2025-01-18"

# Install required packages
RUN apk add --no-cache \
    bash \               # Bash shell for script execution
    docker-cli \        # Docker CLI to interact with Docker daemon
    tzdata               # Time zone data

# Copy the docker-prune.sh script from the build directory to the container
COPY build/docker-prune.sh /usr/local/bin/docker-prune.sh

# Set executable permissions for the script
RUN chmod +x /usr/local/bin/docker-prune.sh

# Create a non-root user and add to the Docker group
RUN addgroup -S docker && \
    adduser -S -G docker dockeruser

# Switch to non-root user for security reasons
USER dockeruser

# Set the working directory in the container
WORKDIR /home/dockeruser

# Command to run when the container starts
CMD ["/usr/local/bin/docker-prune.sh"]
