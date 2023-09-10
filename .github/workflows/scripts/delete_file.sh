#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

filename="$1"

if [ -f "$filename" ]; then
  rm "$filename"
  echo "File '$filename' has been deleted."
else
  echo "File not found: $filename"
  exit 1
fi
