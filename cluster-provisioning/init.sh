#!/bin/bash 


function createBase() {
    echo "INFO: Starting the cluster creation process" 
    kind create cluster --config=config.yaml --name=k8s-cluster
 
    echo "INFO: Waiting nodes be ready to proceed"
    kubectl wait --for=condition=Ready nodes --all --timeout=5m
}


function installArgo() {
    echo "INFO: Installing ArgoCD"
    helm repo add argo https://argoproj.github.io/argo-helm
    helm install argocd argo/argo-cd --values=../argo/values.yaml --namespace=argocd --create-namespace=true

    echo "INFO: Waiting ArgoCD be ready to proceed"
    kubectl wait --for=condition=Ready pod --all -n argocd --timeout=5m
}


function main() {
    createBase
    installArgo
}

main
