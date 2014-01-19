#/bin/bash
MINE_CONFIG=~/serverconfig.cfg
if [ -f $MINE_CONFIG ]; then
    source $MINE_CONFIG
else
    echo "Config file: '$MINE_CONFIG' does not exist"
    exit
fi

python $SERVER_ROOT/Minecraft-Region-Fixer/region-fixer.py -v -p 4 $SERVER_ROOT/world
