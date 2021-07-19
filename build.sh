#!/bin/bash

echo Generating secrets...
rm -rf secrets
mkdir secrets
cd secrets
openssl rand -hex 32 > configproxy-auth-token.txt
openssl rand -hex 32 > hub-profiles-token.txt
openssl rand -hex 32 > shifter-api-token.txt
openssl rand -hex 32 > entrypoint-api-token.txt
cd ..

echo Generating ssh creds...
ssh-keygen -t rsa -N '' -C ca@localhost -f secrets/creds
ssh-keygen -s secrets/creds -h -I localhost secrets/creds.pub

echo Building cori...
cd cori
docker build -t cori:latest .
cd ..

echo Building perlmutter...
cd perlmutter
docker build -t perlmutter:latest .
cd ..

echo Building hub...
cd hub
docker build -t hub:latest .
cd ..

echo Building shifter...
cd shifter
docker build  -t shifter:latest .
cd ..

echo Building jupyterhub-entrypoint...
cd jupyterhub-entrypoint
docker build -t jupyterhub-entrypoint:latest .
cd ..