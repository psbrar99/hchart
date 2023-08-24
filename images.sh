#!/usr/bin/env bash

set -o errexit
set -o pipefail
# set -x

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"


IMAGES=(install-cni
istioctl
operator
pilot
proxyv2)

IMAGE_SUFFIXES=("" "-debug" "-distroless")

for image in "${IMAGES[@]}"; do
  for suffix in "${IMAGE_SUFFIXES[@]}"; do
    DIGEST=$(crane digest $HUB/${image}:${TAG}${suffix})
    cosign sign -y $HUB/${image}@$digest
  done
done