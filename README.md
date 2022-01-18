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


