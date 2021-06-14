# Example Usage

## 1. Preparation (only needed once)

To prepare the backends you need to run the following command:

```bash
$ docker run --rm \
    -v $(pwd)/config.yml:/etc/autorestic/config.yml \
    -v $(pwd)/my-backend:/var/lib/autorestic/backends/my-backend \
    -v $(pwd)/my-location:/var/lib/autorestic/locations/my-location \
    pascaliske/autorestic:latest check
```

## 2. Backup

To run a backup use the following command:

```bash
$ docker run --rm \
    -v $(pwd)/config.yml:/etc/autorestic/config.yml \
    -v $(pwd)/my-backend:/var/lib/autorestic/backends/my-backend \
    -v $(pwd)/my-location:/var/lib/autorestic/locations/my-location \
    pascaliske/autorestic:latest backup --location my-location
```

## 3. Restore

To restore a backup use the following command:

```bash
$ docker run --rm \
    -v $(pwd)/config.yml:/etc/autorestic/config.yml \
    -v $(pwd)/my-backend:/var/lib/autorestic/backends/my-backend \
    -v $(pwd)/my-location:/var/lib/autorestic/locations/my-location \
    -v $(pwd)/my-restore:/tmp/my-restore \ # target folder
    pascaliske/autorestic:latest restore --location my-location --from my-backend --to /tmp/my-restore
```
