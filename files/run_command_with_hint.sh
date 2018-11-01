#!/bin/bash
echo -e "$1"
exec "${@:2}"
