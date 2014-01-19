#!/bin/bash
if [ $# -ne 1 ]; then
	echo "Please specify a reason for restart"
	exit
fi
reason=$1
tmux send-keys -t minecraft:minecraft "say Restarting the server to $reason in 15 minutes." C-m
echo "tmux send-keys -t minecraft:minecraft \"say 10 minutes until server shutdown.\" C-m" | at now + 5 min
echo "tmux send-keys -t minecraft:minecraft \"say 5 minutes until server shutdown.\" C-m" | at now + 10 min
echo "tmux send-keys -t minecraft:minecraft \"say 2 minute until server shutdown.\" C-m" | at now + 13 min
echo "tmux send-keys -t minecraft:minecraft \"say 1 minute until server shutdown.\" C-m" | at now + 14 min
echo "tmux send-keys -t minecraft:minecraft \"stop\" C-m" | at now + 15 min
