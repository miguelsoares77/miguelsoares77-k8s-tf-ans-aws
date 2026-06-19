import os
import json
import logging

logging.basicConfig(level=logging.INFO, format='%(levelname)s: %(message)s')

def generate_inventory(state_file='../../terraform/aws-env/terraform.tfstate', output_file='inventory.ini'):
    try:
        with open(state_file, 'r') as f:
            data = json.load(f)
    except FileNotFoundError:
        logging.error(f"File {state_file} doesn't exist.")
        return
    except json.JSONDecodeError:
        logging.error(f"File {state_file} is not valid JSON. The file is corrupted?")
        return
    except Exception as e:
        logging.error(f"Unexpected error while reading {state_file}: {e}")
        return

    outputs = data.get('outputs', {})
    
    group_mapping = {
        "controlplane_nodes": "controlplane",
        "worker_nodes": "workers"
    }

    with open(output_file, 'w') as f:
        f.write("[all:vars]\n")
        f.write("ansible_user=ubuntu\n")
        f.write("ansible_ssh_common_args='-o StrictHostKeyChecking=no'\n")
        f.write("ansible_ssh_private_key_file=~/.ssh/id_rsa_deploy\n\n")

        for output_key, group_name in group_mapping.items():
            nodes = outputs.get(output_key, {}).get('value', {})
            if nodes:
                f.write(f"[{group_name}]\n")
                for node_name, details in nodes.items():
                    public_ip = details.get('public_ip')
                    private_ip = details.get('private_ip')
                    
                    if public_ip:
                        f.write(f"{node_name} ansible_host={public_ip}")
                        
                        if private_ip:
                            f.write(f" private_ip={private_ip}")
                        
                        f.write("\n")
                f.write("\n")

        f.write("[kubernetes:children]\n")
        f.write("controlplane\n")
        f.write("workers\n")

    print(f"Inventory generated in {output_file}")

if __name__ == "__main__":
    generate_inventory()