## Create ceph-csi namespace
```
kubectl create ns ceph-csi
```

## Update csi-config-map.yaml
```
[
    {
    "clusterID": "<cluster-id>",
    "monitors": [
        "<MONValue1>",
        "<MONValue2>",
        ...
        "<MONValueN>"
    ]
    }
]
```

## Deploy ceph-csi provisioner
```
kubectl apply -f csi-config-map.yaml
kubectl apply -f csi-encryption-kms-config-map.yaml
kubectl apply -f csi-provisioner-service-account.yaml
kubectl apply -f csi-nodeplugin-service-account.yaml
kubectl apply -f csi-nodeplugin-cluster-role.yaml
kubectl apply -f csi-nodeplugin-cluster-role-binding.yaml
kubectl apply -f csi-provisioner-cluster-role.yaml
kubectl apply -f csi-provisioner-cluster-role-binding.yaml
kubectl apply -f csi-provisioner-role.yaml
kubectl apply -f csi-provisioner-role-binding.yaml
kubectl apply -f csi-rbdplugin-deployment.yaml
kubectl apply -f csi-rbdplugin-provisioner-deployment.yaml
kubectl apply -f csi-rbdplugin-provisioner-service.yaml
kubectl apply -f csi-rbdplugin-service.yaml
```

## Create secret for provisioning
Dont forget if you keyring file like this
```
[client.admin]
	key = AQDNIT5fjrwVIhAAqcZURwQRhK3B5fUopYX5Qw==
```

your userID is `admin`


```
apiVersion: v1
kind: Secret
metadata:
  name: csi-rbd-secret-test
  namespace: ceph-csi
stringData:
  userID: admin
  userKey: AQDNIT5fjrwVIhAAqcZURwQRhK3B5fUopYX5Qw==
```

## Apply storageclass
```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: test
provisioner: rbd.csi.ceph.com
parameters:
  clusterID: a3f09810-e2b2-11ea-b7d2-080027589fef
  pool: cka
  imageFeatures: "layering"
  csi.storage.k8s.io/provisioner-secret-name: csi-rbd-secret-test
  csi.storage.k8s.io/provisioner-secret-namespace: ceph-csi
  csi.storage.k8s.io/node-stage-secret-name: csi-rbd-secret-test
  csi.storage.k8s.io/node-stage-secret-namespace: ceph-csi
  csi.storage.k8s.io/controller-expand-secret-name: csi-rbd-secret-test
  csi.storage.k8s.io/controller-expand-secret-namespace: ceph-csi
  fsType: ext4
reclaimPolicy: Delete
allowVolumeExpansion: true
mountOptions:
- discard
```
