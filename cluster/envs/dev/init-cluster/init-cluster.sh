kind create cluster --config=cluster-config.yaml
kind load docker-image echo-api:dev
kind load docker-image over-requests:dev
