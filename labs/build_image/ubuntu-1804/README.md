# Build Image with Packer

## Install packer
Download packer file and copy to bin folder  
```
wget https://releases.hashicorp.com/packer/1.6.0/packer_1.6.0_linux_amd64.zip
unzip packer_1.6.0_linux_amd64.zip
mv packer /usr/local/bin/
```

## Build ova image for virtulabox
Just run  
```
packer build template.json
```
