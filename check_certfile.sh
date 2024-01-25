#!/bin/bash
# simple check to check the age of certificate files
# $PWD = /usr/lib/check_mk_agent/local
cert_file=$PWD/tmp/test.crt
certdate=$(date -d "$(openssl x509 -text -noout -in $cert_file | grep "Not After" | cut -d ':' -f 2-)" '+%Y-%m-%d')
certname=$(openssl x509 -text -noout -in $cert_file | grep "Subject:" | cut -d '=' -f 2- | xargs)
daysuntilinvaild=$((($(date -d $certdate +%s)- $(date +%s))/86400))
echo "P \"CRT-$certname\" daysuntilinvaild=$daysuntilinvaild;30:;14: $daysuntilinvaild days left"