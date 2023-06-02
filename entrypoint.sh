#!/bin/sh

echo "test"
confg-discog &
echo "after"
eval "${@}"
echo "after eval"
