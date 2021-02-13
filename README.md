Jenkins.

```
KUBE_CA = kubectl get secret jenkins-token-abcd -o jsonpath='{.data.ca\.crt}'
KUBE_TOKEN = kubectl get secret jenkins-token-abcd -o jsonpath='{.data.token}' | base64 --decode
```

Move database
```
cd /var/jenkins_home/
tar -czf /tmp/jenkins_home.tar.gz .
kubectl cp jenkins-7f6bd5fbc4-hndh2:tmp/jenkins_home.tar.gz ./jenkins_home.tar.gz
kubectl cp ./jenkins_home.tar.gz jenkins-7f4d74bf78-2wzzk:tmp/
cd /tmp/
tar -xf jenkins_home.tar.gz -C /var/jenkins_home/
```