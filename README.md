# TypeScript Node.js API → Docker → Amazon ECS
*(local build & Terraform deploy – GitHub Actions EKS Infra CICD pipeline)*

This repo walks you through containerising a simple Node.js API, pushing the image to Docker Hub, and provisioning the infrastructure on **Amazon EKS (EC2 capacity)** with **Terraform**. 
The VPC, Public Subnets, Internet Gateway, Route Table and Terraform remote-state bucket (S3 + DynamoDB) are assumed to exist already.

Remote backend: S3 bucket `node-app-eks-tfstate-<env>`

## 1 · Initialise Terraform (one‑time per env)

```bash
cd infra/eks
terraform init -reconfigure -backend-config=bucket=node-app-eks-tfstate-dev -backend-config=profile=node-app-terraform-dev
```

## 3 · Deploy with Terraform from directory infra/eks/

```bash
AWS_PROFILE=node-app-terraform-dev terraform plan -var-file=../envs/dev.tfvars

AWS_PROFILE=node-app-terraform-dev terraform apply -var-file=../envs/dev.tfvars
```



# TypeScript Node.js API → Docker → Amazon ECS
*(local build & Terraform deploy – GitHub Actions ECS Infra CICD pipeline)*

This repo walks you through containerising a simple Node.js API, pushing the image to Docker Hub, and provisioning the infrastructure on **Amazon ECS (EC2 capacity)** with **Terraform**. 
The VPC, Public Subnets, Internet Gateway, Route Table and Terraform remote-state bucket (S3 + DynamoDB) are assumed to exist already.

---

## Prerequisites

| Tool / service | Notes |
|----------------|-------|
| **AWS CLI v2** | Profile used below: `node-app-terraform-<env>` |
| **Terraform ≥ 1.11.3** | Remote backend: S3 bucket `node-app-infra-tfstate-<env>` |
| **Docker v20.10.18+** | Buildx enabled (comes pre‑installed) |
| **Docker Hub account** | Public repo: `nrampling/demo-node-app` |

---

## 1 · Initialise Terraform (one‑time per env)

```bash
cd infra/ecs
terraform init -reconfigure -backend-config=bucket=node-app-infra-tfstate-dev -backend-config=profile=node-app-terraform-dev
```

---

## 2 · Local Build & push the container image (Apply new version tag)

```bash
docker buildx build --platform linux/amd64,linux/arm64 -t nrampling/demo-node-app:1.0.2 --push .
```
For ECS workload
Update the image tag in `infra/ecs/envs/dev.tfvars`:
For EKS workload
Update the image tag in `infra/eks/envs/dev.tfvars`:

```hcl
node_app_image = "nrampling/demo-node-app:1.0.2"
```

---

## 3 · Deploy with Terraform from directory infra/ecs/

```bash
AWS_PROFILE=node-app-terraform-dev terraform plan -var-file=../envs/dev.tfvars

AWS_PROFILE=node-app-terraform-dev terraform apply -var-file=../envs/dev.tfvars
```

### Outputs (example only - plug in aws account)

```text
alb_dns_name = dev-app-alb-123456.ap-southeast-2.elb.amazonaws.com
cluster_name = dev-ecs-cluster
```

Open:

```
http://dev-app-alb-123456.ap-southeast-2.elb.amazonaws.com/ping
```

once the ALB target turns **healthy**.

---

## Contributing

1. Create feature branch (`feature/<topic>`).
2. Open a PR; describe the change clearly.

---

## Maintenance tips

* `terraform validate` before every commit. Do it from /infra
* Rotate Docker Hub and AWS credentials regularly.   
* Create some kind of CloudWatch monitoring. ie CloudWatch metric **ContainerExitCode >= 1** to catch crashes.

---

## GitHub Actions for Terraform CI/CD – Demo Node.js API App
This GitHub Actions workflow automates the infrastructure provisioning lifecycle for the demo Node.js app using Terraform.

### Workflow Triggers
Pull Requests to main: Run CI checks (format, validate, plan).

Push to main: Auto-applies Terraform to deploy infrastructure in dev.

### Job: terraform-dev
- Runs inside the infra/ directory

- terraform init: Uses a backend config with an S3 bucket passed as a secret.

- On PRs:
  - Checks formatting consistency.
  - Validates Terraform configuration.
  - Creates an execution plan using envs/dev.tfvars
  - Automatically comments the plan and outcomes back to the PR using actions/github-script.

- On Plan Failure:
  - Marks the PR check as failed (exit 1).

- On Push to Main:
  - Executes terraform apply with dev.tfvars, auto-approving without manual input.

### Security and Permissions
GitHub token permissions are explicitly set to allow reading content and commenting on PRs.

### Notes
Production-related jobs (terraform-prod-ci and terraform-prod-cd) are defined but commented out (Preparation for future)
The workflow is scoped to infrastructure compute resource only deployments, not application code or Docker builds.

---

## What’s next?

* **CI/CD (GitHub Actions)** – automated test → build amd64 image → push to Docker Hub → Terraform plan / apply.  
  *(workflow file will be added in a future commit.)*
* **HTTPS** – attach an ACM‑managed certificate
* **Graviton (ARM)** – build multi‑arch image and switch the ASG to `t4g` instances.

---

## Author

Nga Rampling

# Testing 