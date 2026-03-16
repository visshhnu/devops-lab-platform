# DevOps GitOps Platform Lab 

This repository demonstrates a **production-style DevOps platform** built using Kubernetes, GitOps principles, and automated container deployments.

The platform deploys a **Python Flask microservice** across multiple environments (**dev, stage, prod**) using **ArgoCD** for GitOps-based continuous delivery.

---

# Architecture Overview

Developer → GitHub  
│  
│ push code  
▼  
Docker Build  
│  
▼  
DockerHub Registry  
│  
▼  
ArgoCD (GitOps)  
│  
▼  
Kubernetes (k3d Cluster)  
│  
├── Dev Environment  
├── Stage Environment  
└── Prod Environment  

---

# Technology Stack

| Component | Tool |
|--------|--------|
| Container Runtime | Docker |
| Container Registry | DockerHub |
| Kubernetes | k3d |
| GitOps Deployment | ArgoCD |
| Ingress Controller | NGINX Ingress |
| Application | Python Flask |
| Version Control | GitHub |

---

# Repository Structure

devops-lab-platform
│
├── apps
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
│
├── kubernetes
│   └── python-pipeline
│        ├── argocd
│        │     ├── python-pipeline-dev-app.yaml
│        │     ├── python-pipeline-stage-app.yaml
│        │     └── python-pipeline-prod-app.yaml
│        │
│        ├── dev
│        │     ├── python-pipeline-deployment.yaml
│        │     └── python-pipeline-namespace.yaml
│        │
│        ├── stage
│        │     ├── python-pipeline-deployment.yaml
│        │     └── python-pipeline-namespace.yaml
│        │
│        └── prod
│              ├── python-pipeline-deployment.yaml
│              └── python-pipeline-namespace.yaml
│
├── cluster
│   └── create-k3d-cluster.sh
│
├── docs
│   └── setup-guide.md
│
├── scripts
│
└── tests
    └── test_app.py

---

# Environment URLs

| Service | URL |
|------|------|
| ArgoCD UI | http://argocd.devops-lab.local |
| Python Dev | http://python.dev.devops-lab.local |
| Python Stage | http://python.stage.devops-lab.local |
| Python Prod | http://python.prod.devops-lab.local |

---

# Local DNS Configuration

Add the following entries to your hosts file.

Windows:

C:\Windows\System32\drivers\etc\hosts

Add:

127.0.0.1 argocd.devops-lab.local  
127.0.0.1 python.dev.devops-lab.local  
127.0.0.1 python.stage.devops-lab.local  
127.0.0.1 python.prod.devops-lab.local  

---

# Container Image

Docker images are stored in DockerHub:

docker.io/visshhnu/python-pipeline

Example tags:

docker.io/visshhnu/python-pipeline:dev  
docker.io/visshhnu/python-pipeline:stage  
docker.io/visshhnu/python-pipeline:prod  

---

# GitOps Workflow

1. Developer pushes code to GitHub
2. Docker image is built and pushed to DockerHub
3. Kubernetes manifests are updated
4. ArgoCD detects changes in Git
5. ArgoCD automatically synchronizes the Kubernetes cluster

---

# Environment Setup

Create k3d cluster

./cluster/create-k3d-cluster.sh

Install NGINX Ingress

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

Install ArgoCD

kubectl create namespace argocd  
kubectl apply -n argocd -f kubernetes/python-pipeline/argocd/install-argocd.yaml

Deploy Dev Application

kubectl apply -f kubernetes/python-pipeline/argocd/python-pipeline-dev-app.yaml

---

# Testing

kubectl get pods -n python-pipeline

curl http://python.dev.devops-lab.local

Expected:

Welcome to the micro-services demo!

---

# Future Enhancements

• GitHub Actions CI/CD pipeline  
• Prometheus monitoring  
• Grafana dashboards  
• Loki logging  
• Helm charts  

---

# Author

DevOps GitOps Lab by **visshhnu**
