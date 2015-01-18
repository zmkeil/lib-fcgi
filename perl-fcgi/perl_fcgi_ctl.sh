#!/bin/bash

# set -x

EXEC=$0
dirname=`dirname $EXEC`
BASE=`cd $dirname && pwd`

app="nginx-fcgi-svnfile"
dir=/home/zmkeil/nginx/apps/${app}/

stop () 
{ 
	kill $(cat $dir/logs/perl-fcgi.pid) 

	rm $dir/logs/perl-fcgi.pid 2>/dev/null 

	rm $dir/logs/perl-fcgi.sock 2>/dev/null 

	rm $dir/now_start_perl_fcgi.sh 2>/dev/null 

	echo "stop perl-fcgi done"
} 

use_sock=1
if [ -z use_sock ]; then
	startsh="./perl-fcgi-unix.pl"
fi

start () 
{ 
	rm $dir/now_start_perl_fcgi.sh 2>/dev/null 

#	chown nobody.root $dir/logs 

	echo "#!/bin/bash" >>$dir/now_start_perl_fcgi.sh
	echo "$BASE/perl-fcgi-unix.pl -l $dir/logs/perl-fcgi.log -pid $dir/logs/perl-fcgi.pid -S $dir/logs/perl-fcgi.sock" >>$dir/now_start_perl_fcgi.sh 

#	chown nobody.nobody $dir/now_start_perl_fcgi.sh 

	chmod u+x $dir/now_start_perl_fcgi.sh 

	$dir/now_start_perl_fcgi.sh 

	echo "start perl-fcgi done"
} 


case $1 in
	stop) 
	stop 
	;; 
	start) 
	start 
	;; 
	restart) 
	stop 
	start 
	;; 
esac
