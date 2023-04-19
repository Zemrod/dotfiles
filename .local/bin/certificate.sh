#!/usr/bin/env bash

#openssl genrsa -des3 -out internalCA.key 2048
#openssl req -x509 -new -nodes -key internalCA.key -sha256 -days 1825 -out internalCA.pem

ext_file="$1.ext"

echo "authorityKeyIdentifier=keyid,issuer" | tee $ext_file
echo "basicConstraints=CA:FALSE" | tee -a $ext_file
echo "keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment" | tee -a $ext_file
echo "subjectAltName = @alt_names" | tee -a $ext_file
echo "" | tee -a $ext_file
echo "[alt_names]" | tee -a $ext_file
echo "DNS.1 = $1" | tee -a $ext_file

[ ! -f "$1.key" ] && openssl genrsa -out $1.key 2048
openssl req -new -key $1.key -out $1.csr
openssl req -new -key $1.key -out $1.csr
openssl x509 -req -in $1.csr -CA internalCA.pem -CAkey internalCA.key -CAcreateserial -out $1.crt -days 825 -sha256 -extfile $ext_file 
