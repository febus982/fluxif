#!/usr/bin/env bash
flux bootstrap github \
  --token-auth \
  --owner=febus982 \
  --repository=fluxif \
  --branch=main \
  --path=clusters/kind-cluster \
  --personal
