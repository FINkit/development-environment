# -*- mode: ruby -*-
# vi: set ft=ruby :

puts "Checking versions..."
vagrant_version = %x( vagrant --version )

vbox_version = %x( virtualbox --help | head -n 1 | awk '{print $NF}' )
if $?.exitstatus > 0
  puts "\nCould not find virtualbox command, please ensure it is present in your global PATH environment variable\n"
  exit
end

puts "#{vagrant_version}"
puts "VirtualBox #{vbox_version}"

Vagrant.require_version ">= 1.9.5"
vbox_minimum_version = '5.1.22'

$windows = (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
$mac = (/darwin/ =~ RUBY_PLATFORM) != nil
$linux = (/linux/ =~ RUBY_PLATFORM) != nil

if ARGV[0] == 'up'
  if vbox_version < vbox_minimum_version
    puts "Please install virtual box v#{vbox_minimum_version} or later"
    exit
  end

  puts "Checking host system requirements..."
  memory = ""
  if $windows
    $cmd = (/MSYS_NT/ =~ %x( uname )) != nil
    if $cmd
      memory = %x( wmic os get TotalVisibleMemorySize | find /V "TotalVisibleMemorySize" ) + "000"
    else
      memory = %x( wmic os get TotalVisibleMemorySize | awk /^.*[0-9]+.*$/'{print $1"000"}' )
    end
  elsif $mac
    memory = %x( sysctl -a | grep memsize | awk '{print $2}' )
  elsif $linux
    memory = %x( free -m | egrep -v "total|Swap"| awk '{printf "%d000000\n",$2}' )
  end

  if memory.to_i < "8000000000".to_i
    current_mem = memory.to_i/1000000
    puts "You need at least 8192MB of memory on your host machine to run this development environment, you only have #{current_mem} MB!"
    exit
  end
end

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

def envFileContainsString(searchString)
  return File.file?(".env") && File.foreach(".env").grep(/#{searchString}/).any?
end

def isNullOrEmpty(value)
    return value.nil? || value.empty?
end

def writeConfigToFile(file, name, value, defaultValue)
  if !envFileContainsString(name)
    if isNullOrEmpty(value)
      file.puts "#{name}=#{defaultValue}"
    else
      file.puts "#{name}=#{value}"
    end
  end
end

def limitMaxValue(value, maxValue)
  valueInt = value.to_i
  if valueInt > maxValue
    value = maxValue.to_s
  end
end

if ARGV[0] == 'up'
  DEFAULT_DEVENV_MEMORY="4096"
  DEFAULT_DEVENV_MONITORCOUNT="1"
  DEFAULT_DEVENV_PROCESSORS="4"

  ### Prompt user for config ###
  if !envFileContainsString("DEVENV_MEMORY")
    print "How much memory (Mb) do you want to allocate to your development environment\n"
    print "Press Enter for default value: #{DEFAULT_DEVENV_MEMORY}\n"
    devenv_memory = STDIN.gets.chomp
  end

  if !envFileContainsString("DEVENV_MONITORCOUNT")
    print "How many monitors do you want to support in development environment\n"
    print "Press Enter for default value: #{DEFAULT_DEVENV_MONITORCOUNT}\n"
    devenv_monitor_count = limitMaxValue(STDIN.gets.chomp, 2)
  end

  if !envFileContainsString("DEVENV_PROCESSORS")
    print "How many CPU's do you want to support in your development environment\n"
    print "Press Enter for default value: #{DEFAULT_DEVENV_PROCESSORS}\n"
    devenv_processors = limitMaxValue(STDIN.gets.chomp, 4)
  end

  ### Write config (if any entered) to .env file ###
  File.open('.env','a+') do |s|
    writeConfigToFile(s, "DEVENV_MEMORY", devenv_memory, DEFAULT_DEVENV_MEMORY)
    writeConfigToFile(s, "DEVENV_MONITORCOUNT", devenv_monitor_count, DEFAULT_DEVENV_MONITORCOUNT)
    writeConfigToFile(s, "DEVENV_PROCESSORS", devenv_processors, DEFAULT_DEVENV_PROCESSORS)
  end
end

Vagrant.configure(2) do |config|
  config.trigger.before :up do
    print "**********************************************************************\n"
    print "* WARNING!!! Do not login to dev env before provisioning completes!! *\n"
    print "*                                                                    *\n"
    print "* Premature access can cause adverse side effects and instability.   *\n"
    print "* A message will display when it is safe to login.                   *\n"
    print "**********************************************************************\n"
  end

  config.trigger.after :up do
    print "***************************************************\n"
    print "* You can now login to the dev env. Happy coding! *\n"
    print "***************************************************\n"
  end

  config.env.enable

  # Latest version available at https://app.vagrantup.com/finkit/boxes/development-environment-base
  config.vm.box = "finkit/development-environment-base"
  config.vm.box_version = "1.0.1508231602"

  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = true
    config.vbguest.iso_path = "http://download.virtualbox.org/virtualbox/%{version}/VBoxGuestAdditions_%{version}.iso"
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    # The vagrant-cachier plugin (optional) will speed up rebuilds by reusing
    # downloaded artifacts; to benefit you need to install the plugin on your
    # host macine by running: vagrant plugin install vagrant-cachier
    # For more details see: https://github.com/fgrehm/vagrant-cachier
    # Configure cached packages to be shared between instances of the same base box.
    config.cache.scope = :box
  end

  # bash history folder needs creating before it is set in the provisioning script below
  if $windows
    config.vm.synced_folder "c:/bash_history", "/bash_history", create: true
  end

  if $mac or $linux
    config.vm.synced_folder "~/dev_bash_history", "/bash_history", create: true
  end

  config.vm.provision :shell, path: "scripts/wait_for_updates.sh"

  # Run Ansible from the Vagrant VM
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "ansible/main.yml"
  end

  config.vm.provision :shell, path: "scripts/configure_bash_history.sh"
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
    v.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/ — timesync-set-threshold", 10000]
  end
  config.vm.synced_folder ".", "/vagrant"
end

