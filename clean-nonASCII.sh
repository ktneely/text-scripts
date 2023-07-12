#!/bin/bash

# Use perl to quickly remove non-ASCII characters in the current directory

for f in ./* ; do
    perl -pi -e 's/[^[:ascii:]]//g' $f
done
