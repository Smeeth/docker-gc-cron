#!/bin/sh

echo "Docker system prune executed on $(date)"

# Run the Docker system prune command to remove unused data
docker system prune -af --volumes

echo "Docker system prune completed."
