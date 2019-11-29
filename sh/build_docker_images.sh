#!/bin/bash
set -e

export IMAGE_NAME=${1:-cyberdojo/nginx}

readonly ROOT_DIR="$( cd "$( dirname "${0}" )" && cd .. && pwd )"
export SHA=$(cd "${ROOT_DIR}" && git rev-parse HEAD)

build_service_image()
{
  echo
  docker-compose \
    --file "${ROOT_DIR}/docker-compose.yml" \
      build \
        "${1}"
}

build_service_image nginx

# Assuming we do not have any new nginx commits, nginx's latest commit
# sha will match the image tag inside versioner's .env file.
# This means we can tag to it and a [cyber-dojo up] call
# will use the tagged image.
docker tag ${IMAGE_NAME}:latest ${IMAGE_NAME}:${SHA:0:7}
docker run --rm ${IMAGE_NAME}:latest sh -c 'echo ${SHA}'
