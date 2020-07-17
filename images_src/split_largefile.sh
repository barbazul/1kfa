#! /bin/bash

BNAME=$(basename $1)

split --additional-suffix=".part" -b 10M $1 "$BNAME."
