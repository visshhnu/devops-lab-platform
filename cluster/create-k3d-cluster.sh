#!/bin/bash

echo "Creating DevOps Lab Kubernetes Cluster..."

k3d cluster create devops-lab \
  -p "80:80@loadbalancer" \
  -p "443:443@loadbalancer"

echo "Cluster created successfully."

kubectl get nodes
