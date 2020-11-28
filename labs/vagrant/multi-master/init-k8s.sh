#!/bin/bash

IP=$1
NODE=$2

if [ "$NODE" == "1" ] then
	kubeadm init --kubernetes-version 1.18.8 --apiserver-advertise-address $IP
	
	wget https://docs.projectcalico.org/v3.14/manifests/calico.yaml
	sed -i 's/3.14.[0-9]\+/3.14.2/g' calico.yaml
	kubectl --kubeconfig /etc/kubernetes/admin.conf create -f calico.yaml
fi

exit 0
