#!/bin/bash 


function createBase() {
    echo "INFO: Starting the cluster creation process" 
    kind create cluster --config=config.yaml --name=k8s-cluster
 
    echo "INFO: Waiting nodes be ready to proceed"
    kubectl wait --for=condition=Ready nodes --all --timeout=5m
}


function installArgo() {
    echo "INFO: Installing ArgoCD"

    echo "step 01: add repository to help repo list"
    helm repo add argo https://argoproj.github.io/argo-helm

    echo "step 02: install Helm release and wait all be ready to proceed"
    helm install argocd argo/argo-cd --values=../tools/argo/values.yaml --namespace=argocd --create-namespace=true --wait

    echo "step 03: create argo applications to manage all repository applications"
    kubectl apply -f ../tools/argo/argo-applications.yaml
}


function main() {
    createBase
    installArgo
}

main
