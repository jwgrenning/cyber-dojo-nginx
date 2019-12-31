#!/bin/bash

readonly SH_DIR="$( cd "$( dirname "${0}" )" && pwd )/sh"

"${SH_DIR}/build_docker_images.sh" "$@"
