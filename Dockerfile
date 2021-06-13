# builder image
FROM --platform=${BUILDPLATFORM} golang:alpine AS builder
LABEL maintainer="info@pascaliske.dev"
WORKDIR /root/

# arguments
ARG VERSION=1.1.1
ARG TARGETOS
ARG TARGETARCH
ENV CGO_ENABLED=0

# install dependencies
RUN apk add --update --no-cache git

# clone repo
RUN git config --global advice.detachedHead false
RUN git clone --depth 1 --branch v${VERSION} https://github.com/CupCakeArmy/autorestic

# build binary
WORKDIR /root/autorestic
RUN echo "Building for ${TARGETOS}/${TARGETARCH} in /usr/local/bin/autorestic"
RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /usr/local/bin/autorestic main.go
RUN /usr/local/bin/autorestic --version

# install restic
RUN autorestic install

# final image
FROM alpine:latest
LABEL maintainer="info@pascaliske.dev"

# install docker
RUN apk add --update --no-cache docker openrc
RUN rc-update add docker boot

# volumes
VOLUME [ "/var/run/docker.sock" "/etc/autorestic", "/var/lib/autorestic" ]

# copy built binary
COPY --from=builder /usr/local/bin/autorestic /usr/local/bin/
COPY --from=builder /usr/local/bin/restic /usr/local/bin/

# setup entrypoint
ENTRYPOINT [ "autorestic", "--config", "/etc/autorestic/config.yml" ]
