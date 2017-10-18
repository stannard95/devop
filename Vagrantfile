# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

	required_plugins = %w(vagrant-hostsupdater)
	required_plugins.each do |plugin|
	    exec "vagrant plugin install #{plugin};vagrant #{ARGV.join(" ")}" unless Vagrant.has_plugin? plugin || ARGV[0] == 'plugin'
	end

  config.vm.box = "ubuntu/xenial64"
  config.vm.network "private_network", ip: "192.168.10.100"
  config.hostsupdater.aliases = ["development.local"]

  # directory of host to directory of guest
  config.vm.synced_folder "app", "/home/ubuntu/app" 

  # run the app provision script
  config.vm.provision "shell", path: "environment/app/provision.sh"

end
