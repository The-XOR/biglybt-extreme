#!/bin/bash

bail()
{
  >&2 echo "$1"
  exit 1
}

source /app/imagestart.sh

/app/biglybtcheck.sh

source /app/tiger.sh
