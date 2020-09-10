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

# node-exporter
Install node-exporter as a systemd service  
```
apt-get install prometheus-node-exporter
```

Install node-exporter as a daemonsets
```
kubectl -n monitoring apply -f  manifests/node-exporter-daemonset.yaml
```

# Enable prometheus metrics for coredns
Configmap  
```
$ kubectl -n kube-system get configmap coredns -o yaml
...
  Corefile: |
    .:53 {
        errors
        health {
           lameduck 5s
        }
        ready
        kubernetes cluster.local in-addr.arpa ip6.arpa {
           pods insecure
           fallthrough in-addr.arpa ip6.arpa
           ttl 30
        }
        prometheus :9153
...
```

Service
```
$ kubectl -n kube-system get service kube-dns -o yaml
...
  - name: metrics
    port: 9153
    protocol: TCP
    targetPort: 9153
...
```


