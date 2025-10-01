# Kubernetes Setup Using Terraform, Ansible, and kubeadm

This project provides a simple example for deploying a Kubernetes cluster on AWS using Terraform for infrastructure provisioning and Ansible for cluster setup with `kubeadm`.

## Prerequisites

- Ubuntu nodes
- A kubeadm-based Kubernetes cluster
- `etcdctl` v3.6.x
- `etcdutl` v3.6.x
- `crictl` (for interacting with containerd)

## Usage

1. **Prepare Ansible Inventory**  
   Create an `inventory.ini` file inside the `ansible` directory with the IP addresses of your nodes.

2. **Set Up SSH Key**  
   Ensure you have an SSH key for node access, Ansible looks for:

   ```bash
   ~/.ssh/k8s-key
   ```

3. Provision Infrastructure
   From the terraform directory, apply the configuration:

   ```bash
   terraform apply
   ```

4. Deploy Kubernetes Cluster
   From the ansible directory, run the playbook:

   ```bash
   ansible-playbook site.yml
   ```
