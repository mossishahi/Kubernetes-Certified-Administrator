# metric-server
Documentation and manifest can be found in Github  
```
https://github.com/kubernetes-sigs/metrics-server
```

# kube-state-metrics 
Documentation can be found in Github
```
https://github.com/kubernetes/kube-state-metrics
```

### Configure kube-state-metrics with command line arguments
Configure with `args` option in Kubernetes manifests:
```
spec:
  template:
    spec:
      containers:
        - image: quay.io/coreos/kube-state-metrics:v1.9.7
          args:
          - '--telemetry-port=8081'
          - '--metric-blacklist=kube_configmap_.*'
```

