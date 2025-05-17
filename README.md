# TypeScript Node.js API → Docker → Amazon ECS
*(local build & Terraform deploy – GitHub Actions pipeline coming soon)*

This repo walks you through containerising a simple Express API, pushing the image to Docker Hub, and standing up the runtime stack on **Amazon ECS (EC2 capacity)** with **Terraform**.  
The VPC, public subnets, Internet Gateway, and Terraform remote-state bucket (S3 + DynamoDB) are assumed to exist already.

---

## Prerequisites

| Tool / service | Notes |
|----------------|-------|
| **AWS CLI v2** | Profile used below: `node-app-terraform-dev` |
| **Terraform ≥ 1.7** | Remote backend: S3 bucket `node-app-infra-tfstate-<env>` |
| **Docker v24+** | Buildx enabled (comes pre‑installed) |
| **Docker Hub account** | Public repo: `nrampling/demo-node-app` |

---

## 1 · Initialise Terraform (one‑time per env)

```bash
cd infra
terraform init -reconfigure -backend-config=bucket=node-app-infra-tfstate-dev -backend-config=profile=node-app-terraform-dev
```

---

## 2 · Build & push the container image (Apply new version tag where appropriate)

```bash
docker buildx build --platform linux/amd64 -t nrampling/demo-node-app:1.0.2 --push .
```

Update the image tag in `infra/envs/dev.tfvars`:

```hcl
node_app_image = "nrampling/demo-node-app:1.0.2"
```

---

## 3 · Deploy with Terraform

```bash
AWS_PROFILE=node-app-terraform-dev terraform plan -var-file=envs/dev.tfvars

AWS_PROFILE=node-app-terraform-dev terraform apply -var-file=envs/dev.tfvars
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

## What’s next?

* **CI/CD (GitHub Actions)** – automated test → build amd64 image → push to Docker Hub → Terraform plan / apply.  
  *(workflow file will be added in a future commit.)*
* **HTTPS** – attach an ACM‑managed certificate and redirect port 80.
* **Graviton (ARM)** – build multi‑arch image and switch the ASG to `t4g` instances.

---

## Contributing

1. Create feature branch (`feature/<topic>`).
2. Run `npm test` and `docker buildx build --platform linux/amd64 .`.
3. Open a PR; describe the change clearly.

---

## Maintenance tips

* `terraform validate` before every commit.  
* Rotate Docker Hub and AWS credentials regularly.  
* Use Dependabot or Renovate for dependency PRs.  
* Watch the CloudWatch metric **ContainerExitCode >= 1** to catch crashes early.

---

## Author

Nga Rampling
