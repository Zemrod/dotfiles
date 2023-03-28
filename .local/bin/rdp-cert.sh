#!/urs/bin/env bash

openssl req -x509 -newkey rsa:2048 -nodes -keyout $1-key.pem -out $1-cert.pem -days 3650

chown root: $1-cert.pem
chown root:xrdp $1-key.pem
chmod 640 $1-key.pem
