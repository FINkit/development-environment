Vagrant.require_version ">= 1.7.2"

Vagrant.configure(2) do |config|

  config.vm.box = "cooperc/developer-environment"

  config.vm.provision :shell, path: "bootstrap.sh"

  config.vm.provider "virtualbox" do |v|
    v.gui = true
    v.name = "developer-environment"
    v.customize ["modifyvm", :id, "--cpus", "1"]
    v.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
    v.customize ["modifyvm", :id, "--monitorcount", "1"]
    v.customize ["modifyvm", :id, "--memory", "2048"]
    v.customize ["modifyvm", :id, "--vram", "128"]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
    v.customize ["modifyvm", :id, "--accelerate3d", "on"]
  end

  config.vm.synced_folder ".", "/vagrant", disabled: true

end
