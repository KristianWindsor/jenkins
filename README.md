Jenkins.

```
KUBE_CA = kubectl get secret jenkins-token-abcd -o jsonpath='{.data.ca\.crt}'
KUBE_TOKEN = kubectl get secret jenkins-token-abcd -o jsonpath='{.data.token}' | base64 --decode
```