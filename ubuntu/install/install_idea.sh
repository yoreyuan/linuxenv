#!/usr/bin/env bash
set -ex

ARCH=$(arch | sed 's/aarch64/arm64/g' | sed 's/x86_64/x64/g')
IDEA_VERSION=$1

if [ "" = "$IDEA_VERSION" ]; then
  IDEA_VERSION="2023.2.1"
fi

#https://www.jetbrains.com/idea/download/other.html
wget -q https://download.jetbrains.com/idea/ideaIC-${IDEA_VERSION}-${ARCH}.tar.gz -O $HOME/Download/idea-${IDEA_VERSION}.tar
