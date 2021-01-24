#!/bin/bash

set -euo pipefail

RESOURCES_DIR=${RESOURCES_DIR:-"resources"}

TRAEFIK_REPO_NAME="traefik"
TRAEFIK_REPO_URL="https://helm.traefik.io/traefik"
TRAEFIK_CHART_NAME="traefik"
TRAEFIK_CHART_VERSION="9.13.0"
TRAEFIK_RELEASE_NAME="traefik"
TRAEFIK_NS="router"
TRAEFIK_VALUES="${RESOURCES_DIR}/helm/traefik/values.yaml"
TRAEFIK_MANIFESTS="${RESOURCES_DIR}/manifests/traefik/"

init() {
  # Add repositories
  helm repo add "${TRAEFIK_REPO_NAME}" "${TRAEFIK_REPO_URL}"

  # Update repo
  helm repo update

  # Install traefik
  helm upgrade --install "${TRAEFIK_RELEASE_NAME}" "${TRAEFIK_REPO_NAME}/${TRAEFIK_CHART_NAME}" \
    --version "${TRAEFIK_CHART_VERSION}" \
    --namespace "${TRAEFIK_NS}" --create-namespace \
    --values "${TRAEFIK_VALUES}"

  # Apply additional manifests
  kubectl apply -f "${TRAEFIK_MANIFESTS}"
}

init "$@"
