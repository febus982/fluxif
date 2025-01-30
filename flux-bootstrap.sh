#!/usr/bin/env bash
#export GITHUB_TOKEN=op://Personal/FluxIF-GitHub-PAT/password
flux bootstrap github \
  --token-auth \
  --owner=febus982 \
  --repository=fluxif \
  --branch=main \
  --path=clusters/kind-cluster \
  --personal
