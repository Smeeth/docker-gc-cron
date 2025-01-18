#!/bin/bash

# Execute docker system prune
docker system prune -af --volumes

# Log the result
echo "Docker system prune executed on $(date)"