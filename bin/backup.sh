#! /bin/bash

SERVER=$1
BACKUP_DIR=$2
DATE=`/usr/bin/date +%Y%m%d`
RSYNC=/usr/bin/rsync

$RSYNC -avz --rsync-path=/usr/local/bin/rsync --delete --backup --backup-dir=$BACKUP_DIR/deleted/$SERVER -e "ssh -q -i /home/quentin/.ssh/id_dsa_rsync" mariequ@ms$SERVER:/export/home/mariequ/ $BACKUP_DIR/$SERVER > $BACKUP_DIR/log/$SERVER.$DATE 2> $BACKUP_DIR/log/error_$SERVER.$DATE
