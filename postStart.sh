#!/bin/sh
set -x

mkdir -p /root/.kube/
echo "
apiVersion: v1
kind: Config
clusters:
- name: kwk8s.tech
  cluster:
    certificate-authority-data: ${KUBE_CA}
    server: https://api.kwk8s.tech
contexts:
- name: jenkins
  context:
    cluster: kwk8s.tech
    namespace: default
    user: jenkins
current-context: jenkins
users:
- name: jenkins
  user:
    token: ${KUBE_TOKEN}
" > /root/.kube/config