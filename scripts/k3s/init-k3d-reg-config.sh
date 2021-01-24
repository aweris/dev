#!/bin/bash

set -euo pipefail

OUTPUT=${OUTPUT:-"tmp/k3d/registries.yaml"}

init() {
  # make sure config directory exist
  mkdir -p "$(dirname ${OUTPUT})"

  # request access token from gcloud
  password=$(gcloud auth print-access-token)

  # generate
  cat <<EOF >"${OUTPUT}"
mirrors:
  eu.gcr.io:
    endpoint:
      - https://eu.gcr.io

configs:
  eu.gcr.io:
    auth:
      username: oauth2accesstoken
      password: ${password}
EOF
}

init "$@"
