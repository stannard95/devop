#Devops Using a vagrant machine

When installing vagrant and virtual box make sure it matches your operating system.

	 https://www.vagrantup.com/downloads.html
	 https://www.virtualbox.org/wiki/Downloads

Before you begin working in the enviornment, lets download the git repository.
	
	git clone git@github.com:stannard95/devops.git
	
Then type ' cd ' followed by the directory name.

Once you have done, set up the virtual machine
	
	vagrant up

Your virtual machine has been set up, try loggining in.

	vagrant ssh


Load up your browser and type this in your search bar:
	
	development.local/

	
#Useful commands

	- 'vagrant destroy -f vagrant up' (Destroys the 	
	virtual machine and loads it back up)

	- 'sudo apt-get update -y' (Updates the virtual 
	machine with any new changes.
