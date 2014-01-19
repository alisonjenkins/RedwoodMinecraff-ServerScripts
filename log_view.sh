#!/bin/bash
MINE_CONFIG=~/serverconfig.cfg
if [ -f $MINE_CONFIG ]; then
    source $MINE_CONFIG
else
    echo "Config file: '$MINE_CONFIG' does not exist"
    exit
fi

LOGS=`find $SERVER_ROOT -name 'ForgeModLoader*.log' | sort -n | xargs cat | grep -v '\[FINE\]' | grep -v '\[FINEST\]' | grep -v '\[INFO\]' | grep -v '\[FINER\]'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (3879:0) to Miner'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (4154:0) to Miner'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (9110:0) to Hunter'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (9113:0) to Hunter'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (9064:0) to Hunter'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (9137:0) to Hunter'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (202:90) to Hunter'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (9107:0) to Hunter'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (9090:0) to Hunter'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (9091:0) to Hunter'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (9092:0) to Hunter'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (9100:0) to Hunter'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (9066:0) to Hunter'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (9093:0) to Hunter'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (9031:0) to Hunter'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (9035:0) to Hunter'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (9047:0) to Hunter'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (9111:0) to Hunter'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (9112:0) to Hunter'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (9102:0) to Hunter'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (9095:0) to Hunter'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (9134:0) to Hunter'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (9135:0) to Hunter'`
LOGS=`echo "$LOGS" | grep -v '\[WARNING\] \[ForgeModLoader\] Failed to add block/item of (9136:0) to Hunter'`

echo "$LOGS" | less
