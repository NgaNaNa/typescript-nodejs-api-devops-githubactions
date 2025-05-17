# typescript-nodejs-api-devops-githubactions
Personal project demonstrating CICD set up on GitHub Actions for deploying TypeScript Nodejs API application --> Docker --> ECS clusters

## Usage
```bash
# Initialise from chosen environment
cd envs/dev
terraform init

# Select tfvars for the environment
# Run command from ./infra (This is where all .tf files are located)
AWS_PROFILE=node-app-terraform-dev terraform plan -var-file=envs/dev.tfvars

AWS_PROFILE=node-app-terraform-dev terraform apply -var-file=envs/dev.tfvars

The networking layer, cluding VPC is assume to already exist. (eg. created via AWS console Public Subnets, VPC, Route Table, Internet Gateway)

The AWS resources required for backend configurations were manually created via the console (eg. backend S3 for storing .tfstate files, DynamoDB for managing Lock file)