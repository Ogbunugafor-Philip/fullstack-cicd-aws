## CI/CD Pipeline for Full-Stack Deployment on AWS Using GitHub Actions, Docker & Terraform

### Introduction

This project demonstrates the design and implementation of a complete CI/CD pipeline for deploying a full-stack application using modern DevOps tools: GitHub Actions, Docker, Terraform, and AWS. It reflects industry practices where automation, cloud infrastructure, and containerization are essential for delivering high-quality software efficiently.
The pipeline automates both Continuous Integration (CI) and Continuous Deployment (CD) processes. Whenever developers push code to GitHub, the workflow automatically installs dependencies, runs tests, builds the application, and deploys it to the cloud. The frontend (React) is deployed to Amazon S3 and served globally via CloudFront CDN, while the backend (Node.js) is containerized with Docker, pushed to AWS ECR, and deployed to a Docker-enabled EC2 instance.
All infrastructure — including S3, CloudFront, EC2, ECR, IAM, and security groups — is provisioned and managed using Terraform, ensuring the environment is reproducible and scalable. This project provides a real-world, production-grade CI/CD workflow and demonstrates end-to-end automation from development to deployment.

### Problem Statement
In many software projects, developers manually deploy code, which often leads to inconsistent environments, human error, delays, and unscalable systems. The absence of automation results in longer release cycles, increased risk of failure, and poor developer experience. There is a critical need to automate testing, deployment, and infrastructure provisioning to support fast and safe software delivery.

### Objectives
- Implement a fully automated CI/CD pipeline using GitHub Actions
- Build and test frontend and backend code on every commit
- Automatically deploy the frontend to S3 + CloudFront
- Automatically deploy the backend as a Docker container on EC2 via ECR
- Use Terraform to provision and manage all AWS infrastructure as code
- Securely connect GitHub to AWS using secrets
- Monitor the system via CloudWatch and test the live environment

### CI/CD Workflow Overview
- Developer pushes code to GitHub
- GitHub Actions triggers automatically

### CI: Continuous Integration
- Installs dependencies and runs tests for both frontend and backend

### CD: Continuous Deployment
- Frontend is built and deployed to S3
- CloudFront cache is invalidated to reflect new changes
- Backend is containerized, pushed to ECR, and deployed to EC2
- Deployed application becomes accessible via a public CloudFront URL
- Logs and pipeline status are viewable in the GitHub Actions dashboard

### Tools & Technologies Used

| **Category**              | **Tool / Technology** | **Purpose**                                         |
|--------------------------|------------------------|-----------------------------------------------------|
| Version Control          | Git + GitHub           | Code management and version control                 |
| CI/CD Automation         | GitHub Actions         | Automating testing, build, and deployment pipelines |
| Frontend                 | React.js               | Building the frontend user interface                |
| Backend                  | Node.js + Express      | RESTful API and server-side logic                   |
| Containerization         | Docker                 | Packaging the backend as a portable container       |
| Infrastructure as Code   | Terraform              | Automating AWS infrastructure provisioning          |
| Cloud Provider           | AWS                    | Hosting and deployment (S3, EC2, ECR, CloudFront)   |
| Artifact Registry        | Amazon ECR             | Storing Docker images                               |
| Static Hosting           | Amazon S3              | Hosting the frontend build artifacts                |
| CDN                      | Amazon CloudFront      | Distributing the frontend globally                  |



### Project Steps
i.	GitHub Setup 

ii.	Configure GitHub Actions

iii.	Configure GitHub Secrets

iv.	Set Up AWS Resources (Terraform)

v.	Frontend CI/CD Pipeline

vi.	Backend CI/CD Pipeline

vii.	Full Application Integration and Testing



### Project Implementation 


#### Step 1: GitHub Setup

This step lays the foundation of our CI/CD pipeline project. You start by creating a GitHub repository to store and version-control all your code, infrastructure, and automation files. This is where your pipeline logic will live and where all automation will be triggered from.


Inside your local project folder (opened in VS Code), you create:

- .github/workflows/ci-cd.yml: This is the heart of GitHub Actions. It defines when and how the CI/CD pipeline should run.
- terraform/ folder: This will contain your Infrastructure as Code (IaC) scripts used to provision AWS resources like S3, EC2, and ECR.
- Dockerfile for backend: If your backend doesn't already have one, you add this to define how the backend service should be containerized for deployment.

This setup ensures our project is structured and ready to automate deployment through GitHub Actions and AWS.

This lays the foundation for your entire project.
We’ll do three things:

##### Create the GitHub repository
- Go to GitHub and click ➕ New repository.
- Suggested repo name: fullstack-cicd-aws
 <img width="975" height="307" alt="image" src="https://github.com/user-attachments/assets/6221889f-4d9d-4821-8ee0-b771e0e46515" />

- Add a short description (CI/CD pipeline with GitHub Actions, Docker, Terraform, AWS)
  <img width="975" height="408" alt="image" src="https://github.com/user-attachments/assets/4a122bf3-0e65-4112-ba95-c37edf5f26f5" />

 - Select README.md and under .gitignore (choose Node to ignore node_modules), the click create repository
   <img width="975" height="400" alt="image" src="https://github.com/user-attachments/assets/7a3a3cc1-5d5e-45c7-84d5-11ad3aec54cc" />

 
##### Clone it to your local machine
Open your terminal or VS Code terminal and run:
```bash
git clone https://github.com/Ogbunugafor-Philip/fullstack-cicd-aws.git
``` 
<img width="842" height="181" alt="image" src="https://github.com/user-attachments/assets/94eb4477-2f7a-4559-b5dd-c9d8580e8da3" />

##### Folder & file
Open your VS Code, open your fullstack-cicd-aws folder and create the below files and folder;

- Create the .github folder
- Inside .github, create the workflows folder
- Inside .github/workflows, create the ci-cd.yml file

Create the following folder and files on your root folder
- Create the terraform folder
- Inside terraform, create your terraform files
  - main.tf
  - variables.tf
  - outputs.tf
- Create the Dockerfile, also run from your project root

Run this command to confirm your file and folder structure is correct. Run;
```bash
tree /F
```
<img width="1007" height="447" alt="image" src="https://github.com/user-attachments/assets/432f72f3-d1de-4459-adac-0e2b6733fd80" />


At this point, your local repo is ready to hold:
- Infrastructure code (terraform/)
- GitHub Actions pipeline (.github/workflows/ci-cd.yml)
- Docker backend instructions (Dockerfile)

Next, push to your github repo. Run these codes;
```bash
git add .
git commit -m "Initial project structure with Terraform and workflow folders"
git push origin main
```

The GitHub repository and local project directories have been successfully created.
All necessary folders and baseline files for the CI/CD pipeline, terraform configuration, and Docker setup are now in place.

This establishes a solid foundation for the automation and deployment phases to follow.


#### Step 2: Configure GitHub Actions
In this step, we are setting up GitHub Actions so that our project can automatically run tasks (like install dependencies and run tests) every time we push code. This helps us catch errors early and prepare the app for deployment.

- In your VS Code, go to your project folder. Navigate to: .github → workflows → ci-cd.yml. Open ci-cd.yml file.
<img width="975" height="266" alt="image" src="https://github.com/user-attachments/assets/408f310e-f9d1-44ef-9226-5fb30aabb266" />

 

- Paste the below script in the ci-cd.yml file.

[workflow/ci-cd.yml](https://github.com/Ogbunugafor-Philip/fullstack-cicd-aws/blob/main/.github/workflows/ci-cd.yml)

<img width="975" height="384" alt="image" src="https://github.com/user-attachments/assets/a502f31a-fcc4-420b-8cc6-4132cc54bf29" />

 
##### What this script would do
- Checkout code from GitHub
  - Clones your project repo into the GitHub Actions runner so it can access the code.
- Set up Node.js environment
  - Installs Node.js version 18 so that your future Node.js app will run in a matching environment.
- Install dependencies (only if package.json exists)
  - If package.json is found, it runs npm install to install dependencies.
  - If not found (like now, since there’s no app yet), it skips this step without failing.
- Run tests (only if package.json exists)
  - If package.json is found, it runs npm test to check for test results.
  - If not found, it skips this step.
  - If tests fail, it logs the error but doesn’t fail the entire workflow — since you're still in setup mode.


- Let’s now push the updates to GitHub so the pipeline can run. Run the following commands
```bash
git add .
git commit -m "Add full GitHub Actions CI workflow with tests"
git push origin main
```

- Next, we would need to test our pipeline. Go to your git repo and click Actions
  <img width="975" height="339" alt="image" src="https://github.com/user-attachments/assets/00940c83-a64e-4e7a-a367-274e899edf91" />

 
- You would see your workflow if it fails or passed. The green good means it passed and the red x means it failed. We got our pipeline right on the 5th trial
  <img width="975" height="243" alt="image" src="https://github.com/user-attachments/assets/4285548d-2969-4bbb-8a0e-f04d24798fb2" />

 
- If you click into the workflow, the to the build-and-test, you can see the details
  <img width="975" height="380" alt="image" src="https://github.com/user-attachments/assets/8769a4c3-4d47-449d-b4d2-7864a963cb17" />

 
#### Step 3: Configure GitHub Secrets

To allow GitHub Actions to securely interact with AWS, we configure credentials that enable the workflow to provision infrastructure with Terraform, push Docker images to ECR, upload frontend files to S3, deploy backend to EC2/ECS, and run other AWS CLI operations like cache invalidation or artifact storage. This setup gives GitHub full automation access across all layers of your cloud deployment.

- Create an IAM User for Github Actions in AWS Console
  - Go to IAM → Users → create user
  - Name it something like: github-cicd-deployer
  - Enable Programmatic access only
  - Attach policy: AdministratorAccess (for project/testing purpose only; limit access in production)
  - Create access key. Download the .csv file with Access Key ID and Secret Access Key

- Let us add our secret keys Credentials to GitHub
  - Go to your GitHub repo → Settings > Under security, choose Secrets and variables > Actions
    <img width="945" height="265" alt="image" src="https://github.com/user-attachments/assets/8c7bcbf2-774a-4a1f-aea3-0b37d4edf428" />

 
- Click “New repository secret” and add:
  - Add first secret: AWS_ACCESS_KEY_ID
  - Secret: Your AWS_ACCESS_KEY_ID
  - Click add secret

Then run this process again for your Access Key ID
  - Add first secret: AWS_ACCESS_KEY_ID
  - Secret: Your AWS_ACCESS_KEY_ID
  - Click add secret




#### Step 4: Set Up AWS Resources (Terraform)

In this step, we provision only the essential AWS resources required to support our GitHub-based CI/CD pipeline. These resources cover hosting, container image storage, compute infrastructure, and secure authentication — all defined using Terraform for automation and consistency.

##### Required AWS Resources
| **AWS Resource**          | **Terraform Resource Type**                  | **Purpose**                                         |
|--------------------------|----------------------------------------------|-----------------------------------------------------|
| S3 Bucket (frontend)      | aws_s3_bucket                                | Store built frontend files (React)                  |
| CloudFront Distribution   | aws_cloudfront_distribution                  | Serve frontend globally and securely                |
| ECR Repository (frontend) | aws_ecr_repository                           | Store Docker image for frontend                     |
| ECR Repository (backend)  | aws_ecr_repository                           | Store Docker image for backend                      |
| EC2 Instance              | aws_instance                                 | Run the backend container on AWS                    |
| Security Group            | aws_security_group                           | Open ports 22 (SSH), 80 (HTTP), 443 (HTTPS), 3000   |
| IAM Role for EC2          | aws_iam_role, aws_iam_instance_profile       | Allow EC2 to pull images from ECR                   |


- Create an EC2 key pair in AWS.
  - Log in to the AWS Management Console.
  - Go to EC2 Dashboard → In the left sidebar, click “Key Pairs” under Network & Security.
  - Click “Create key pair”.
  - Fill the details:
    - Name: Choose a name (e.g., my-key-pair)
    - Key pair type: Choose RSA (recommended)
    - Private key file format: Choose .pem for Linux/macOS
  - Click “Create key pair”
  - It will automatically download the private key (.pem) to your system.


- In your root folder, open the terraform folder and open the main.tf file. Paste the below code

  [terraform/main.tf](https://github.com/Ogbunugafor-Philip/fullstack-cicd-aws/blob/main/terraform/main.tf)


<img width="974" height="232" alt="image" src="https://github.com/user-attachments/assets/b7cd8543-afbf-4120-9b8a-88897339bb38" />

##### What This Terraform Code Does 
Connects to AWS

- It tells Terraform to work inside your AWS account, in the US East (N. Virginia) region.

Creates a Storage Bucket for Your Website
- It sets up an S3 bucket to store your built React frontend files (like index.html).
- Makes the bucket a public website, so people can visit it online.

Creates a Global Web Delivery System
- It creates a CloudFront Distribution (CDN) to serve your frontend from the S3 bucket quickly and securely to users all over the world.

Creates Two Docker Repositories
- One for your frontend Docker image, one for your backend Docker image
(This is where you’ll push your container images from your GitHub Actions workflow.)

Gives EC2 Permission to Pull Docker Images
- It creates an IAM Role that allows your EC2 server to connect to ECR and pull Docker images.

Sets Security Rules
- It creates a Security Group that opens up:
  - Port 22 for SSH (to log in)
  - Port 80 for websites (HTTP)
  - Port 443 for secure websites (HTTPS)
  - Port 3000 for your backend app

Finds the Latest Ubuntu Image
- It searches AWS and gets the latest Ubuntu 20.04 server image to use for your EC2 instance.

Launches an EC2 Server
- It launches one virtual server using the Ubuntu image
- It uses your key pair (CICD) so you can connect to it later
- When the server starts, it automatically:
  - Installs Docker and runs your backend app inside Docker on port 3000

Adds Useful Tags
- It tags all the resources with names like:
  - "Project": "CICDApp"
  - "Environment": "dev"

So you can recognize them easily in the AWS console.

- In your root folder, open the terraform folder and open the variables.tf file. Paste the below code

  [terraform/variables.tf](https://github.com/Ogbunugafor-Philip/fullstack-cicd-aws/blob/main/terraform/variables.tf)

 <img width="800" height="298" alt="image" src="https://github.com/user-attachments/assets/1b91c22f-c884-4061-9b8d-242652b917bc" />


- In your root folder, open the terraform folder and open the outputs.tf file. Paste the below code
  [terraform/outputs.tf](https://github.com/Ogbunugafor-Philip/fullstack-cicd-aws/blob/main/terraform/outputs.tf)

<img width="975" height="363" alt="image" src="https://github.com/user-attachments/assets/e0e80af8-ff39-4ec1-beb8-ff2ca4277d24" />
 

We are going to use two GitHub Actions workflows to automate the provisioning and deployment of infrastructure using Terraform on AWS. The setup follows best practices by separating planning from actual deployment, ensuring safe and controlled infrastructure changes.

1. terraform.yml — Auto Plan & Validation Workflow
   
This workflow is automatically triggered whenever code is pushed to the main branch or when a pull request is opened. It performs the following tasks:

- Initializes Terraform (terraform init)
- Validates Terraform syntax (terraform validate)
- Checks Terraform formatting (terraform fmt -check)
- Generates and displays the Terraform execution plan (terraform plan)
  
No infrastructure is created or changed in this workflow.
It is designed to help developers preview changes before applying them.

2. terraform-apply.yml — Manual Apply Workflow
   
This workflow is not triggered automatically. Instead, it must be manually run from the GitHub Actions tab by clicking the “Run workflow” button. When triggered, it performs:

- Terraform initialization
- Actual deployment using terraform apply -auto-approve

This ensures infrastructure changes are only applied when explicitly approved by a team member or administrator.

- Create two terraform file inside our workflows folder namely
```bash
terraform.yml
terraform-apply.yml
```

- Paste the below script into terraform.yml file

  [.github/workflows/terraform.yml](https://github.com/Ogbunugafor-Philip/fullstack-cicd-aws/blob/main/.github/workflows/terraform.yml)

 <img width="953" height="359" alt="image" src="https://github.com/user-attachments/assets/25a4c3f6-3cd4-442f-bb33-89a1e3fe128e" />


- Paste the below script into terraform-apply.yml file 

[.github/workflows/terraform-apply.yml](https://github.com/Ogbunugafor-Philip/fullstack-cicd-aws/blob/main/.github/workflows/terraform-apply.yml)

<img width="975" height="302" alt="image" src="https://github.com/user-attachments/assets/760e2d89-e1c6-43e1-a7e5-9d8b33cf6112" />

 
- Let us commit and push your Terraform files (main.tf, variables.tf, outputs.tf) and the two YAML workflows (terraform.yml, terraform-apply.yml) to GitHub. Run;
```bash
git add .
git commit -m "Add Terraform Infrastructure and GitHub Actions workflows"
git push origin main
```

Remember, we wrote two workflows for terraform. One to plan (automatic when you push to github) and two to apply (manual on github actions) so all infrastructure can be validated before creation.

Now that we have finished the plan, let us go to github and manually run the work flow for them to be created.
1. Navigate to GitHub Actions
   - Go to your GitHub repository.
   - Click on the “Actions” tab in the top menu.
   - From the left sidebar, select “Terraform Apply (Manual)” workflow.
     <img width="914" height="303" alt="image" src="https://github.com/user-attachments/assets/7039f5a8-e416-451b-9978-855845930a85" />

 

2. Trigger the Workflow Manually
   - At the top right, click the “Run workflow” button.
     <img width="927" height="328" alt="image" src="https://github.com/user-attachments/assets/2dac0136-ec70-4834-903e-9aec9e78d9ac" />

 
  - A dropdown would appear — click the green “Run workflow” button again (no input is needed).
  - This will trigger the manual apply job.


3. Monitor the Workflow
   - After triggering, you'll see a new run start under “Workflow runs.”
   - Click on the new run to open the logs.
   - Expand each step (Terraform Init, Terraform Apply, etc.) to confirm successful execution.
     <img width="909" height="305" alt="image" src="https://github.com/user-attachments/assets/d6bebd56-32f2-4400-894b-f9e7c1bf810d" />


4. Verify on AWS Console
   Once the job finishes:
   - Go to your AWS Console.
   - Check if the resources (S3, EC2, CloudFront, ECR, etc.) were created as expected.

#### Step 5: Frontend CI/CD Pipeline

Now that the infrastructure and CI/CD pipeline are fully set up, we’re putting on the hat of a frontend developer. Our goal is to build a simple, functional user interface that plugs seamlessly into the DevOps pipeline we've created.

- On your project root folder, run the command;
```bash
npx create-react-app frontend
```

This will automatically:

- Create a frontend/ folder
- Set up all the React dependencies
- Scaffold your initial React app
  <img width="975" height="335" alt="image" src="https://github.com/user-attachments/assets/ea9012b9-8226-4688-8ee4-73af44d43576" />

 
- Open frontend/src/App.js and replace the content with the below code

  [frontend/src/App.js](https://github.com/Ogbunugafor-Philip/fullstack-cicd-aws/blob/main/frontend/src/App.js)


  <img width="975" height="279" alt="image" src="https://github.com/user-attachments/assets/92cd9d48-d2f2-47a5-b7c6-671fd31b05b6" />

 

- Open frontend/src/App.css and replace the content with the below code

  [frontend/src/App.css](https://github.com/Ogbunugafor-Philip/fullstack-cicd-aws/blob/main/frontend/src/App.css)

<img width="975" height="232" alt="image" src="https://github.com/user-attachments/assets/19a67282-28bb-4f0f-ac5f-2112b7cdb50c" />

 

- In your terminal (inside the frontend/ folder), run:
```bash
npm run build
```
This command will:
- Compiles your React code
- Optimizes it for performance
- Outputs static files to frontend/build/.
  
  <img width="975" height="321" alt="image" src="https://github.com/user-attachments/assets/aa2e849d-cfb6-4c08-8454-c8e2d7fe18ec" />

 

- Create a new file in .github/workflows folder named frontend.yml and paste the below script in it

  [.github/workflows/frontend.yml](https://github.com/Ogbunugafor-Philip/fullstack-cicd-aws/blob/main/.github/workflows/frontend.yml)

 
<img width="975" height="202" alt="image" src="https://github.com/user-attachments/assets/83be6038-b75f-4ff6-970e-bc80ee754f37" />

What this script does
- Detects frontend code changes
- Installs + builds your React app
- Pushes your build to S3
- Invalidates CloudFront
- Makes your app live to the world


- Let us push it to our github and allow the workflow to be triggered. Run;
```bash
git add .
git commit -m "Trigger frontend deployment workflow"
git push origin main
```

- All workflow ran successfully

<img width="975" height="197" alt="image" src="https://github.com/user-attachments/assets/5567ac38-9c33-41c1-a905-d7260dd2773a" />

 

- Now, let us test. Let us put the cloudfront distribution domain name in our browser and see if we can access our react app.
  <img width="975" height="226" alt="image" src="https://github.com/user-attachments/assets/89c771c1-1fcb-4d51-bf07-efe1c41f16ea" />

 
Our app is live!!!!!

#### Step 6: Backend CI/CD Pipeline

In this step, we’ll build the Node.js backend, containerize it using Docker, push the image to AWS ECR, and deploy it automatically to your EC2 instance via GitHub Actions. This ensures your backend is always up-to-date and runs in a secure, reproducible environment.

- Open a folder named backend in your project root and change directory into the folder. Run; 
```bash
mkdir backend
cd backend
```

- In the backend folder, run this command;
  ```bash
  npm init -y
  ```

This creates:

- backend/ directory
- A default package.json file (basic Node.js setup)

  <img width="975" height="367" alt="image" src="https://github.com/user-attachments/assets/5e6a2a7c-0552-40bb-99c0-efeed718482a" />

 

- In your terminal inside the backend folder, run;
  ```bash
  npm install express
  ```
  This will add Express.js as a dependency and update your package.json with it.
  <img width="975" height="193" alt="image" src="https://github.com/user-attachments/assets/7ebd1b10-6c5d-4488-a7cd-68c0fe4ed89e" />

 

- Still inside the backend folder, create a new file named: index.js

- Paste the below code inside the just created index.js

 [backend/index.js](https://github.com/Ogbunugafor-Philip/fullstack-cicd-aws/blob/main/backend/index.js)

  <img width="975" height="384" alt="image" src="https://github.com/user-attachments/assets/71d82dde-aab8-4a42-b3c2-4beac0c2b9f3" />

 
- Test the backend server locally, run
```bash
node index.js
```

- Then open your browser and visit:
```bash
http://localhost:3000
```
You should see: "Hello from the backend!"
<img width="880" height="266" alt="image" src="https://github.com/user-attachments/assets/c1276437-8215-4b73-bfa0-2375fe4e4a3b" />
 

Our backend is working well.

Now let us dockerize our backend

- In the backend folder, create a file named Dockerfile
- Paste this below script inside the Dockerfile

  [backend/Dockerfile](https://github.com/Ogbunugafor-Philip/fullstack-cicd-aws/blob/main/backend/Dockerfile)

This tells Dockerfile to:
- Use Node.js v18 image
- Install your app dependencies
- Copy all source code
- Expose port 3000
- Start your server using node index.js


- Inside the backend folder, create a new file named; .dockerignore

- Paste the following content into it

  [backend/.dockerignore](https://github.com/Ogbunugafor-Philip/fullstack-cicd-aws/blob/main/backend/.dockerignore)

  <img width="975" height="262" alt="image" src="https://github.com/user-attachments/assets/e833f1b9-c1e6-4ca1-a950-248a9a7afcb3" />


 

This ensures unnecessary files (e.g., node_modules, .env) are excluded from the Docker image — improving performance and security.

- Let’s confirm the Docker image builds and runs successfully on our local machine. In the backend folder (make sure your docker desktop is running) , run;
```bash
docker build -t backend-app .
```
This tells Docker to build an image from the Dockerfile in the current folder (.) and tag it as backend-app.
 <img width="975" height="207" alt="image" src="https://github.com/user-attachments/assets/c5183f77-23e4-4aa0-b4b0-4d48840d0d99" />


- Let us run the docker we just built. Make sure you are in the backend folder project and then run;
```bash
docker run -d -p 3000:3000 backend-app
```

After the running of the docker, open your browser and go to:
```bash
http://localhost:3000
```
<img width="975" height="329" alt="image" src="https://github.com/user-attachments/assets/087fc602-19cf-4cb4-ac70-31b083cdde5e" />


We would do our first ECR push manually to:
- Confirm everything works end-to-end
- Ensure your image builds properly
- Make sure your local Docker is authenticated to ECR


That’s just for testing.
- In the backend folder, run this command to login to your amazon ecr
```bash
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 808872802370.dkr.ecr.us-east-1.amazonaws.com
``` 
<img width="975" height="172" alt="image" src="https://github.com/user-attachments/assets/21f1c2ac-f39b-47a9-8dad-4c046019b282" />

- Build Docker Image for Backend. Run this in the backend/ folder;
```bash
docker build -t backend-app .
```
<img width="975" height="212" alt="image" src="https://github.com/user-attachments/assets/5cd5804e-555b-441a-bb8d-17313644342a" />



- Tag the Docker Image for ECR. Run;
```bash
docker tag backend-app:latest 808872802370.dkr.ecr.us-east-1.amazonaws.com/cicd-backend:latest
```

- Push the Image to ECR. Run;
```bash
docker push 808872802370.dkr.ecr.us-east-1.amazonaws.com/cicd-backend:latest
```
 
- Let us SSH into EC2 created and Run Backend App. Run;
```bash
ssh -i cicd-key.pem ec2-user@<YOUR_EC2_PUBLIC_IP>
``` 
<img width="894" height="192" alt="image" src="https://github.com/user-attachments/assets/a1a8c3de-baa5-4aa7-b1ff-4ba401138a25" />

- On the EC2, install AWS CLI. Run;
```bash
sudo apt update
sudo apt install awscli -y
```
<img width="972" height="227" alt="image" src="https://github.com/user-attachments/assets/daefd9cf-6495-46ae-bdf1-b072dcefd242" />
 

Now let us modify IAM role 
- Go to your AWS Console → EC2 → Instances
- Select your EC2 instance
- Click Actions → Security → Modify IAM Role
  <img width="872" height="154" alt="image" src="https://github.com/user-attachments/assets/1dfb68ce-83ab-442b-a841-b33d718e8fee" />

 
- Attach an IAM role with the policy: (AmazonEC2ContainerRegistryReadOnly)

- Authenticate Docker to ECR. Inside your EC2 server, run;
```bash
aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 808872802370.dkr.ecr.us-east-1.amazonaws.com 
```
<img width="975" height="177" alt="image" src="https://github.com/user-attachments/assets/03673dd1-4d12-4c4d-a297-0cb6ef144ca3" />

- Pull Your Docker Image from ECR. Run this command on the EC2 terminal:
```bash
sudo docker pull 808872802370.dkr.ecr.us-east-1.amazonaws.com/cicd-backend:latest
``` 
<img width="975" height="318" alt="image" src="https://github.com/user-attachments/assets/376ebe9c-1512-4a10-bb74-6aeaca6da953" />

- Finally let’s test to be sure our docker is running from our EC2. Run;
```bash
http://<YOUR-EC2-PUBLIC-IP>:3000
```
 <img width="975" height="202" alt="image" src="https://github.com/user-attachments/assets/69860cfe-4cb3-4cc3-86a6-c504d503f80e" />


Our Dockerized backend is working. What this means is that;
- ECR is working
- Our EC2 Docker host is working
- The container runs and serves traffic
- Port 3000 is exposed and reachable
- Infrastructure is ready for automation 

Let’s securely store our .pem as a GitHub Secret so our CI/CD workflow can SSH into the EC2 server automatically.
- Go to your GitHub repository. Click on Settings → Secrets and variables → Actions
- Click “New repository secret”
- Fill the form:
  - Name: EC2_SSH_KEY
  - Value: Paste the entire .pem key you copied (including -----BEGIN and -----END lines)
- Click Add secret


Now lets us create our work flow that would do the following;
- Build your backend Docker image
- Tag it and push it to Amazon ECR
- SSH into the EC2 instance
- Pull the latest image from ECR
- Stop & remove the old container (if any)
- Run the new one on port 3000



- On your folder .github/workflows/ create a file named backend.yml and paste the below script in it.

  [.github/workflows/backend.yml](https://github.com/Ogbunugafor-Philip/fullstack-cicd-aws/blob/main/.github/workflows/backend.yml)

 <img width="975" height="417" alt="image" src="https://github.com/user-attachments/assets/c835aa84-401d-47e0-8079-feb301a70905" />


- Run the following git command on the project folder
```bash
git add .
git commit -m "Add backend CI/CD workflow"
git push origin main
```

- Our workflow worked correctly
  <img width="975" height="260" alt="image" src="https://github.com/user-attachments/assets/839c2a01-b39f-4038-b36d-aa7c8bbdc491" />

 

#### Step 7: Full Application Integration and Testing

In this step, we’ll create a new GitHub Actions workflow that integrates the frontend and backend without modifying their code. This workflow will automatically run after both CI/CD pipelines succeed, performing a simple test to confirm they work together smoothly.

- On your folder .github/workflows/ create a file named integrate.yml and paste the below script in it.

  [.github/workflows/integrate.yml](https://github.com/Ogbunugafor-Philip/fullstack-cicd-aws/blob/main/.github/workflows/integrate.yml)


  <img width="975" height="421" alt="image" src="https://github.com/user-attachments/assets/bd62c193-926a-49c7-b83a-a88a9ebfdaf2" />

 

##### What the Script Does 

This integrate.yml workflow:

- Listens for Push to main Branch: It automatically runs whenever you push code to your main branch.
  
- Builds the Frontend (React App)
  - Installs dependencies using npm install
  - Injects the backend URL (REACT_APP_API_URL=http://54.204.165.103:3000) into a .env file
  - Builds the app using npm run build
    
- Deploys to S3
  - Uploads the built React frontend to your S3 bucket: ci-cd-react-bucket-6937a42e
  - Uses aws s3 sync to keep the bucket updated and clean

- Invalidates CloudFront Cache
  - Tells CloudFront (E30DDGYWWGZN0G) to clear its cache
  - Ensures new changes appear immediately at your CloudFront link: https://dludsjga74v5f.cloudfront.net



Note: You must know these four key details before you can run the integrate workflow successfully
  - Backend API URL
  - API Base Path
  - S3 Bucket Name
  - CloudFront Distribution ID


- Run the following git command on the project folder
```bash
git add .
git commit -m "front and backend integration"
git push origin main
```
<img width="975" height="420" alt="image" src="https://github.com/user-attachments/assets/550360e4-14b5-4dc7-b12e-bb4b6fccee5b" />

Our Integration workflow is successful


Finally, lets us test to see that our frontend talks to backend when.
Open your browser to https://dludsjga74v5f.cloudfront.net and make an order
<img width="975" height="368" alt="image" src="https://github.com/user-attachments/assets/cffbe5a7-c473-4832-8940-c6c415212b2f" />

 
##### What the above screenshot means
  - Our React frontend was successfully loaded via CloudFront
  - We typed 34 into the input
  - We clicked “Place Order”
  - Frontend button made an API call to our backend
  - The backend received the request and returned a successful response
  - The message came back to the frontend and triggered the popup


#### Conclusion
This project demonstrates a complete end-to-end CI/CD pipeline for a fullstack application using modern DevOps tools and AWS cloud services. The React frontend is automatically built and deployed to Amazon S3 and served globally via CloudFront. The Node.js backend is containerized with Docker and deployed on an EC2 instance, fully integrated with the frontend via environment variables.
Through GitHub Actions, every code push to the main branch triggers an automated workflow that builds the frontend with the correct backend API URL, syncs the build to S3, and invalidates the CloudFront cache to ensure immediate updates.
This seamless integration proves the power of automation, cloud infrastructure, and CI/CD best practices — resulting in a production-ready, scalable, and maintainable application delivery pipeline.

