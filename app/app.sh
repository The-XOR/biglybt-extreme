#!/bin/bash

bail()
{
  >&2 echo "$1"
  exit 1
}

source /app/imagestart.sh

exec websockify --web=/usr/share/novnc/ 8080 192.168.100.18:5901

/app/biglybtcheck.sh

source /app/tiger.sh
