#!/bin/bash 

# This script will create the cluster with the project patterns and base tools:
# - All Kubernetes components to run applications
# - Kubernetes Gateway API Custom Resource Definitions (to allow setting of ingress traffic management with GatewayAPI)
# - Argocd (to deploy applications)
# - Kyverno (to ensure project patterns)


# Requirements:
# - Docker installed and daemon running
# - Kind
# - kubectl
# - Helm


# How to run:
# $ cd cluster-provisioning
# $ bash init.sh

function checkInstalledBinary() {
    local cmd=$1

    echo "Binary $cmd is installed?"

    if ! command -v $cmd &> /dev/null; then
        echo "ERROR: $cmd is not installed."
        exit 1
    fi

    echo "OK: $cmd is installed and running."
}


function checkDockerIsRunning() {
    echo "Docker is running?"

    if ! docker info &> /dev/null; then
        echo "ERROR: Docker is installed but is not running."
        exit 1
    fi
}


function checkRequirements() {
    echo "INFO: Checking the requirements"

    checkInstalledBinary "docker"
    checkInstalledBinary "kind"
    checkInstalledBinary "kubectl"
    checkInstalledBinary "helm"

    checkDockerIsRunning

    echo "INFO: All requirements are satisfied."
}


function createClusterBase() {
    echo "INFO: Starting the cluster creation process" 
    kind create cluster --config=config.yaml --name=k8s-cluster
 
    echo "INFO: Waiting nodes be ready to proceed"
    kubectl wait --for=condition=Ready nodes --all --timeout=5m
}


function installArgo() {
    echo "INFO: Installing ArgoCD"

    echo "Step 01: add repository to help repo list"
    helm repo add argo https://argoproj.github.io/argo-helm

    echo "Step 02: install Helm release and wait all be ready to proceed"
    helm install argocd argo/argo-cd --values=../tools/argo/values.yaml --namespace=argocd --create-namespace=true --wait --version 10.9.2

    echo "Step 03: create argo applications to manage all repository applications"
    kubectl apply -f ../tools/argo/argo-applications.yaml

    echo "Step 04: access ArgoCD"
    echo " - login: admin"
    echo " - password: $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)"
    echo " Execute 'kubectl port-forward service/argocd-server 8080:80 -n argocd' in terminal to create port mapping to access argocd web ui"
}


function installKyverno() {
    echo "INFO: Installing Kyverno"

    echo "Step 01: add repository to help repo list"
    helm repo add kyverno https://kyverno.github.io/kyverno/
    helm repo update

    echo "Step 02: install Helm release and wait all be ready to proceed"
    helm install kyverno kyverno/kyverno -n kyverno --create-namespace=true --wait --values=../tools/kyverno/values.yaml --version 3.9.1

    echo "Step 03: apply policies"
    kubectl apply -f ../tools/kyverno/policies
}


function installGatewayCRDs() {
    echo "INFO: Installing Gateway API CRDs"
    kubectl apply --server-side -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.6.1/standard-install.yaml
}


function installCertManager() {
    echo "INFO: Installing CertManager"
    
    echo "Step 01: add repository to help repo list"
    helm repo add jetstack https://charts.jetstack.io
    
    echo "Step 02: install Helm release and wait all be ready to proceed"
    helm install cert-manager jetstack/cert-manager --version v1.21.2 --wait --create-namespace=true -n cert-manager --values=../tools/certmanager/values.yaml
}


function createIntermediateCASecret() {
    kubectl create secret tls ca-ingress-tls-secret --cert=../ca-files/intermediate-ca/certs/intermediate-ca.cert.pem --key=../ca-files/intermediate-ca/private/intermediate-ca.key.pem -n cert-manager
}


function main() {
    checkRequirements
    createClusterBase
    installKyverno
    installGatewayCRDs
    installCertManager
    createIntermediateCASecret
    installArgo
}

main
