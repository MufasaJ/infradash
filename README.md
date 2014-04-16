# infradash

Simple dashboard for managing VM guests

Currenly only supports Libvirt based hosts

## Getting started

It's simple to get started with docker and the included `Dockerfile`

```bash
docker build --tag="infradash" .
docker run -P infradash:latest
```
