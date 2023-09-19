#!/usr/bin/env bash

set -e

ECSACT_SDK_VERSION=`gh -R ecsact-dev/ecsact_sdk release view --json tagName --jq .tagName`

curl -sL "https://github.com/ecsact-dev/ecsact_sdk/releases/download/${ECSACT_SDK_VERSION}/ecsact_sdk_${ECSACT_SDK_VERSION}_linux_x64.tar.gz" | sudo tar -C /usr -xz
