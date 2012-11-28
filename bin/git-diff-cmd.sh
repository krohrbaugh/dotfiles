#!/bin/bash

xattr -w com.apple.TextEncoding "UTF-8;134217984" "$2"
xattr -w com.apple.TextEncoding "UTF-8;134217984" "$5"

/usr/bin/opendiff "$2" "$5" -merge "$1"