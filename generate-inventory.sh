#!/bin/bash
set -e
 
TERRAFORM_DIR="./terraform"
INVENTORY_FILE="./ansible/inventory/hosts.ini"
KUBECONFIG_FILE="./terraform-k3s/kubeconfig.yaml"
 
# Retrieve IPs from Terraform outputs  ================================================
K3S_IP=$(terraform -chdir=$TERRAFORM_DIR output -raw k3s_server_ip)
RUNNER_IP=$(terraform -chdir=$TERRAFORM_DIR output -raw server_build_ip)
 
# Generate Ansible inventory  ================================================
cat > "$INVENTORY_FILE" << INVENTORY
[k3s_server]
k3s-server ansible_host=$K3S_IP
 
[runner_build]
runner-build ansible_host=$RUNNER_IP
INVENTORY
 
echo "Inventory generated: $INVENTORY_FILE"
echo "k3s-server   → $K3S_IP"
echo "runner-build → $RUNNER_IP"
 
# Add SSH keys to known_hosts  ================================================
echo "Adding SSH keys to known_hosts..."
ssh-keyscan -H $K3S_IP >> ~/.ssh/known_hosts
ssh-keyscan -H $RUNNER_IP >> ~/.ssh/known_hosts
 
# Retrieve kubeconfig from K3s server  ================================================
echo "Retrieving kubeconfig..."
scp -i ./id_ed25519.pem ubuntu@$K3S_IP:/home/ubuntu/.kube/config $KUBECONFIG_FILE
 
# Replace 127.0.0.1 with the public IP of the K3s server  ================================================
sed -i "s/127.0.0.1/$K3S_IP/g" $KUBECONFIG_FILE

# Get Node name  ================================================
NODE_NAME=$(kubectl --kubeconfig=$KUBECONFIG_FILE get nodes -o jsonpath='{.items[0].metadata.name}')

echo "K3s node name: $NODE_NAME"
echo "Kubeconfig retrieved: $KUBECONFIG_FILE"
echo "Done!"
