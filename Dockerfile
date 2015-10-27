FROM jenkins:1.625.1

ENV DOCKER_VERSION 1.2.0
ENV DOCKER_GID 200

COPY plugins.txt /usr/share/jenkins/ref/

USER root

RUN curl -sSL -O https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION \
    && chmod +x docker-$DOCKER_VERSION \
    && mv docker-$DOCKER_VERSION /usr/local/bin/docker \
    && groupadd -g $DOCKER_GID docker \
    && usermod -G docker jenkins

USER jenkins

RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt