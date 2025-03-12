#!/usr/bin/env bash
export GITHUB_TOKEN=op://Personal/FluxIF-GitHub-PAT/password
export CILIUM_VERSION=v1.17.1
kind create cluster --config=kind-cluster-config.yaml
docker pull quay.io/cilium/cilium:${CILIUM_VERSION}
kind load docker-image quay.io/cilium/cilium:${CILIUM_VERSION}
cilium install -f ./kind-cilium-values.yaml --version ${CILIUM_VERSION} --wait

op run -- ./flux-bootstrap.sh
