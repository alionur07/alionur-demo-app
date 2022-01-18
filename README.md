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
| **Management of Containerized applications** | Amazon EKS |
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
