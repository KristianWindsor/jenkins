#!/bin/sh
set -x

mkdir -p /root/.kube/
echo "
apiVersion: v1
kind: Config
clusters:
- name: default-cluster
  cluster:
    certificate-authority-data: ${KUBE_CA}
    server: ${KUBE_SERVER_URL}
contexts:
- name: default-context
  context:
    cluster: default-cluster
    namespace: default
    user: jenkins
current-context: default-context
users:
- name: jenkins
  user:
    token: ${KUBE_TOKEN}
"
echo "
apiVersion: v1
kind: Config
clusters:
- name: kwk8s.tech
  cluster:
    certificate-authority-data: ${KUBE_CA}
    server: https://${KUBE_URL}
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