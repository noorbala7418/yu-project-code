# Ansible Project

## Prepare your infrastructure

```bash
sudo apt update
sudo apt install python3-venv
git clone https://github.com/noorbala7418/yu-project-code
cd yu-project-code
git submodule update --init --recursive

python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
pip install -r kubespray/requirements.txt
```

> Run terraform to create your vms.

### Config VMs before Setup kubernetes

```bash
ansible-playbook -i inventories/infra/hosts playbooks/infra.yml
ansible-playbook -i inventories/infra/hosts playbooks/deploy-gateway.yml
```

### Setup K8S Cluster

```bash
cd kubespray
ansible-playbook -i ../inventories/infra/hosts -b cluster.yml
```

### Install Required applications on kubernetes

```bash
ansible-playbook -i inventories/infra/hosts playbooks/k8s-applications.yml
```
