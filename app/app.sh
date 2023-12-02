#!/bin/bash

bail()
{
  >&2 echo "$1"
  exit 1
}

exec websockify --web=/usr/share/novnc/ 8080 localhost:5901

source /app/imagestart.sh

/app/biglybtcheck.sh

source /app/tiger.sh
