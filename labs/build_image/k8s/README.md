# Build Image with Packer

## Preparation
Before build this image, you must build ubuntu-1804 image as a base image.  
Follow [Ubuntu-1804 README](../ubuntu-1804/README.md)

## Build ova image for virtulabox
Just run  
```
packer build template.json
```

## Build Steps
This build include two main steps. 
1. Install required packages
2. Pull docker images.


### Install Required Packeges
The `install-docker-k8s.sh` script include a few part.  
a. Disable transalte  
b. Add proxy for apt (If you not in Iran, dont need proxy)  
c. Add Kubernetes and Docker repositories  
d. Install docker-ce and Kubernets components (kubelet, kubeadm, kubectl) and hold these packages to prevent upgrade.  
e. Change Docker configuation based on [Kubernetes document](https://kubernetes.io/docs/setup/production-environment/container-runtimes/).  
f. Add proxy for docker service and restart servcie (If you not in Iran, comment this part  
g. Disable swap  
h. Remove docker proxy and install `shecan` (This if for Iranina users too, comment `# Add shecan` part if youre not from Iran.


### Pulling Images
The `pull-images.sh` script pull required docker images, need for deploy kubernetes control-plane.
