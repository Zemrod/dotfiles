#!/usr/bin/env bash

openssl genrsa -des3 -out internalCA.key 2048
openssl req -x509 -new -nodes -key internalCA.key -sha256 -days 1825 -out internalCA.pem
