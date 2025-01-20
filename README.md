# docker-gc-cron

A Docker container that regularly runs `docker system prune` to clean up unused Docker resources.

[![Build Docker Container](https://github.com/Smeeth/docker-gc-cron/actions/workflows/build.yaml/badge.svg?branch=master&event=push)](https://github.com/Smeeth/docker-gc-cron/actions/workflows/build.yaml)

## Table of Contents
- [docker-gc-cron](#docker-gc-cron)
  - [Table of Contents](#table-of-contents)
  - [Quick Start](#quick-start)
  - [Features](#features)
  - [Default Behavior](#default-behavior)
  - [Why Not Spotify's Docker Garbage Collection?](#why-not-spotifys-docker-garbage-collection)
  - [Usage](#usage)
    - [With Docker CLI:](#with-docker-cli)
    - [With Docker Compose:](#with-docker-compose)
  - [Configuration](#configuration)
    - [Docker CLI Example](#docker-cli-example)
    - [Docker Compose Example](#docker-compose-example)
  - [Contributing](#contributing)
  - [License](#license)

## Quick Start

```
docker run -d -v /var/run/docker.sock:/var/run/docker.sock scartalune/docker-gc-cron:latest
```

## Features

- Regular execution of `docker system prune -af --volumes`
- Configurable cleanup schedule
- Based on official Docker CLI image for compatibility and security

## Default Behavior

Important: By default, the container runs its cleanup task every hour (3600 seconds) unless otherwise specified through environment variables. This ensures regular Docker resource management without manual intervention.

## Why Not Spotify's Docker Garbage Collection?

While Spotify's docker-gc was a popular solution for Docker cleanup, it has been deprecated and is no longer actively maintained. The `docker system prune` command, introduced in newer Docker versions, offers a more integrated and efficient way to clean up unused Docker objects. This project leverages `docker system prune` to provide a simple, up-to-date solution for Docker housekeeping.

## Usage

### With Docker CLI:

```
docker run -d -v /var/run/docker.sock:/var/run/docker.sock scartalune/docker-gc-cron:latest
```

### With Docker Compose:

`nano docker-compose.yaml`

Paste the following:

```
services:
  docker-gc:
    image: scartalune/docker-gc-cron:latest
    container_name: docker-gc
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    deploy:
      restart_policy:
        condition: on-failure
        delay: 5s
        max_attempts: 3
        window: 120s

volumes:
  docker_socket:
    external: true
```

Then start container with

`docker compose up -d`

Update with

`docker compose down`
and
`docker compose pull`
and
`docker compose up -d`


## Configuration

The container supports configuring the sleep time between prune operations using the `SLEEP_TIME` environment variable. By default, this is set to **3600 seconds** (1 hour), but can be customized to any desired interval.

### Docker CLI Example
```bash
docker run -d \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -e SLEEP_TIME=7200 \
  scartalune/docker-gc-cron:latest
```

### Docker Compose Example
```yaml
services:
  docker-gc:
    image: scartalune/docker-gc-cron:latest
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      - SLEEP_TIME=7200
```

In these examples, the container will wait 2 hours (7200 seconds) between each Docker system prune operation. You can adjust the `SLEEP_TIME` to any positive integer representing seconds.

## Contributing

[...]

## License

This repository is licensed under the GNU General Public License v3.0 (GPLv3).

It's important to note that this project no longer contains source code from https://github.com/clockworksoul/docker-gc-cron or https://github.com/spotify/docker-gc. The functionality previously provided by these projects has been completely rewritten. This decision was made because the original approach was considered outdated by the current developer. For more information on why we chose to reimplement these features, please refer to the section "## Why Not Spotify's Docker Garbage Collection?".

The full text of the GPLv3 license can be found in the LICENSE file in this repository. By using, distributing, or contributing to this project, you agree to the terms and conditions of this license.
