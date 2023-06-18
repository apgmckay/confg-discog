#!/bin/sh

echo "entrypoint: starting"
confg-discog &
echo "entrypoint: config-discog started"
eval "${@}"
echo "entrypoint: after eval"
