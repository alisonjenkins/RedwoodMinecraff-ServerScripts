#!/bin/bash
players=( "`cat $HOME/white-list.txt`" )

for player in ${players[@]}
do
	echo "$player"
	
done
