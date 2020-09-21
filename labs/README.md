# Certified Kubernetes Administrator (CKA)

## Install and Preparation

### Install Packer
Download packer file and copy to bin folder
```
wget https://releases.hashicorp.com/packer/1.6.0/packer_1.6.0_linux_amd64.zip
unzip packer_1.6.0_linux_amd64.zip
mv packer /usr/local/bin/
```

### Install Vagrant
1. Browse [vagrant download page](https://www.vagrantup.com/downloads)
2. Download vagrant for linux
3. Unzip downloaded file
```
unzip vagrant_2.2.10_linux_amd64.zip
```
4. Move excutable file to /usr/local/bin
```
mv vagrant /usr/local/bin
```
5. Examine correct installation
```
$ vagrant --version
Vagrant 2.2.10
```

## Build Base Images

