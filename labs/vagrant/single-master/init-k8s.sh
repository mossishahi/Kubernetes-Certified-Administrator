#!/bin/bash

kubeadm init --kubernetes-version 1.18.6 --apiserver-advertise-address $1

wget https://docs.projectcalico.org/v3.14/manifests/calico.yaml
sed -i 's/3.14.[0-9]\+/3.14.1/g' calico.yaml
kubectl --kubeconfig /etc/kubernetes/admin.conf create -f calico.yaml

exit 0
