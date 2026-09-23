## Steps

[] base
- Cluster running
    - nodes running
    - workloads ready to be created
    - scripts done
    - Security Patterns
    - Kyverno
    - ArgoCD
    - Istio (base, cni, istiod, ingress)
    - Ingress

[] apps core
- Core apps working and allowing the cluster be "useful"
    - Prometheus (or alloy)
    - Grafana
    - Loki
    - Falco


[] LLM



Argocd -> Istio -> Kyverno -> PSA -> Ingress -> Istio gateway -> Prometheus -> Grafana -> Loki
