## Docker overview

Docker is an open platform for developing, shipping, and running applications. Docker enables you to separate your applications from your infrastructure so you can deliver software quickly. With Docker, you can manage your infrastructure in the same ways you manage your applications. By taking advantage of Docker’s methodologies for shipping, testing, and deploying code quickly, you can significantly reduce the delay between writing code and running it in production.

## The Docker platform
Docker provides the ability to package and run an application in a loosely isolated environment called a container. The isolation and security allow you to run many containers simultaneously on a given host. Containers are lightweight and contain everything needed to run the application, so you do not need to rely on what is currently installed on the host. You can easily share containers while you work, and be sure that everyone you share with gets the same container that works in the same way.

Docker provides tooling and a platform to manage the lifecycle of your containers:

Develop your application and its supporting components using containers.
The container becomes the unit for distributing and testing your application.
When you’re ready, deploy your application into your production environment, as a container or an orchestrated service. This works the same whether your production environment is a local data center, a cloud provider, or a hybrid of the two.

![Test Image 4](https://docs.docker.com/engine/images/architecture.svg)

## How is Docker different from a virtual machine?

![Test Image 4](https://assets-global.website-files.com/5efc3ccdb72aaa7480ec8179/5f03f585f55f79c8b17ae7d2_containers-blog.png)


## What is Kubernetes? 

![kubernetes](https://docs.microsoft.com/pt-br/azure/architecture/reference-architectures/containers/aks-microservices/images/aks.png)

Kubernetes, also known as K8s, is an open-source system for automating deployment, scaling, and management of containerized applications.
* **Automated rollouts and rollbacks:** 

Kubernetes progressively rolls out changes to your application or its configuration, while monitoring application health to ensure it doesn't kill all your instances at the same time. If something goes wrong, Kubernetes will rollback the change for you. Take advantage of a growing ecosystem of deployment solutions.
* **Horizontal scaling:**

Scale your application up and down with a simple command, with a UI, or automatically based on CPU usage.

* **Secret and configuration management:**

Deploy and update secrets and application configuration without rebuilding your image and without exposing secrets in your stack configuration.

* **Self-healing:**

Restarts containers that fail, replaces and reschedules containers when nodes die, kills containers that don't respond to your user-defined health check, and doesn't advertise them to clients until they are ready to serve.

# DeployAKS
Deploy a simple app with Docker , Terraform and Aks.

## Clone repo:

```
$ git clone -b develop https://github.com/welbsterhansi/DeployAKS.git
$ cd DeployAKS/
```

## Login on Azure:

```
$ az login
```
## Build image docker:

```
$ docker build -t=webapp3 .
$ docker tag a610345fe03c welbsterhansi/atlantico-app
$ docker push welbsterhansi/atlantico-app:v.2.0
```
## Create cluster AKS with terraform:

```
$ cd terraform
$ terraform init
$ terraform plan
$ terraform apply --auto-approve
$ terraform output kube_config > ~/.kube/aksconfig
$ export KUBECONFIG=~/.kube/aksconfig
$ kubectl get nodes
```
## Create resources kubernetes:

```
$ cd kubernetes
$ kubectl create ns app
$ kubectl create secret docker-registry github --docker-server=https://index.docker.io/v2/ \
--docker-username=welbsterhansi \
--docker-password=******* --docker-email=welbsterhansi@gmail.com
$ kubectl create Deployment.yaml
$ kubectl create Service.yaml
$ kubectl get po,svc,secrets -n app
```
## Create ingress for app:

```
$ kubectl create namespace ingress-basic
$ helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
$ helm install nginx-ingress ingress-nginx/ingress-nginx \
    --namespace ingress-basic \
    --set controller.replicaCount=2 \
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set controller.admissionWebhooks.patch.nodeSelector."beta\.kubernetes\.io/os"=linux
$ kubectl --namespace ingress-basic get services -o wide -w nginx-ingress-ingress-nginx-controller
```
