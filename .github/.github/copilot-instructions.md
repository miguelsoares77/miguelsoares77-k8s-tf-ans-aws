# Instruções do projeto

Este projeto é uma infra na AWS criado comm Terraform Ansible até configurar as máquinas por completo e criar um cluster Kubernetes via kubeadm.

## Regras gerais
- Terraform: usar sempre módulos separados por componente (network, ec2, security-groups).
- Variáveis sensíveis nunca hardcoded — usar variables.tf e tfvars.
- Roles do k8 são :
  - master: 1 (controlplane-1)
  - worker: 2 (worker-2, worker-3)
- O cluster é criado e destruído frequentemente.
- Ao sugerir comandos, preferir explicações curtas em vez de gerar ficheiros completos do zero.