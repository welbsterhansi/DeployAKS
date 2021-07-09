# DeployAKS
Deploy a simple app with Docker , Terraform and Aks.


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
```
