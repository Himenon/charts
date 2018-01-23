#!/usr/bin/env bash

REPO_URL=https://himenon.github.io/incubator/

find ./incubator -d 1 -type d | while read chartDir; do
    echo "helm package -d ./pkg ${chartDir}"
    helm package -d ./pkg ${chartDir}
done

helm repo index pkg --url ${REPO_URL}
