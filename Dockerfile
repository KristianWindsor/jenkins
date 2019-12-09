FROM jenkins/jenkins

USER root
RUN wget -qO- https://get.docker.com/ | sh