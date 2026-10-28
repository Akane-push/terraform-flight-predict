flowchart TD

subgraph group_provisioning["VM provisioning"]
  node_vm_resources["VM resources<br/>[vms.tf]"]
  node_ssh_keys["SSH key setup<br/>[ssh.tf]"]
  node_firewall["Firewall example"]
  node_vm_outputs["VM outputs<br/>[outputs.tf]"]
end

subgraph group_configuration["Host configuration"]
  node_ansible_inventory["Host inventory"]
  node_common_role["Common setup<br/>[main.yml]"]
  node_docker_role["Docker setup<br/>[main.yml]"]
  node_k3s_role["K3s setup<br/>[main.yml]"]
  node_runner_role["GitLab runners<br/>[main.yml]"]
end

subgraph group_deployment["Cluster deployment"]
  node_helm_config["Helm deployment config"]
end

node_operator(("Operator"))
node_ovh["OVH Cloud"]
node_gitlab["GitLab"]
node_k3s_cluster["K3s cluster"]

node_operator -->|"runs Terraform"| node_vm_resources
node_vm_resources -->|"provisions VMs"| node_ovh
node_operator -->|"configures hosts"| node_ansible_inventory
node_ansible_inventory -->|"targets servers"| node_k3s_role
node_ansible_inventory -->|"targets runner"| node_docker_role
node_ansible_inventory -->|"registers runners"| node_runner_role
node_runner_role -->|"registers with"| node_gitlab
node_operator -.->|"deploys charts"| node_helm_config
node_helm_config -.->|"deploys to"| node_k3s_cluster

classDef toneNeutral fill:#f8fafc,stroke:#334155,stroke-width:1.5px,color:#0f172a
classDef toneBlue fill:#dbeafe,stroke:#2563eb,stroke-width:1.5px,color:#172554
classDef toneAmber fill:#fef3c7,stroke:#d97706,stroke-width:1.5px,color:#78350f
classDef toneMint fill:#dcfce7,stroke:#16a34a,stroke-width:1.5px,color:#14532d
classDef toneRose fill:#ffe4e6,stroke:#e11d48,stroke-width:1.5px,color:#881337
classDef toneIndigo fill:#e0e7ff,stroke:#4f46e5,stroke-width:1.5px,color:#312e81
classDef toneTeal fill:#ccfbf1,stroke:#0f766e,stroke-width:1.5px,color:#134e4a
class node_vm_resources,node_ssh_keys,node_firewall,node_vm_outputs toneBlue
class node_ansible_inventory,node_common_role,node_docker_role,node_k3s_role,node_runner_role toneAmber
class node_helm_config toneMint
class node_operator,node_ovh,node_gitlab,node_k3s_cluster toneIndigo