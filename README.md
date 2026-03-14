# DevOps Lab Platform

A local **DevOps platform** built using Kubernetes, Docker, WSL2, and
ArgoCD for learning modern DevOps and GitOps workflows.

This repository documents the full setup of a **local DevOps
environment** that simulates a real internal engineering platform used
by DevOps teams.

------------------------------------------------------------------------

## Architecture Overview

    Windows Host
       │
    WSL2 Ubuntu
       │
    Docker Desktop
       │
    k3d Kubernetes Cluster
       │
    Traefik Ingress Controller
       │
    ArgoCD GitOps Platform
       │
    Applications / Microservices

------------------------------------------------------------------------

## Core Components

  Component            Purpose
  -------------------- --------------------------------------------------
  **WSL2 Ubuntu**      Linux development environment on Windows
  **Docker Desktop**   Container runtime
  **k3d**              Lightweight Kubernetes cluster running in Docker
  **Kubernetes**       Container orchestration
  **Traefik**          Ingress controller for routing traffic
  **ArgoCD**           GitOps continuous deployment platform

------------------------------------------------------------------------

## Local Domain Access

Services can be accessed using custom local domains instead of localhost
ports.

Example:

  Service   URL
  --------- --------------------------------
  ArgoCD    http://argocd.devops-lab.local

------------------------------------------------------------------------

## Prerequisites

Before setting up the platform install:

-   Windows 11
-   WSL2
-   Ubuntu 24.04
-   Docker Desktop
-   kubectl
-   k3d
-   git

------------------------------------------------------------------------

## Step 1: Create Kubernetes Cluster

Create the cluster using k3d.

``` bash
k3d cluster create devops-lab -p "80:80@loadbalancer" -p "443:443@loadbalancer"
```

Verify cluster:

``` bash
kubectl get nodes
```

------------------------------------------------------------------------

## Step 2: Install ArgoCD

Create namespace:

``` bash
kubectl create namespace argocd
```

Install ArgoCD:

``` bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Verify installation:

``` bash
kubectl get pods -n argocd
```

------------------------------------------------------------------------

## Step 3: Configure ArgoCD Ingress

Create file:

    kubernetes/argocd/argocd-ingress.yaml

Example configuration:

``` yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: argocd
  namespace: argocd
spec:
  ingressClassName: traefik
  rules:
  - host: argocd.devops-lab.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: argocd-server
            port:
              number: 80
```

Apply configuration:

``` bash
kubectl apply -f kubernetes/argocd/argocd-ingress.yaml
```

------------------------------------------------------------------------

## Step 4: Configure Local DNS

Edit the Windows hosts file:

    C:\Windows\System32\drivers\etc\hosts

Add:

    127.0.0.1 argocd.devops-lab.local

------------------------------------------------------------------------

## Step 5: Access ArgoCD

Open browser:

    http://argocd.devops-lab.local

Get admin password:

``` bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

Login credentials:

    username: admin
    password: <generated-password>

------------------------------------------------------------------------

## Repository Structure

    devops-lab-platform
    │
    ├── README.md
    ├── docs
    │   ├── setup.md
    │   └── troubleshooting.md
    │
    ├── cluster
    │   └── create-cluster.sh
    │
    ├── kubernetes
    │   ├── argocd
    │   │   ├── install.yaml
    │   │   └── argocd-ingress.yaml
    │   │
    │   └── apps
    │       └── nginx-demo.yaml
    │
    └── scripts
        ├── install-tools.sh
        └── cleanup.sh

------------------------------------------------------------------------

## Future Improvements

Planned extensions for the platform:

-   GitLab CI/CD
-   Harbor Container Registry
-   Prometheus Monitoring
-   Grafana Dashboards
-   AI Application Deployment

------------------------------------------------------------------------

## Purpose of this Project

This repository serves as:

-   A **DevOps learning lab**
-   A **GitOps platform example**
-   A **Kubernetes practice environment**
-   A **portfolio project for DevOps engineering roles**

------------------------------------------------------------------------

## Author

DevOps Lab Platform --- personal infrastructure project for learning
DevOps, Kubernetes, and GitOps.
