# Agrupa tudo num único mapa para cada tipo de nó
output "controlplane_nodes" {
  value = {
    for i, inst in aws_instance.controlplane :
    inst.tags.Name => {
      public_ip  = inst.public_ip
      private_ip = inst.private_ip
    }
  }
}

output "worker_nodes" {
  value = {
    for i, inst in aws_instance.worker :
    inst.tags.Name => {
      public_ip  = inst.public_ip
      private_ip = inst.private_ip
    }
  }
}