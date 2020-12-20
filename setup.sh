#!/bin/bash
git clone --recursive https://github.com/ornicar/lila.git
git clone https://github.com/ornicar/lila-ws.git

#lila files
mkdir lila/.vscode
cp settings.json lila/.vscode/settings.json
cp conf/application.conf lila/conf/

#ws
cp conf/custom_ws.conf lila-ws/
