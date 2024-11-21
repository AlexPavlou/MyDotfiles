#!/bin/bash
doas emerge -W "$@"
doas emerge -cv "$@"
echo "All Done"
