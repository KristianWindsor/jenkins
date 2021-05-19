# Jenkins CI/CD for Kubernetes
This jenkins is tailored for building and deploying docker images to kubernetes clusters.

## Run with Docker Compose
```
docker-compose up --build
```

## Deploy to Kubernetes

### 1. Create service account
```
kubectl apply -f clusterRole.yaml
kubectl apply -f clusterRoleBinding.yaml
kubectl apply -f serviceAccount.yaml
```

### 2. Create secret with service account credentials
```
# find token with 'kubectl get secret'
MY_JENKINS_TOKEN=jenkins-token-abcd
KUBE_CA = kubectl get secret ${MY_JENKINS_TOKEN} -o jsonpath='{.data.ca\.crt}'
KUBE_TOKEN = kubectl get secret ${MY_JENKINS_TOKEN} -o jsonpath='{.data.token}' | base64 --decode
echo "apiVersion: v1
kind: Secret
metadata:
  name: jenkins-env
type: Opaque
stringData:
  KUBE_CA: '${KUBE_CA}'
  KUBE_TOKEN: '${KUBE_TOKEN}'" > secret.yaml
```

### 3. Deploy Jenkins
```
kubectl apply -f secret.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
kubectl apply -f certificate.yaml
```

## Backup Jenkins
```
JENKINS_POD_NAME=jenkins-7f6bd5fbc4-hndh2
kubectl exec -it ${JENKINS_POD_NAME} -- /bin/bash
cd /var/jenkins_home/
tar -czf /tmp/jenkins_home.tar.gz .
kubectl cp ${JENKINS_POD_NAME}:tmp/jenkins_home.tar.gz ./jenkins_home.tar.gz
```

## Restore Jenkins
```
JENKINS_POD_NAME=jenkins-7f6bd5fbc4-hndh2
kubectl cp ./jenkins_home.tar.gz ${JENKINS_POD_NAME}:tmp/
kubectl exec -it ${JENKINS_POD_NAME} -- /bin/bash
cd /tmp/
tar -xf jenkins_home.tar.gz -C /var/jenkins_home/
```