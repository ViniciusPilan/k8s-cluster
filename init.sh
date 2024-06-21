#!/bin/bash 

echo "<----------- Creating cluster ----------->" 
kind create cluster
sleep 10

echo "<----------- Installing Argo ----------->" 
kubectl apply -f argo/install -n argocd
sleep 20

echo "<----------- Installing Argo Applications ----------->"
kubectl apply -f argo/applications -n argocd
sleep 5
kubectl get secrets -n argocd argocd-initial-admin-secret -o yaml | grep password | cut -d " " -f 4 | base64 --decode > /home/vinipilan/documents/k8s-cluster/argocd-password.txt


echo "<-------------------- OUTPUTS -------------------->"
echo "The cluster was created!"
echo ""
echo "kubectl port-forward service/argocd-server 8080:80 -n argocd"
echo "Password: "
cat /home/vinipilan/documents/k8s-cluster/argocd-password.txt
echo ""
echo "kubectl port-forward service/grafana 8081:80 -n sentinel"
