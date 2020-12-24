#!/bin/sh

set -e

# Get empty envsubst in place

readonly dir=/etc/nginx/conf.d
envsubst "NOT_YET" < "${dir}/default.conf.template" > "${dir}/default.conf"
