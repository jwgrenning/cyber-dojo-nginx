#!/bin/sh

set -e

# First, just ensure this script is running...

readonly dir=/etc/nginx/conf.d
cp ${dir}/default.conf.template  ${dir}/default.conf
