# [`pascaliske/docker-autorestic`](https://pascaliske.github.io/docker-autorestic/)

> Docker image based on the awesome [cupcakearmy/autorestic](https://github.com/cupcakearmy/autorestic).

[![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/pascaliske/autorestic/latest?style=flat-square)](https://hub.docker.com/r/pascaliske/autorestic) [![Docker Image Size (tag)](https://img.shields.io/docker/image-size/pascaliske/autorestic/latest?style=flat-square)](https://hub.docker.com/r/pascaliske/autorestic) [![Docker Pulls](https://img.shields.io/docker/pulls/pascaliske/autorestic?style=flat-square)](https://hub.docker.com/r/pascaliske/autorestic) [![GitHub Tag](https://img.shields.io/github/v/tag/pascaliske/docker-autorestic?style=flat-square)](https://github.com/pascaliske/docker-autorestic) [![Build Status](https://img.shields.io/github/workflow/status/pascaliske/docker-autorestic/Image/master?label=build&style=flat-square)](https://github.com/pascaliske/docker-autorestic/actions) [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](https://opensource.org/licenses/MIT) [![GitHub Last Commit](https://img.shields.io/github/last-commit/pascaliske/docker-autorestic?style=flat-square)](https://github.com/pascaliske/docker-autorestic) [![Awesome Badges](https://img.shields.io/badge/badges-awesome-green.svg?style=flat-square)](https://github.com/Naereen/badges)

## Usage

To use this image pull it from one of the following registries:

```bash
# docker hub
docker pull pascaliske/autorestic

# github container registry
docker pull ghcr.io/pascaliske/autorestic
```

Create an initial config file (`config.yml`):

<!-- prettier-ignore -->
```yml
backends:
  my-backend:
    type: local
    path: /var/lib/autorestic/backends/my-backend
locations:
  my-location:
    from: /var/lib/autorestic/locations/my-location
    to:
      - my-backend
  my-volume:
    from: /var/lib/autorestic/locations/my-volume
    to:
      - my-backend
```

The following bind mounts are required:

| Mount                           | Description                                                             |          |
| ------------------------------- | ----------------------------------------------------------------------- | -------- |
| `/etc/autorestic/cache`         | Your restic cache folder.                                               | Optional |
| `/etc/autorestic/config.yml`    | Your autorestic configuration file.                                     | Required |
| `/var/lib/autorestic/locations` | All locations defined as `from` in the config file.                     | Required |
| `/var/lib/autorestic/backends`  | All `path`s defined for backends with `type: local` in the config file. | Required |

> Note: To backup volumes you can directly mount them in `/var/lib/autorestic/locations` and reference them as normal folder in the config file:
>
> ```bash
> docker run --rm \
>   -v my-volume:/var/lib/autorestic/locations/my-volume \
>   ghcr.io/pascaliske/autorestic:latest backup --location my-volume
> ```

Run a backup with the required volume mounts:

```bash
$ docker run --rm \
    -v $(pwd)/config.yml:/etc/autorestic/config.yml \
    -v $(pwd)/cache:/etc/autorestic/cache \
    -v $(pwd)/my-backend:/var/lib/autorestic/backends/my-backend \
    -v $(pwd)/my-location:/var/lib/autorestic/locations/my-location \
    -v my-volume:/var/lib/autorestic/locations/my-volume \
    ghcr.io/pascaliske/autorestic:latest backup --location my-location
```

Restore a backup with the required volume mounts. The target folder should be bind mounted as well:

```bash
$ docker run --rm \
    -v $(pwd)/config.yml:/etc/autorestic/config.yml \
    -v $(pwd)/cache:/etc/autorestic/cache \
    -v $(pwd)/my-backend:/var/lib/autorestic/backends/my-backend \
    -v $(pwd)/my-location:/var/lib/autorestic/locations/my-location \
    -v my-volume:/var/lib/autorestic/locations/my-volume \
    -v $(pwd)/my-restore:/tmp/my-restore \
    ghcr.io/pascaliske/autorestic:latest restore --location my-location --from my-backend --to /tmp/my-restore
```

For a list of all commands and their usage [visit the autorestic docs](https://autorestic.vercel.app/). An example usage can be [found here](./example/).

## License

[MIT](LICENSE.md) – © 2022 [Pascal Iske](https://pascaliske.dev)
