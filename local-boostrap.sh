#!/usr/bin/env bash
export GITHUB_TOKEN=op://Personal/FluxIF-GitHub-PAT/password
export CILIUM_VERSION=v1.17.1
export GATEWAY_API_VERSION=v1.2.0
kind create cluster --config=kind-cluster-config.yaml
docker pull quay.io/cilium/cilium:${CILIUM_VERSION}
kind load docker-image quay.io/cilium/cilium:${CILIUM_VERSION}

kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/${GATEWAY_API_VERSION}/config/crd/standard/gateway.networking.k8s.io_gatewayclasses.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/${GATEWAY_API_VERSION}/config/crd/standard/gateway.networking.k8s.io_gateways.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/${GATEWAY_API_VERSION}/config/crd/standard/gateway.networking.k8s.io_httproutes.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/${GATEWAY_API_VERSION}/config/crd/standard/gateway.networking.k8s.io_referencegrants.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/${GATEWAY_API_VERSION}/config/crd/standard/gateway.networking.k8s.io_grpcroutes.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/${GATEWAY_API_VERSION}/config/crd/experimental/gateway.networking.k8s.io_tlsroutes.yaml

cilium install -f ./kind-cilium-values.yaml --version ${CILIUM_VERSION} --wait

op run -- ./flux-bootstrap.sh
