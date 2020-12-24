#!/bin/sh

set -e

# Run one hard-wired env-var subst

readonly dir=/etc/nginx/conf.d

export CYBER_DOJO_SHAS_PORT=4522

readonly defined_envs="$(printf '${%s} ' $(env | cut -d= -f1))"

envsubst "${defined_envs}" < "${dir}/default.conf.template" > "${dir}/default.conf"
