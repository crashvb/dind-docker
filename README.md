# dind-docker

[![version)](https://img.shields.io/docker/v/crashvb/dind/latest)](https://hub.docker.com/repository/docker/crashvb/dind)
[![image size](https://img.shields.io/docker/image-size/crashvb/dind/latest)](https://hub.docker.com/repository/docker/crashvb/dind)
[![linting](https://img.shields.io/badge/linting-hadolint-yellow)](https://github.com/hadolint/hadolint)
[![license](https://img.shields.io/github/license/crashvb/dind-docker.svg)](https://github.com/crashvb/dind-docker/blob/master/LICENSE.md)

## Overview

This docker image contains [docker](https://hub.docker.com/_/docker?tab=tags&name=dind).

## Entrypoint Scripts

### dind

The embedded entrypoint script is located at `/etc/entrypoint.d/10dind` and performs the following actions:

1. A new dind configuration is generated using the following environment variables:

 | Variable | Default Value | Description |
 | ---------| ------------- | ----------- |
 | DIND\_CERT\_DAYS | 30 | Validity period of any generated PKI certificates. |
 | DIND\_KEY\_SIZE | 4096 | Key size of any generated PKI keys. |

## Standard Configuration

### Container Layout

```
/
├─ etc/
│  └─ entrypoint.d/
│     └─ 10dind
├─ run/
│  └─ secrets/
│     ├─ dind.crt
│     ├─ dind.key
│     └─ dindca.crt
└─ var/
   └─ lib/
      └─ docker/
```

### Exposed Ports

* `2375/tcp` - Public HTTP port of the docker daemon API.
* `2376/tcp` - Public HTTPS port of the docker daemon API.

### Volumes

* `/var/lib/docker` - Docker data directory.

## Development

[Source Control](https://github.com/crashvb/dind-docker)

