# k8s-express-demo
Demo of how to build Express.js Typescript apps in Docker and deploy to K8S

## Setup

1. Install [Docker](https://docs.docker.com/get-docker/)
2. Install [Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)
3. Start the local Minikube Cluster
```bash
minikube start
```


## Build the Docker Image
1. Connect to Docker in use by the Minikube cluster
```bash
eval $(minikube docker-env)
```
2. Build the Docker image
```bash
docker build -t uncomn/k8s-express-demo .
```

## Deploy the Docker Image to the Minikube cluster
1. Use kubectl to apply the manifests
```bash
kubectl apply -f kube
```
2. Wait for the Pods to be ready
```bash
kubectl get pods --watch
```
3. Expose the Service with minikube
```bash
minikube service express-demo
```

## Teardown
1. Destroy the Minikube cluster
```bash
minikube destroy
```

## View the K8S Dashboard
1. ```minikube dashboard```