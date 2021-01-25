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

ARGOCD_REPO_NAME="argo"
ARGOCD_REPO_URL="https://argoproj.github.io/argo-helm"
ARGOCD_CHART_NAME="argo-cd"
ARGOCD_CHART_VERSION="2.11.3"
ARGOCD_RELEASE_NAME="argocd"
ARGOCD_NS="argocd"
ARGOCD_VALUES="${RESOURCES_DIR}/helm/argocd/values.yaml"
ARGOCD_MANIFESTS="${RESOURCES_DIR}/manifests/argocd/"


init() {
  # Add repositories
  helm repo add "${TRAEFIK_REPO_NAME}" "${TRAEFIK_REPO_URL}"
  helm repo add "${ARGOCD_REPO_NAME}" "${ARGOCD_REPO_URL}"

  # Update repo
  helm repo update

  # Install traefik
  helm upgrade --install "${TRAEFIK_RELEASE_NAME}" "${TRAEFIK_REPO_NAME}/${TRAEFIK_CHART_NAME}" \
    --version "${TRAEFIK_CHART_VERSION}" \
    --namespace "${TRAEFIK_NS}" --create-namespace \
    --values "${TRAEFIK_VALUES}"

 # Install traefik
  helm upgrade --install "${ARGOCD_RELEASE_NAME}" "${ARGOCD_REPO_NAME}/${ARGOCD_CHART_NAME}" \
    --version "${ARGOCD_CHART_VERSION}" \
    --namespace "${ARGOCD_NS}" --create-namespace \
    --values "${ARGOCD_VALUES}"

  # Apply additional manifests
  kubectl apply -f "${TRAEFIK_MANIFESTS}"
  kubectl apply -f "${ARGOCD_MANIFESTS}"
}

init "$@"
