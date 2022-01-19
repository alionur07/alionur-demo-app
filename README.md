# alionur-demo-app
Demo-app application is a project running on EKS using the authentication method (Api Key) of Python Rest APIs.



# Project technical stack

|  |    | 
| :-------- | :------- |
| **APP** | Python Flask |
| **DB** | Postgresql |
| **CI/CD** | Azure Devops |
| **Version-Control** | Github |
| **IAC** | Terraform Cloud |
| **Container Management Service** | Amazon EKS |
| **Container Registery** | DockerHub |
| **Monitoring** | Prometheus, Grafana, ElasticStack, Fluentd |

# Project Architecture
![image](https://user-images.githubusercontent.com/33215825/149727335-093c3307-3688-4178-bd63-2cf09fc97f4d.png)

# Application

The demo-app has 3 different microservices and each service description is given below.

- Source code path /alionur-demo-app 

- **Insertapi** : It writes data to the database with API key authentication.
- **Getapi**    : It returns json data from the database with API key authentication.
- **Homepage**  : It shows the Getapi request result with simple html template

# DB
Demo application data model and table are given below. The DB backup file is **demoapp_backup.zip**

![image](https://user-images.githubusercontent.com/33215825/150004769-0bb85e41-ebc9-488f-9a16-ac815c633624.png)

- **After restore;**

![image](https://user-images.githubusercontent.com/33215825/150010007-a4f7ac44-db3d-412a-bc47-3907e3a3dd61.png)

# IAC-Terraform
There is 3 diffrent layer for environment installation. 

![image](https://user-images.githubusercontent.com/33215825/150010435-927d4cc1-0d3b-4e82-aabf-03495c1096d9.png)

Terraform cloud had used in this project. Login with the login token obtained from Terraform cloud.
```
 terraform login
 
Do you want to proceed?
  Only 'yes' will be accepted to confirm.

  Enter a value: yes

  Token for app.terraform.io:
    Enter a value:
```
Create CLI driven workflow workspace for each layer (**The workspaces names are specified in the backend file.** ) on Terraform Cloud and configure below.
![image](https://user-images.githubusercontent.com/33215825/150012930-e90f2463-5598-41e5-b56c-671dba93be76.png)


**The layering order is important in the environment installation.**
- when setting up the environment; VPC --> EKS, RDS
- while destroying;  EKS,RDS --> VPC order should be observed.

**VPC** 
```
 terraform init
 terraform plan -var-file="../secrets.auto.tfvars"
```
if everything looks good:
```
 terraform apply -var-file="../secrets.auto.tfvars"
```

**EKS** 
```
 terraform init
 terraform plan -var-file="../secrets.auto.tfvars"
```
if everything looks good:
```
 terraform apply -var-file="../secrets.auto.tfvars"
```

**RDS** 
```
 terraform init
 terraform plan -var-file="../secrets.auto.tfvars"
```
if everything looks good:
```
 terraform apply -var-file="../secrets.auto.tfvars"
```
**Finally the EKS layer gives us Kubeconfig and we will use it on the CI/CD step. Also we can use on local.**

![image](https://user-images.githubusercontent.com/33215825/150013496-11d5b054-cd8b-4271-8dea-754df09f6d3c.png)

**Now we are going to deploy kube-prometheus-stack, nginx-ingress-controller**
```
 helm repo add prometheus-community/kube-prometheus-stack
 helm install   kube-prometheus-stack prometheus-community/kube-prometheus-stack
```
```
 helm repo add bitnami/nginx-ingress-controller
 helm install nginx-ingress-controller bitnami/nginx-ingress-controller
```
## CI/CD
**AzureDevops Build and Push Image Pipeline yaml.**
```
# Variable 'service' was defined in the Variables tab. 
# If there is a separate pipeline, variable definitions : "service = getapi", "service = insertapi" , "service = hompage".
name: $(date:yyyyMMdd)$(rev:.r)
jobs:
- job: Job_1
  displayName: Agent job 1
  pool:
    vmImage: ubuntu-20.04
  steps:
  - checkout: self
    clean: true
  - task: Docker@0
    displayName: Build Homepage Image
    inputs:
      containerregistrytype: Container Registry
      dockerRegistryEndpoint: 20efb320-9be0-4800-a0ca-0ad891a8a737
      dockerFile: alionur-demo-app/Dockerfile
      buildArguments: service=$(service)
      imageName: ' "<docker-registery>":$(service)-latest' 
  - task: Docker@0
    displayName: Push Homepage Image
    inputs:
      containerregistrytype: Container Registry
      dockerRegistryEndpoint: 20efb320-9be0-4800-a0ca-0ad891a8a737
      action: Push an image
      imageName: ' "<docker-registery>":$(service)-latest'
      imageNamesPath: ' alionur-demo-app'
```
**AzureDevops Deploy App with Helm Pipeline yaml.**
```
steps:
- task: HelmInstaller@0
  displayName: 'Install Helm 3.5.4'
  inputs:
    helmVersion: 3.5.4
steps:
- task: HelmDeploy@0
  displayName: 'helm upgrade'
  inputs:
    connectionType: 'Kubernetes Service Connection'
    kubernetesServiceConnection: 'alionur-demo-app'
    command: upgrade
    chartType: FilePath
    chartPath: '$(System.DefaultWorkingDirectory)/alionur07_alionur-demo-app/helm/homepage'
    releaseName: homepage
    valueFile: '$(System.DefaultWorkingDirectory)/alionur07_alionur-demo-app/helm/homepage/values.yaml'
```
----------------------------------
## The application homepage
![image](https://user-images.githubusercontent.com/33215825/150142660-ab126481-9b40-4de0-b170-dfd3044ac092.png)

## Postmant insert api result
![image](https://user-images.githubusercontent.com/33215825/150142779-cf4540b3-8233-45de-b82d-146bf3a889d1.png)

## Postmant get api result
![image](https://user-images.githubusercontent.com/33215825/150142901-112f84c6-9ab6-4547-9083-b3ad6da2246c.png)


## Monitoring
```
kubectl port-forward svc/kube-prometheus-stack-grafana 8081:80
```
```
user: admin
pass: prom-operator
```
![image](https://user-images.githubusercontent.com/33215825/150185778-3c7161a4-6606-4457-b90b-17fda4e92327.png)
![image](https://user-images.githubusercontent.com/33215825/150185933-12ccd433-f87f-4cf7-a9bf-d155538c4af2.png)

**Logging**
```
kubectl create ns alionur-demo-elk
kubectl apply -f .\all-in-one.yaml
kubectl apply -f .\elasticsearch.yaml
kubectl apply -f .\kibana.yaml 
`````
- Replace the elastic password in /ECK/fluentd/values.yaml with the received secret **elastic-eck-es-elastic-user**.

![image](https://user-images.githubusercontent.com/33215825/150213912-d12a0642-08bf-4221-9773-2e31389dd4a8.png)

![image](https://user-images.githubusercontent.com/33215825/150213697-37dc4bc4-acf7-4cbd-82e0-1d0d65e0fdb4.png)
```
helm install fluend fluentd/ -n alionur-demo-elk
```

![image](https://user-images.githubusercontent.com/33215825/150213440-4319266b-ccb3-40bf-b7d0-6fb912b495bb.png)

**Destroy**
```
cd terraform/eks
terraform destroy -auto-approve -var-file="../secrets.auto.tfvars"
```
```
cd terraform/rds
terraform destroy -auto-approve -var-file="../secrets.auto.tfvars"
```
```
cd terraform/vpc
terraform destroy -auto-approve -var-file="../secrets.auto.tfvars"
```
