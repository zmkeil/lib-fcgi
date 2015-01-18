#!/bin/bash

dirname="/home/zmkeil/nginx/apps/lib-fcgi/perl-fcgi/cgi-example/"

echo "Content-type: text/html"
echo ""

file=`echo ${QUERY_STRING} | awk '{nn=split($1, qs,"&"); for(i=1;i<=2;i++) print qs[i]}' | awk '{split($1, params, "="); if(params[1]=="fileName"){print params[2]}}'`

cat $dirname/$file

