# Deploy Kubernetes (MUI Pro)

Este diretorio inclui duas opcoes para homologacao/RC:

- `k8s/`: manifests base
- `helm/mui-pro-app/`: chart Helm

## Manifests

```bash
kubectl apply -f deploy/k8s/deployment.yaml
kubectl apply -f deploy/k8s/service.yaml
kubectl apply -f deploy/k8s/ingress.yaml
```

## Helm

```bash
helm upgrade --install mui-pro-app deploy/helm/mui-pro-app
```

Antes do deploy, ajuste imagem, host e recursos em `values.yaml`.
