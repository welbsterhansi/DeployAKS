## Docker overview

Docker is an open platform for developing, shipping, and running applications. Docker enables you to separate your applications from your infrastructure so you can deliver software quickly. With Docker, you can manage your infrastructure in the same ways you manage your applications. By taking advantage of Docker’s methodologies for shipping, testing, and deploying code quickly, you can significantly reduce the delay between writing code and running it in production.

## The Docker platform
Docker provides the ability to package and run an application in a loosely isolated environment called a container. The isolation and security allow you to run many containers simultaneously on a given host. Containers are lightweight and contain everything needed to run the application, so you do not need to rely on what is currently installed on the host. You can easily share containers while you work, and be sure that everyone you share with gets the same container that works in the same way.

Docker provides tooling and a platform to manage the lifecycle of your containers:

Develop your application and its supporting components using containers.
The container becomes the unit for distributing and testing your application.
When you’re ready, deploy your application into your production environment, as a container or an orchestrated service. This works the same whether your production environment is a local data center, a cloud provider, or a hybrid of the two.

![Test Image 4](https://docs.docker.com/engine/images/architecture.svg)

Docker X VMware:

![Test Image 4](https://i.ytimg.com/vi/TvnZTi_gaNc/maxresdefault.jpg)


## What is Kubernetes? 

Kubernetes, also known as K8s, is an open-source system for automating deployment, scaling, and management of containerized applications.

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
