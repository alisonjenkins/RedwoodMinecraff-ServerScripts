#!/bin/bash
#[WARNING!]: The chunk (0,0) in region file r.0.0.mca has 745 entities, and this may be too much. This may be a problem!
MINE_CONFIG=~/serverconfig.cfg
if [ -f $MINE_CONFIG ]; then
    source $MINE_CONFIG
else
    echo "Config file: '$MINE_CONFIG' does not exist"
    exit
fi

output=`$SERVER_ROOT/bin/entity_scan.sh`
entity_problem=0
output=`echo $output | grep 'entities,'` 
echo $output
