# DevOps Lab Platform

Local DevOps environment built on:

- Windows + WSL2 Ubuntu
- Docker Desktop
- k3d Kubernetes cluster
- Traefik Ingress
- ArgoCD GitOps

## Architecture

Browser
   │
devops-lab.local
   │
Windows Hosts File
   │
Traefik Ingress
   │
Kubernetes Services
   │
Pods

## Components

- Kubernetes (k3d)
- Traefik Ingress
- ArgoCD
- Sample Applications

## Access

ArgoCD UI

http://argocd.devops-lab.local
