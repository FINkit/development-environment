# -*- mode: ruby -*-
# vi: set ft=ruby :

# Check and Install required plugins if missing
installed_plugins = false
required_plugins=%w( vagrant-vbguest vagrant-reload vagrant-cachier vagrant-env vagrant-triggers )
required_plugins.each do |plugin|
  if !Vagrant.has_plugin?plugin
    system "vagrant plugin install #{plugin}"
    installed_plugins = true
  end
end

if installed_plugins
  puts "Please re-run 'vagrant up' command"
  exit
end

Vagrant.require_version ">= 1.9.5"

Vagrant.configure(2) do |config|
  config.trigger.before :up do
    print "**********************************************************************\n"
    print "* FINkit Development Environment                                     *\n"
    print "*                                                                    *\n"
    print "* WARNING!!! Do not login to development environment before          *\n"
    print "* provisioning completes!!                                           *\n"
    print "*                                                                    *\n"
    print "* Premature access can cause adverse side effects and instability.   *\n"
    print "* A message will display when it is safe to login.                   *\n"
    print "**********************************************************************\n"
  end

  config.trigger.after :up do
    print "**********************************************************************\n"
    print "* FINkit Development Environment                                     *\n"
    print "*                                                                    *\n"
    print "* You can now login to the development environment                   *\n"
    print "* The username and password are both 'vagrant'                       *\n"
    print "**********************************************************************\n"
  end

  # Latest version available at https://app.vagrantup.com/finkit/boxes/development-environment-base
  config.vm.box_url="https://app.vagrantup.com/finkit/boxes/development-environment-base"
  config.vm.box = "finkit/development-environment-base"
  config.vm.box_version = "2.0.1540996636"


  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = true
    config.vbguest.iso_path = "http://download.virtualbox.org/virtualbox/%{version}/VBoxGuestAdditions_%{version}.iso"
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    # The vagrant-cachier plugin (optional) will speed up rebuilds by reusing downloaded artifacts
    # Configure cached packages to be shared between instances of the same base box.
    config.cache.scope = :box
  end

  config.vm.provision :shell, path: "scripts/wait_for_updates.sh"

  # Run Ansible from the Vagrant VM
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "ansible/main.yml"
  end

  config.vm.provision :reload

  config.vm.provider "virtualbox" do |v|
    v.gui = true
    v.name = "development-environment"
    v.customize ["modifyvm", :id, "--cpus", ENV['DEVENV_PROCESSORS'] || "2"]
    v.customize ["modifyvm", :id, "--cpuexecutioncap", ENV['DEVENV_CPUEXECUTIONCAP'] || "100"]
    v.customize ["modifyvm", :id, "--monitorcount", "1"]
    v.customize ["modifyvm", :id, "--memory", ENV['DEVENV_MEMORY'] || "4096"]
    v.customize ["modifyvm", :id, "--vram", "128"]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
    v.customize ["modifyvm", :id, "--accelerate3d", "on"]
    v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    v.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/ --timesync-set-threshold", 10000]
  end
  config.vm.synced_folder ".", "/vagrant"
end

