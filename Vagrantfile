# -*- mode: ruby -*-
# vi: set ft=ruby :

# Check and Install required plugins if missing
installed_plugins = false
required_plugins=%w( vagrant-vbguest vagrant-cachier vagrant-timezone vagrant-reload )
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

Vagrant.require_version ">= 1.9.1"

$windows = (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
$mac = (/darwin/ =~ RUBY_PLATFORM) != nil
$linux = (/linux/ =~ RUBY_PLATFORM) != nil

Vagrant.configure(2) do |config|

  config.vm.box = "cooperc/developer-environment"
  config.vm.box_version = "0.69"

  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = true
    config.vbguest.iso_path = "http://download.virtualbox.org/virtualbox/%{version}/VBoxGuestAdditions_%{version}.iso"
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  if Vagrant.has_plugin?("vagrant-timezone")
    config.timezone.value = "Europe/London"
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
    v.customize ["modifyvm", :id, "--memory", ENV['DEVENV_MEMORY'] || "2048"]
    v.customize ["modifyvm", :id, "--vram", "128"]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
    v.customize ["modifyvm", :id, "--accelerate3d", "on"]
    v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
  end
  config.vm.synced_folder ".", "/vagrant"
end
