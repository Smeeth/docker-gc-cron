# NEW README PROPOSAL

# docker-gc-cron

A Docker container that regularly runs `docker system prune` to clean up unused Docker resources.

[![Build Docker Container](https://github.com/Smeeth/docker-gc-cron/actions/workflows/build.yaml/badge.svg?branch=master&event=push)](https://github.com/Smeeth/docker-gc-cron/actions/workflows/build.yaml)

## Table of Contents
- [NEW README PROPOSAL](#new-readme-proposal)
- [docker-gc-cron](#docker-gc-cron)
  - [Table of Contents](#table-of-contents)
  - [Quick Start](#quick-start)
  - [Features](#features)
  - [Why Not Spotify's Docker Garbage Collection?](#why-not-spotifys-docker-garbage-collection)
  - [Usage](#usage)
  - [Configuration](#configuration)
  - [Contributing](#contributing)
  - [License](#license)
  - [... to be continued](#-to-be-continued)

## Quick Start

```
docker run -d -v /var/run/docker.sock:/var/run/docker.sock scartalune/docker-gc-cron:latest
```

## Features

- Regular execution of `docker system prune -af --volumes`
- Configurable cleanup schedule
- Based on official Docker CLI image for compatibility and security

## Why Not Spotify's Docker Garbage Collection?

While Spotify's docker-gc was a popular solution for Docker cleanup, it has been deprecated and is no longer actively maintained. The `docker system prune` command, introduced in newer Docker versions, offers a more integrated and efficient way to clean up unused Docker objects. This project leverages `docker system prune` to provide a simple, up-to-date solution for Docker housekeeping.

## Usage

[...]

## Configuration

[...]

## Contributing

[...]

## License

This repository is licensed under the GNU General Public License v3.0 (GPLv3).

It's important to note that this project no longer contains source code from https://github.com/clockworksoul/docker-gc-cron or https://github.com/spotify/docker-gc. The functionality previously provided by these projects has been completely rewritten. This decision was made because the original approach was considered outdated by the current developer. For more information on why we chose to reimplement these features, please refer to the section "## Why Not Spotify's Docker Garbage Collection?".

The full text of the GPLv3 license can be found in the LICENSE file in this repository. By using, distributing, or contributing to this project, you agree to the terms and conditions of this license.



## ... to be continued
