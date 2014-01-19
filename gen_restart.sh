#!/bin/bash
echo "#!/bin/bash" > ~/bin/restart_cmd
echo "sleep 10" >> ~/bin/restart_cmd
echo "tmux -q send -t minecraft:minecraft \"cd $SERVER_ROOT && $JAVA_JRE $OPTIONS -Xms$INIT_RAM -Xmx$RAM -jar $SERVER_JAR nogui\" C-m" >> ~/bin/restart_cmd
