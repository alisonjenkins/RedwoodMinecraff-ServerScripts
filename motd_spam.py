#!/usr/bin/env python
import os
import re
import sys
import subprocess
import shlex

ignore_search = []
ignore_search.append(r'Welcome to the Redwood Server {PLAYER}')
ignore_search.append(r'Type /help')
ignore_search.append(r'Currently online:&r {PLAYERLIST}')

def read_file():
	with open(os.path.join(os.environ['HOME'],'plugins/Essentials/motd.txt')) as motd_file:
		output = []
		for line in motd_file.readlines():
			output.append(line.replace('&6','').replace('&c','').strip())
	return output

def filter_output(file_lines, ignore_search):
	filter_line = []

	# find lines that need to be removed from output
	for line in output:
		for regex in ignore_search:
			if re.search(regex, line) != None:
				filter_line.append(line)

	for line in filter_line:
		file_lines.remove(line)
	
	return file_lines

def output_to_server(output):
	for line in output:
		args = shlex.split('tmux send-keys -t minecraft:minecraft "say %s" C-m' % line)
		subprocess.Popen(args)

output = read_file()
output = filter_output(output, ignore_search)
output_to_server(output)
