# Plotly DevOps Homework Assignment

## Deploy the python application locally using Docker Compose

Here are the steps to deploy the Flask API locally using Docker Compose

- Create a repo in github with name k8s-homework
- Generate ssh-keys for github authentication using the following command:
```
 ssh-keygen -t rsa 4096
```
- Add the ssh public key to github
- Clone the repo from github using https: git clone https://github.com/ibrt2016/k8s-homework.git
- Extract the zip and move the content to the cloned repo
- Inside the app directory, update the requirements.txt file as following:
```
    Flask==2.2.2
    Flask-MySQL==1.4.0
    PyMySQL==0.9.3
    uWSGI==2.0.17.1
    mysql-connector-python
    cryptography
```

- Inside the app directory, create a Docker file (Dockerfile) and add the following content:
```
    FROM python:3.8.5
    COPY . /app
    WORKDIR /app
    RUN pip install -r requirements.txt
    ENTRYPOINT ["python"]
    CMD ["userapi.py"]
```

- Create a db directory in the root of the repo
- Inside the db directory, create a file named user.sq; with the following content:
```
    CREATE DATABASE usersdemo;
    use usersdemo;

    CREATE TABLE `users` (
      `user_id` int unsigned NOT NULL AUTO_INCREMENT,
      `user_name` varchar(50) NOT NULL,
      `user_email` varchar(100) NOT NULL,
      `user_password` varchar(250) NOT NULL,
      PRIMARY KEY (`user_id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

    insert  into `users`(`user_id`,`user_name`,`user_email`,`user_password`) values
    (1,'Soumitra Roy','sroy@gmail.com','Ibr@20222'),
    (2,'Rahul Kumar','rahul@gmail.com','Ibr@20223');
```

- Create a docker-compose.yml file in the root of the repo and add the following content:
```
    version: "3"
    services:
      app:
        build: ./app
        links:
          - db
        ports:
          - "5000:5000"
        env_file:
          - ./var.env

      db:
        image: mysql:8.0.21
        ports:
          - "30000:3306"
        environment:
          MYSQL_ROOT_PASSWORD: root
        volumes:
          - ./db:/docker-entrypoint-initdb.d/:ro
```

- Create a file named var.env in the root of the repo and add the following content:
```
  db_root_password=root
  db_name=usersdemo
  MYSQL_SERVICE_HOST=db
  MYSQL_SERVICE_PORT=3306
```

- From the terminal, navigate to the root of the repo and (where the docker-compose.yml is located) and run the following command: docker-compose up --build
- You should see the two containers running (the api one and the db one)

- Navigate to a browser (Google Chrome for example) and type localhost:5000/users and you should get the following result:
```
  [[1,"Soumitra Roy","sroy@gmail.com","Ibr@20222"],[2,"Rahul Kumar","rahul@gmail.com","Ibr@20223"]]
```

## Deploy the python application to an AKS cluster using Github Acions

Here are the steps to deploy the Flask API to an AKS cluster using Github Acions

- Clone the repo from github using https: git clone https://github.com/ibrt2016/k8s-homework.git
- Create a SPN for Github Actions in order to authenticate to Azure using this command:
```
 az ad sp create-for-rbac --name "spn-kubehomework" --role Owner --scope /subscriptions/<subscriptionid> --sdk-auth
```

- Copy the JSON output of the above command and create a repository secret with the name AZURE_CREDENTIALS with a value of the copied content
- Create the follwing repository secrets AZURE_SP_CLIENT_ID, AZURE_SP_CLIENT_SECRET, AZURE_SUBSCRIPTION_ID and AZURE_TENANT_ID and put their values based on the output of the az ad sp create-for-rbac command
- Go to file .github\workflows\actions-ci-cd-aks-tf-backend-jobs.yml and change the environment variables STORAGE_NAME and ACR_NAME in order to be globally unique (just append some random characters at the end of the name)
- Commit and push the changes using:
```
  git add .
  git commit -m "Commit message"
  git push
```
- The workflow should on push to the main branch
- After the workflow has completed, navigate to the AKS cluster in the Azure portal, and go to Services and ingresses then select the api-service and navigate to the External IP
- You should see the application running
- In order to test it, append /users to the url in order to get the list of all users in JSON format.



## Goal

Your goal is to show how you would build, and deploy the included application
using Kubernetes .

## Assignment

Your task is to accomplish the following:

- Build a small Kubernetes test cluster either locally or in the cloud. A single
  node is fine. Feel free to use Terraform with a cloud provider or an
  all-in-one tool for a local cluster (minikube, microk8s, or k3d)
- Build Docker file for the sample application
- Build a deployment mechanism for the app
- Describe a plan for continuous delivery with the specific tools/vendors you'd
  look at and your evaluation criteria for them

## Deliverables

We'd like to see a repo with the following:

- A Dockerfile for the application
- Repeatable deployment mechanism for the application
- A README with the set-up process so we can run it ourselves
- A text file with a BRIEF write-up about the following:
  - Continuous Delivery plan for the app ecosystem
  
## Notes

- Please do not fork or submit a PR to this repo
- If you get stuck or need more information, please reach out for clarity
- Have fun!

