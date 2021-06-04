# Example Usage

## 1. Preparation (only needed once)

To prepare the backends you need to run the following command:

```bash
$ docker run \
    -v $(pwd)/config.yml:/etc/autorestic/config.yml \ # config file
    -v $(pwd)/my-backend:/var/lib/autorestic/backends/my-backend \ # autorestic backend
    -v $(pwd)/my-location:/var/lib/autorestic/locations/my-location \ # autorestic location
    pascaliske/autorestic:latest check
```

## 2. Backup

To run a backup use the following command:

```bash
$ docker run \
    -v $(pwd)/config.yml:/etc/autorestic/config.yml \ # config file
    -v $(pwd)/my-backend:/var/lib/autorestic/backends/my-backend \ # autorestic backend
    -v $(pwd)/my-location:/var/lib/autorestic/locations/my-location \ # autorestic location
    pascaliske/autorestic:latest backup --location my-location
```

## 3. Restore

To restore a backup use the following command:

```bash
$ docker run \
    -v $(pwd)/config.yml:/etc/autorestic/config.yml \ # config file
    -v $(pwd)/my-backend:/var/lib/autorestic/backends/my-backend \ # autorestic backend
    -v $(pwd)/my-location:/var/lib/autorestic/locations/my-location \ # autorestic location
    -v $(pwd)/my-restore:/tmp/my-restore \ # target folder
    pascaliske/autorestic:latest restore --location my-location --from my-backend --to /tmp/my-restore
```
