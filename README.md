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

