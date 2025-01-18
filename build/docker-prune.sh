#!/bin/sh
set -eu

# Set default sleep time to 3600 seconds (1 hour) or use the SLEEP_TIME environment variable
sleep_time="${SLEEP_TIME:-3600}"

while true; do
  echo "Running docker system prune"

  # Execute the Docker system prune command with options to remove unused resources and volumes
  docker system prune -af --volumes

  echo "Sleeping for $sleep_time seconds.."

  # Sleep for the specified duration
  sleep "$sleep_time"
done
