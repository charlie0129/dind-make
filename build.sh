#!/bin/bash

set -o errexit

platforms="linux/amd64,linux/arm64"
query_url="https://hub.docker.com/v2/repositories/library/docker/tags?page_size=15&page=1&name=-alpine"

tags=($(curl -fsSL "$query_url" | jq -r ".results[].name" | grep -v rc))

addmake() {
    local tag=$1
    local before=${tag%-alpine*}
    local after=${tag#*-alpine}
    echo "$before-make-alpine$after"
}

for i in "${!tags[@]}"; do
    echo "$i: ${tags[$i]} -> $(addmake "${tags[$i]}")"
done

for tag in "${tags[@]}"; do
    mytag=$(addmake "$tag")

    echo "Building charlie0129/docker:$mytag from docker:$tag..."

    docker buildx build --push           \
    --platform "$platforms" \
    --build-arg "BASE_IMAGE=docker:$tag" \
    -t docker.io/charlie0129/docker:$mytag \
    -t ghcr.io/charlie0129/docker:$mytag \
    .
done
