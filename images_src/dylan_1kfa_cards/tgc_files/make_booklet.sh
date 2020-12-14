#! /bin/bash

echo 'Make sure ImageMagick can read | write PDFs'
convert booklet_*png booklet.pdf
