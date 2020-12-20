#!/bin/bash
#start ws in background
cd /home/lila-ws
setsid nohup sbt -Dconfig.file=/home/lila-ws/custom_ws.conf run &
cd -

cd /home/lila
./ui/build # builds the CSS and JS
./lila run # starts the SBT console
