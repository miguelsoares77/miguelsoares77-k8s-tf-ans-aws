# Instruções do projeto

Este projeto provisiona infraestrutura na AWS com Terraform e configura
com Ansible até montar um cluster Kubernetes via kubeadm.

## Regras gerais
- Terraform: usar sempre módulos separados por componente (network, ec2, security-groups).
- Variáveis sensíveis nunca hardcoded — usar variables.tf e tfvars.
- Ansible: organizar em roles (k8s-common, k8s-master, k8s-worker).
- Todo o código deve ser idempotente, já que o cluster é criado e destruído frequentemente.
- Ao sugerir comandos, preferir explicações curtas em vez de gerar ficheiros completos do zero.