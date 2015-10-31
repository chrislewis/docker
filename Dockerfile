FROM jenkins:1.625.1

ENV DOCKER_VERSION 1.7.1

COPY plugins.txt /usr/share/jenkins/ref/

USER root

ENV DEBIAN_FRONTEND=noninteractive

RUN curl -sSL -O https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION \
    && mv docker-$DOCKER_VERSION /usr/local/bin/docker \
    && chown root /usr/local/bin/docker \
    && chmod 4755 /usr/local/bin/docker \
    && apt-get -q update \
    && apt-get -y -q install apt-utils sudo \
    && apt-get remove -y apt-utils \
    && echo "jenkins    ALL=(ALL) NOPASSWD: /usr/local/bin/docker" >> /etc/sudoers

ENV DEBIAN_FRONTEND=newt

USER jenkins

RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt