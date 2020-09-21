# Install Vagrant
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

# Convert OVA file to Vagrant box
List your VMs to find the VM id you want to convert  
```
$ VBoxManage list vms
"testing" {a3f59eed-b9c5-4a5f-9977-187f8eb8c4d4}
```

You can now package the .ova VM as Vagrant box  
```
$ vagrant package --base a3f59eed-b9c5-4a5f-9977-187f8eb8c4d4 --output name-of-your-box.box
```

Add the new box to the list of local Vagrant boxes  
```
$ vagrant box add new-box-name name-of-your-box.box
```

# Vagrant Network
Config.vm.network - Configures networks on the machine.  
```
Vagrant.configure("2") do |config|
	config.vm.network "public_network"
end
```

# Vagrant volume

```
config.vm.disk :disk, name: "backup", size: "10GB"	 
```
