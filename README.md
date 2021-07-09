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
$ sudo docker build -t=webapp3 .
$ docker tag a610345fe03c welbsterhansi/atlantico-app
$ docker push welbsterhansi/atlantico-app:v.2.0
```
## Create cluster AKS with terraform:

```
$ terraform init
$ terraform plan
$ terraform apply --auto-approve
$ terraform output kube_config > ~/.kube/aksconfig
$ export KUBECONFIG=~/.kube/aksconfig
$ kubectl get nodes
```
