#!/bin/bash

dirname="/home/zmkeil/nginx/apps/lib-fcgi/perl-fcgi/cgi-example/"

function printLine()
{
	file=$1
	lastchange=$2
	printf "%s %s %s &nbsp;&nbsp;<a href=\"javascript:getVersionFile('%s')\">%s</a>\n" $lastchange $3 $4 $file $file
	echo "<br/>"
}

echo "Content-type: text/html"
echo ""

applist=`cat $dirname/include.conf | awk '{print $2}'`
for i in $applist
do
	lastchange=`ls -l $dirname/$i | awk '{print $6,$7,$8}'`
	printLine $i $lastchange
done


echo ${REQUEST_METHOD}
echo ${QUERY_STRING}
