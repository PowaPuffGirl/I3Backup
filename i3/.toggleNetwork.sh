#!/bin/bash

wifi=$( nmcli con show -active | wc -l )

if [[ $wifi -gt 1 ]] 
then 
	nmcli networking off
else 
	nmcli networking on
fi
