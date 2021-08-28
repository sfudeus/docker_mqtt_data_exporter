#!/usr/bin/env bash

set -eu

if [ $# -ne 1 ]; then
  echo "Usage: $0 <go_version>";
  exit 1
fi

rsync -a --delete --exclude mqtt_data_exporter ~/Workspace/github/klaper/mqtt_data_exporter/ mqtt_data_exporter/

GO_VERSION=$1
PRG_VERSION=$(GIT_DIR="mqtt_data_exporter/.git" git describe --tags)
IMAGE_VERSION=${PRG_VERSION}_${GO_VERSION}

docker buildx build --build-arg "GO_VERSION=${GO_VERSION}" --platform linux/amd64 --platform linux/arm/v7 --platform linux/arm64 -t "sfudeus/mqtt_data_exporter:${IMAGE_VERSION}" --push .
