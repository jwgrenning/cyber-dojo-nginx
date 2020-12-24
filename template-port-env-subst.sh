#!/bin/sh
set -e

# This script is automatically run by the nginx server when it starts.
# See docker-entrypoint.sh in the root of an nginx container.

readonly template_path=/docker-entrypoint.d/nginx.conf.template
readonly ports_filename=/docker-entrypoint.d/ports.env
readonly defined_envs="$(printf '${%s}' $(cat "${ports_filename}" | cut -d= -f1))"
export $(cat "${ports_filename}")
envsubst "${defined_envs}" < "${template_path}" > "/etc/nginx/conf.d/default.conf"
