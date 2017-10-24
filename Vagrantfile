# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

	required_plugins = %w(vagrant-hostsupdater)
	required_plugins.each do |plugin|
	    exec "vagrant plugin install #{plugin};vagrant #{ARGV.join(" ")}" unless Vagrant.has_plugin? plugin || ARGV[0] == 'plugin'
	end

  config.vm.box = "ubuntu/xenial64"
  config.vm.provision "shell", inline: "echo 'export DB_HOST=mongodb://192.168.10.101/blog' >> /home/ubuntu/.bashrc"

  config.vm.define "app" do |app|

    app.vm.network "private_network", ip: "192.168.10.100"
    app.hostsupdater.aliases = ["development.local"]

    # directory of host to directory of guest
    app.vm.synced_folder "app", "/home/ubuntu/app"
    app.vm.synced_folder "environment", "/home/ubuntu/environment"
    # run the app provision script
    app.vm.provision "shell", path: "environment/app/provision.sh"


  end

  config.vm.define "db" do |db|

    db.vm.network "private_network", ip: "192.168.10.101"
    db.hostsupdater.aliases = ["development.local"]

    # directory of host to directory of guest
    db.vm.synced_folder "environment/db", "/home/ubuntu/environment"
    # run the app provision script
    db.vm.provision "shell", path: "environment/db/provision.sh"

  end

end
