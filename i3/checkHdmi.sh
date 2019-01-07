#!/bin/bash

value=$(xrandr | grep -e "^DP2")
value=$(echo $value | grep " connected ")
echo $value
