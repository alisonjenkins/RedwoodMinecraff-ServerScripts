#!/bin/bash
tmux -q send -t minecraft:minecraft "cd $SERVER_ROOT && $JAVA_JRE $OPTIONS -Xms$INIT_RAM -Xmx$RAM -jar $SERVER_JAR nogui" C-m
