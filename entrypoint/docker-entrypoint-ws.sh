#!/bin/bash
#start ws in background
cd /home/lila-ws
sbt -Dconfig.file=/home/lila-ws/custom_ws.conf run
cd -
