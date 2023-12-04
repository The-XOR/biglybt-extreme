#!/bin/bash

bail()
{
  >&2 echo "$1"
  exit 1
}

source /app/imagestart.sh

exec websockify --web=/usr/share/novnc/ 8080 172.17.0.1:5901

/app/biglybtcheck.sh

source /app/tiger.sh
