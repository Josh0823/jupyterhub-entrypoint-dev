#!/bin/bash

# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_DB_PASSWORD' 'example'
# (will allow for "$XYZ_DB_PASSWORD_FILE" to fill in the value of
#  "$XYZ_DB_PASSWORD" from a file, especially for Docker's secrets feature)
file_env() {
    var=$1
    file_var="${var}_FILE"
    var_value=$(printenv $var || true)
    file_var_value=$(printenv $file_var || true)
    default_value=$2

    if [ -n "$var_value" -a -n "$file_var_value" ]; then
        echo >&2 "error: both $var and $file_var are set (but are exclusive)"
        exit 1
    fi

    if [ -z "${var_value}" ]; then
        if [ -z "${file_var_value}" ]; then
            export "${var}"="${default_value}"
        else
            export "${var}"="$(cat $file_var_value)"
        fi
    fi

    unset "$file_var"
}

file_env 'CONFIGPROXY_AUTH_TOKEN'
file_env 'ENTRYPOINT_API_TOKEN'

echo "Making certs"
mkdir /certs
for u in $(ls /home/); do
    echo "Adding cert for $u"
    cp /run/secrets/creds /certs/$u.key
    chmod 600 /certs/$u.key
    cp /run/secrets/creds-cert.pub /certs/$u.key-cert.pub
    chmod 600 /certs/$u.key-cert.pub
done

exec "$@"
