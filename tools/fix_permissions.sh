#!/bin/bash

find . -type d -exec chmod -v 0755 {} \;
find . -type f -exec chmod -v 0644 {} \;

for i in $(ls ./tools/*.sh); do
    chmod -v +x ${i};
done;

chown -Rv $@ .;

