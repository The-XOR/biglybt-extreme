#!/bin/bash

bail()
{
  >&2 echo "$1"
  exit 1
}

source /app/imagestart.sh

exec websockify --web=/usr/share/novnc/ 8080 nasso.airdns.org:8228

/app/biglybtcheck.sh

source /app/tiger.sh
