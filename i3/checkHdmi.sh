#!/bin/bash

value=$(xrandr | grep -e "^eDP1")
value=$(echo $value | grep " connected ")
echo $value
