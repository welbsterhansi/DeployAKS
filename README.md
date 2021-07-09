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
