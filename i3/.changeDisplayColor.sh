#!/bin/bash

dayColor=$1
nightColor=$2

hour=$( date "+%H" ) 

if [ $hour -gt 17 ] || [ $hour -lt 9 ]
then 
	redshift -P -O $nightColor
else 
	redshift -P -O $dayColor
fi
