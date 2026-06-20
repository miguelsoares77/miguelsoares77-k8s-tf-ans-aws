<h2 align="center">K8s Cluster with Terraform and Ansible in AWS</h2>

<p align="center">
  <a href="https://go-skill-icons.vercel.app">
    <img src="https://go-skill-icons.vercel.app/api/icons?i=kubernetes,aws,terraform,ansible,githubactions&theme=light&perline=10" />
  </a>
</p>

## Overview

This repository provisions an AWS Kubernetes environment with Terraform and then configures the created instances with Ansible. Terraform runs from `terraform/aws-env` and uses Terraform Cloud as the workspace. Ansible playbooks are stored in `ansible/kubernetes`.

## GitHub Actions Pipeline

The workflow is defined in `.github/workflows/pipeline.yml` and is triggered manually with `workflow_dispatch`. When starting the workflow, choose one action:

- `apply`: create/update the AWS infrastructure and configure Kubernetes.
- `destroy`: destroy the Terraform-managed infrastructure.

### Apply Flow

When `action=apply`, the pipeline performs these steps:

1. Checks out the repository.
2. Installs Terraform.
3. Runs `terraform init` in `terraform/aws-env`.
4. Runs `terraform validate`.
5. Runs `terraform plan`.
6. Runs `terraform apply -auto-approve`.
7. Pulls the Terraform state into `terraform/aws-env/terraform.tfstate`.
8. Installs Ansible on the GitHub Actions runner.
9. Writes the SSH private key from GitHub Secrets to `~/.ssh/id_rsa_deploy`.
10. Generates `ansible/kubernetes/inventory.ini` from Terraform outputs.
11. Waits until the EC2 instances accept SSH connections.
12. Runs the Ansible playbooks:

```bash
ansible-playbook -i inventory.ini setup-installations.yml setup-kubernetes.yml
```

### Destroy Flow

When `action=destroy`, the pipeline runs:

```bash
terraform destroy -auto-approve
```

from `terraform/aws-env`.

## Required Configuration

Because this setup uses Terraform Cloud remote execution, AWS credentials must be available in the Terraform Cloud workspace, not only in GitHub Actions.

### Github Variables

Configure these GitHub Secrets:

- `TF_API_TOKEN`: Terraform Cloud API token.
- `SSH_PRIVATE_KEY`: private key used by Ansible to connect to EC2 instances.

### Terraform Cloud Variables

Configure these Terraform Cloud vars in your workspace:

Terraform variables:
- `region`: AWS region, for example `eu-central-1`.
- `public_key`: SSH public key used to create the AWS key pair. Mark as sensitive.

Environment Variables:

- `AWS_ACCESS_KEY_ID`: AWS access key. Mark as sensitive.
- `AWS_SECRET_ACCESS_KEY`: AWS secret key. Mark as sensitive.