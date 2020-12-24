#!/bin/sh
set -e

readonly template_path=/docker-entrypoint.d/nginx.conf.template
readonly ports_filename=/docker-entrypoint.d/ports.env
readonly defined_envs="$(printf '${%s}' $(cat "${ports_filename}" | cut -d= -f1))"
export $(cat "${ports_filename}")
envsubst "${defined_envs}" < "${template_path}" > "/etc/nginx/conf.d/default.conf"
