# NZBHydra2

Simple docker image for NZBHydra2 without any bloat, built on the official Temurin JRE image. NZBHydra2 runs as user `nzbhydra2` with `uid` and `gid` `1000` and listens on port `5076`.

## Usage

```sh
docker run --rm registry.gitlab.jmk.hu/media/nzbhydra2:<VERSION> \
  -p 5076:5076 \
  -v path/to/config:/config \
  -v path/to/downloads:/downloads
```

or

```sh
docker run --rm ghudiczius/nzbhydra2:<VERSION> \
  -p 5076:5076 \
  -v path/to/config:/config \
  -v path/to/downloads:/downloads
```
