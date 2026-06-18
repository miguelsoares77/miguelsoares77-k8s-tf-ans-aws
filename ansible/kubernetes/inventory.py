import os
import json
import logging

logging.basicConfig(level=logging.INFO, format='%(levelname)s: %(message)s')

def generate_inventory(state_file='../../terraform/aws-env/terraform.tfstate.backup', output_file='test.ini'):

    try:
        with open(state_file, 'r') as f:
            data = json.load(f)
            
    except FileNotFoundError:
        logging.error(f"O ficheiro {state_file} não existe. Execute 'terraform apply' primeiro.")
        return
    except json.JSONDecodeError:
        logging.error(f"O ficheiro {state_file} não é um JSON válido. O ficheiro está corrompido?")
        return
    except Exception as e:
        logging.error(f"Erro inesperado ao ler {state_file}: {e}")
        return
        
    outputs = data.get('outputs', {})
    
    group_mapping = {
        "controlplane_nodes": "controlplane",
        "worker_nodes": "workers"
    }

    with open(output_file, 'w') as f:
        for output_key, group_name in group_mapping.items():
            nodes = outputs.get(output_key, {}).get('value', {})
            if nodes:
                f.write(f"[{group_name}]\n")
                for node_name, details in nodes.items():
                    ip = details.get('public_ip')
                    if ip:
                        f.write(f"{node_name} ansible_host={ip}\n")
                f.write("\n")

    print(f"Inventory generated.")

generate_inventory()