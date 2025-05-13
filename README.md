# typescript-nodejs-api-devops-githubactions
Personal project demonstrating CICD set up on GitHub Actions for deploying TypeScript Nodejs API application --> Docker --> ECS clusters

## Usage
```bash
# Initialise from chosen environment
cd envs/dev
terraform init

# Select tfvars for the environment
terraform plan -var-file=dev.tfvars
