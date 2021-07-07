FROM ubuntu:latest

WORKDIR /srv

RUN \
    apt-get update          &&  \
    apt-get upgrade --yes   &&  \
    apt-get install --yes       \
        openssh-server

# Configure sshd

RUN \
    mkdir -p /var/run/sshd

ADD ./srv/bin/conda /tmp/bin/conda
RUN chmod +x /tmp/bin/conda
RUN echo "export PATH=/tmp/bin:${PATH}" > /etc/environment

RUN \
    adduser -q --gecos "" --disabled-password admin     && \
    echo admin:admin | chpasswd

RUN \
    adduser -q --gecos "" --disabled-password user1     && \
    echo user1:user1 | chpasswd

WORKDIR /root
ADD docker-entrypoint.sh /srv
RUN chmod +x /srv/docker-entrypoint.sh
ENTRYPOINT [ "/srv/docker-entrypoint.sh" ]
CMD [ "/usr/sbin/sshd", "-p", "22", "-D" ]