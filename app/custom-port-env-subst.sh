#!/bin/sh

set -e

# Run one hard-wired env-var subst

export CYBER_DOJO_SHAS_PORT=4522

readonly defined_envs="$(printf '${%s} ' $(env | cut -d= -f1))"

readonly template_path=/docker-entrypoint.d/nginx.conf.template

envsubst "${defined_envs}" < "${template_path}" > "/etc/nginx/conf.d/default.conf"
