# Terraform Flight-predict — Infrastructure

Automatisation et déploiement du projet [flight-predict](https://github.com/Akane-push/flight-predict) sur OVH Cloud.

**Note:** Le dépôt GitHub est un miroir du projet principal hébergé sur [GitLab](https://gitlab.com/Akane-Push/terraform-flight-predict)
Le projet principal (Airflow, APIs, manifests K8s) se trouve sur un dépôt séparé:
    - [GitHub](https://github.com/Akane-push/flight-predict)
    - [GitLab](https://gitlab.com/Akane-Push/flight-predict)

## Objectif

Le projet automatise la chaîne complète, de l'infrastructure brute jusqu'à l'application fonctionnelle :

```
Terraform (OVH)  →  Ansible  →  Terraform (Helm)
  Provisionne        Configure      Déploie
  les VMs             les VMs        l'app
```

## Infra cible

| Serveur | Rôle |
|---|---|
| `k3s-server` | Cluster K3s, héberge Airflow et les APIs (runner-test-kube) |
| `runner-build` | Build et push des images Docker (runner-build GitLab) |

## État d'avancement

- [x] **Étape 1 — Provisionnement (Terraform + OVH):** Création des 2 VMs Ubuntu, gestion de la clé SSH
- [ ] **Étape 2 — Configuration (Ansible):** Installation de K3s, Docker, enregistrement des runners GitLab
- [ ] **Étape 3 — Déploiement applicatif (Terraform + Helm):** Déploiement des charts Helm (Airflow, APIs) sur K3s
- [ ] **Étape 4 — Automatisation complète (Gitlab CI):** Automatisation globale via GitLab CI.

## Prérequis

- Un compte OVH avec le Public Cloud activé
- Une paire de clés SSH locale
- Les credentials ([API OVH](https://eu.api.ovh.com/createToken/))
- Les credentials OpenStack (fichier OpenRC téléchargé depuis le manager OVH)
- Terraform >= 1.0

## Configuration

Copier le fichier d'exemple et le remplir avec vos valeurs :

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
```

```hcl
# OVH API
ovh_application_key    = "..."
ovh_application_secret = "..."
ovh_consumer_key       = "..."

# OpenStack (depuis le fichier OpenRC)
os_tenant_id   = "..."
os_tenant_name = "..."
os_username    = "..."
os_password    = "..."
os_region      = "..."

# SSH
ssh_public_key_path = "./id_ed25519.pub"
```

> `terraform.tfvars` et `*.pub` sont listés dans `.gitignore` et ne seront jamais committés.

## Utilisation

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

À la fin du déploiement, les IPs publiques des deux VMs sont affichées :

```bash
terraform output
```

## Détruire l'infrastructure

Pour éviter de consommer des crédits inutilement en dehors des sessions :

```bash
terraform destroy
```

## Notes

Le security group `default` fourni par OVH est utilisé tel quel (le quota de security groups custom est à 0 sur ce projet). Il autorise déjà tout le trafic entrant nécessaire.
