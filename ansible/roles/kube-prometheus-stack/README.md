```

# helm --kubeconfig /arvan/personal/server/k8s/kube-config -n monitoring install kwc-monitoring prometheus-community/kube-prometheus-stack --version 51.10.0 --create-namespace --dry-run

# helm --kubeconfig /arvan/personal/server/k8s/kube-config -n monitoring install kwc-monitoring prometheus-community/kube-prometheus-stack --version 51.10.0 --create-namespace -f ./kps-values.yaml
```