FROM alpine:3.21.2

LABEL maintainer="Eibo Richter <eibo.richter@gmail.com>"
LABEL version="0.2.1"
LABEL date="2025-01-18"

# Install required packages
RUN apk add --no-cache \
    bash \
    docker-cli \
    tzdata

# Copy the script from the build directory to the container
COPY build/docker-prune.sh /usr/local/bin/docker-prune.sh

# Set permissions
RUN chmod +x /usr/local/bin/docker-prune.sh

# Create a non-root user and add to docker group
RUN addgroup -S docker && \
    adduser -S -G docker dockeruser && \
    addgroup dockeruser docker

# Switch to non-root user
USER dockeruser

# Set working directory
WORKDIR /home/dockeruser

# Run the prune script
CMD ["/usr/local/bin/docker-prune.sh"]
