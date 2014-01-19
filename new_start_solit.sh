#! /bin/sh
# Check for existence of needed config file and read it
MINE_CONFIG=/srv/minecraft/rwpack164/serverconfig.cfg
if [ -f $MINE_CONFIG ]; then
    . $MINE_CONFIG
else
    echo "Config file: '$MINE_CONFIG' does not exist"
    exit
fi

case "$1" in
	start)
		echo "Checking tmux session"
		if su $USER -c "tmux ls" | grep minecraft > /dev/null; then
			echo "tmux session detected killing server"
			su $USER -c "tmux kill-session -t minecraft"
		fi
		echo "Creating new session"
		su $USER -c "tmux new-session -d -n minecraft:0 -s minecraft"
        if [ $SIZE -eq 0 ]; then
            echo "Not using RAM disk"
        else
	    su $USER -c "tmux new-window -d -t minecraft:9 -n lsyncd"
            echo "Setting up RAM disk"
            echo "   -Checking world folder"
            if [ "$(ls -A $WORLD)" ]; then
                echo "   -World folder not empty"
                echo "      -Resyncing backup world"
                su $USER -c "rsync -a $WORLD/ $WORLD_HDD"
                echo "      -Unmounting RAMdisk"
                umount $WORLD
                echo "      -Cleaning out world folder"
                rm -rf $WORLD
                echo "      -Remaking world folder"
                su $USER -c "mkdir $WORLD"
            else
                echo "   -World folder empty, checking permissions"
                chown $USER:$USER $WORLD
            fi
            echo "   -Mounting RAMdisk"
            mount -t tmpfs -o size=$SIZE tmpfs $WORLD
            echo "   -Rsyncing world to RAMdisk"
            su $USER -c "rsync -r $WORLD_HDD/ $WORLD"
            echo "   -Firing up lsyncd to live backup world"
            su $USER -c "tmux -q send -t minecraft:lsyncd \"lsyncd -nodaemon -rsync $WORLD/ $WORLD_HDD\" C-m"
        fi
		echo "Starting Server"
		su $USER -c "tmux -q send -t minecraft:minecraft \"cd $SERVER_ROOT && $JAVA_JRE $OPTIONS -Xms$INIT_RAM -Xmx$RAM -jar $SERVER_JAR nogui\" C-m"
		#echo "   -Waiting for startup"
		#wait 30
		#echo "   -Checking Server Status"
		#$0 status
		;;
	stop)
		echo "Shutting down server"
		su $USER -c "tmux -q send -t minecraft:minecraft \"say Server is going offline.\" C-m"
		echo "   -Disabling saving"
		su $USER -c "tmux -q send -t minecraft:minecraft \"save-off\" C-m"
		echo "   -Saving world"
		su $USER -c "tmux -q send -t minecraft:minecraft \"save-all\" C-m"
		echo "   -Stopping server"
		su $USER -c "tmux -q send -t minecraft:minecraft \"stop\" C-m"
        if [ $SIZE -ne 0 ]; then
            echo "Stoping lsyncd"
            su $USER -c "tmux -q send -t minecraft:lsyncd C-c"
            echo "Syncing backup"
            su $USER -c "rsync -a $WORLD/ $WORLD_HDD"
        fi
		;;
	restart)
		$0 stop
		$0 start
		;;
#	status)
#		echo -n "Checking Server Status"
#		if [ ps ax | grep -v grep | grep -v tmux | grep "$bukkitfilename" > /dev/null ]; then
#			PID=`ps ax | grep -v grep | grep -v sh | grep -v -i 'tmux' | grep -v -i 'screen' | grep "$bukkitfilename"`
#			top -n 1 -p ${PID:0:5} | grep ${PID:0:5}
#		;;
	*)
		## If no parameters are given, print which are avaiable.
		echo "Usage: $0 {start|stop|restart}"
		exit 1
		;;
esac
