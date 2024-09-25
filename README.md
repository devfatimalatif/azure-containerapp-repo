# azure-containerapp-repo
Azure Container App Deployment Using Terraform
This repository contains Terraform configuration for deploying an Azure Container App that runs a specified application. The deployment process is modular, enhancing reusability and enabling easy updates or replication of the infrastructure.

Features
    Azure Container App: Automatically deploys a containerized application in Azure.
    Terraform Modules: Infrastructure is defined using reusable Terraform modules for easy replication.
    Scalable and Flexible: The configuration supports scaling, updating, and managing multiple environments (e.g., dev, staging, production).
    Variables for Customization: Customize resources like CPU, memory, container image, environment variables, etc., using input variables.
    Prerequisites
    Terraform installed (v1.9.5 or later).
    Azure CLI installed and authenticated.
    An active Azure subscription.
    Container registry with the application's Docker image uploaded (if using a private registry).

Getting Started

Clone the Repository:
git clone https://github.com/your-repository-url.git

Customize Variables: Define your variables in terraform.tfvars (or pass them through the command line) for things like resource group name, container image, app environment, etc. Example:


Initialize Terraform: Run Terraform initialization to set up the working directory and install necessary modules.

terraform init
Plan the Deployment: Preview the changes that Terraform will apply to your Azure environment.

terraform plan
Apply the Deployment: Deploy the container app and other associated resources by applying the Terraform configuration.

terraform apply
Access the Application: Once the deployment is complete, Terraform will output the URL where the containerized application is accessible.