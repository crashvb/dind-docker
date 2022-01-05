# dind-docker

## Overview

This docker image contains [DinD](https://hub.docker.com/_/docker?tab=tags&name=dind).

## Entrypoint Scripts

### dind

The embedded entrypoint script is located at `/etc/entrypoint.d/10dind` and performs the following actions:

1. A new dind configuration is generated using the following environment variables:

 | Variable | Default Value | Description |
 | ---------| ------------- | ----------- |
 | DIND_CERT_DAYS | 30 | Validity period of any generated PKI certificates. |
 | DIND_KEY_SIZE | 4096 | Key size of any generated PKI keys. |

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

