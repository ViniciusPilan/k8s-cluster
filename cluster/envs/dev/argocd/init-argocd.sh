kubectl apply -f argocd-ns.yaml
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/master/manifests/install.yaml

sleep 10

kubectl get secrets -n argocd argocd-initial-admin-secret -o yaml | grep password | awk '{print $2}' | base64 --decode
kubectl port-forward -n argocd service/argocd-server 8080:80
