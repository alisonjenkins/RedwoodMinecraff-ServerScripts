#!/bin/bash
rdiff-backup --remove-older-than $KEEP_BACKUPS --force $SERVER_BACKUP_DIR
