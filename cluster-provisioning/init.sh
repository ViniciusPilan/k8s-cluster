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

    echo "step 04: access ArgoCD"
    echo " - login: admin"
    echo " - password: $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)"
    echo " Execute 'kubectl port-forward service/argocd-server 8080:80 -n argocd' in terminal to create port mapping to access argocd web ui"
}


function installKyverno() {
    echo "INFO: Installing Kyverno"

    echo "step 01: add repository to help repo list"
    helm repo add kyverno https://kyverno.github.io/kyverno/
    helm repo update

    echo "step 02: install Helm release and wait all be ready to proceed"
    helm install kyverno kyverno/kyverno -n kyverno --create-namespace=true --wait --values=../tools/kyverno/values.yaml

    echo "step 03: apply policies"
    kubectl apply -f ../tools/kyverno/policies
}

function main() {
    createBase
    installKyverno
    installArgo
}

main
