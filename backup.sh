#!/bin/bash
source ~/serverconfig.cfg
tmux send-keys -t minecraft:minecraft "say Backup starting" C-m
tmux send-keys -t minecraft:minecraft "save-off" C-m
tmux send-keys -t minecraft:minecraft "save-all" C-m
sleep 10
cd $SERVER_ROOT
#pwd
#git add -A
#git commit -a -m "Automated backup at `date`"

if [ $SIZE -ne 0 ]; then
    rdiff-backup --exclude=$SERVER_ROOT/world $SERVER_ROOT /srv/minecraft/backup/$USER/
else
    rdiff-backup $SERVER_ROOT /srv/minecraft/backup/$USER/
fi
tmux send-keys -t minecraft:minecraft "save-on" C-m
#/srv/minecraft/rwsolit/backuptoftp.sh
tmux send-keys -t minecraft:minecraft "say Backup complete" C-m
