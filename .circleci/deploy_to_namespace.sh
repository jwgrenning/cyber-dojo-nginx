#!/bin/bash -e

readonly MY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly K8S_URL=https://raw.githubusercontent.com/cyber-dojo/k8s-install/master
readonly VERSIONER_URL=https://raw.githubusercontent.com/cyber-dojo/versioner/master
source <(curl "${K8S_URL}/sh/deployment_functions.sh")
export $(curl "${VERSIONER_URL}/app/.env")
readonly CYBER_DOJO_NGINX_TAG="${CIRCLE_SHA1:0:7}"
readonly YAML_VALUES_FILE="${MY_DIR}/k8s-general-values.yml"

deploy_to_namespace()
{
  local -r NAMESPACE="${1}" # beta|prod

  gcloud_init
  helm_init

  helm_upgrade_probe_no_prometheus_no \
     "${NAMESPACE}" \
     "nginx" \
     "${CYBER_DOJO_NGINX_IMAGE}" \
     "${CYBER_DOJO_NGINX_TAG}" \
     "${CYBER_DOJO_NGINX_PORT}" \
     "${YAML_VALUES_FILE}" \
     "${MY_DIR}/k8s-${NAMESPACE}-values.yml"
}
