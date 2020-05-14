FROM jenkins/jenkins:2.208

USER root
# Install Docker
RUN wget -qO- https://get.docker.com/ | sh
# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

COPY ./postStart.sh /