#!/usr/bin/env bash
export GITHUB_TOKEN=op://Personal/FluxIF-GitHub-PAT/password
kind create cluster --config=kind-cluster-config.yaml
docker pull quay.io/cilium/cilium:v1.16.6
kind load docker-image quay.io/cilium/cilium:v1.16.6
cilium install -f ./kind-cilium-values.yaml

op run -- ./flux-bootstrap.sh
