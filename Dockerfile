FROM gitlab/gitlab-runner:latest
MAINTAINER Jean-Avit Promis "docker@katagena.com"
LABEL org.label-schema.vcs-url="https://github.com/nouchka/docker-gitlab-runner"
LABEL version="latest"

ENV DOCKER_IMAGE nouchka/symfony:7.0

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT /start.sh
