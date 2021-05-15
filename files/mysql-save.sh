#!/bin/sh
## $Id: mysql-save.sh 256 2006-11-05 15:29:29Z touche $
##	julien.touche@touche.fr.st
##
## save/dump mysql databases
##
## note: you need to setup user in mysql config files
##
## http://dev.mysql.com/doc/refman/5.0/en/backup.html
## mysql> GRANT SELECT, RELOAD, LOCK TABLES ON *.* TO backup@localhost IDENTIFIED BY '<PASS>';
## or http://dev.mysql.com/doc/refman/4.1/en/backup.html
##	same but different rights ?

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin
umask 077

dst=/tmp/
tmp=`mktemp /tmp/tmp.XXXXXX` || exit 1
tmp_log=`mktemp /tmp/tmplog.XXXXXX` || exit 1
date=`date +%Y-%m-%d`
host=`hostname -s`
sys=`uname -s`
user=`whoami || echo $USER`
mysql_user=root
#mysql_user=backup
#mysql_pass=back%up.2006
#mysql_arg="--single-transaction --flush-logs --master-data=2 --opt"
## master-data => SUPER,REPLICATION CLIENT privs
mysql_arg="--single-transaction --flush-logs --opt"
mysql_auth="-u $mysql_user -p$mysql_pass"
mysql_auth="-u $mysql_user"

trap 'rm -f $tmp $tmp_log' EXIT HUP TERM KILL     # clean up on exit or signal
[ ! -d $dst ] && mkdir -p $dst

## generic save
src_dbs=" \
	vortessence \
	"

## before backing up, verify
mysqlcheck -B -f -v --all-databases $mysql_auth > $dst/$host-save-$date-mysqlcheck 2>&1
## change the binary log
## http://dev.mysql.com/doc/refman/5.0/en/log-files.html
mysqladmin $mysql_auth flush-logs > $dst/$host-save-$date-flush-logs 2>&1

for db in $src_dbs; do
	f=$dst/$host-save-$date-mysqldump-$db
	## 5.0
	[ ! -f "$f" -a ! -f "$f.gz" ] && mysqldump $mysql_arg $mysql_auth $db > $f \
		&& gzip $f && f=$f.gz && \
		(openssl dgst -md5 $f; openssl dgst -sha1 $f; openssl dgst -ripemd160 $f) > $f.distinfo
	#[ ! -f "$f" -a ! -f "$f.gz" ] && mysqlhotcopy $db $f

done

### ou sauvegarde bin
#f=$dst/$host-save-$date-mysqlhotcopies
#[ ! -d $f ] && mkdir -p $f
#mysqlhotcopy --user=backup $dbs $f && tar czf $f.tar.gz $f && \
#	(openssl dgst -md5 $f; openssl dgst -sha1 $f; openssl dgst -ripemd160 $f) > $f.distinfo && \
#	rm -R $f
