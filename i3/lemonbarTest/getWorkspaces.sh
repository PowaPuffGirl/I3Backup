#!/bin/bash

active=$( i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2 )
inactive=$( i3-msg -t get_workspaces | jq '.[] | select(.focused==false).name' | cut -d"\"" -f2 )
echo "$active   $inactive"
