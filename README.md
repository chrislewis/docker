# docker-jenkins

This is a descriptor for a jenkins image based on the official jenkins image but
prepared for a specific workflow: building and testing projects with sbt,
pushing images of successful builds to a registry, and team notification via
slack. The appropriate plugins are preinstalled in addition to the GitHub
plugin, with the intention of supporting a push/merge based workflow.

### Docker Interaction

This approach avoids the "Docker in Docker" approach by requiring a bind mount
of the daemon socket from the host to the container. The image includes the
docker client binary, but because the GID of the docker group in the container
won't match that of the host, the binary is owned by root and carries the
SUID bit. This allows jenkins to run docker without the burden of sudo 
(trading that burden for SUID).

### TODO

sudo docker run --name jenkins -d --restart=always -p 8080:8080 \
  -v /var/jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  chrslws/docker-jenkins:latest