#Devops Using a vagrant machine

When installing vagrant and virtual box make sure it matches your operating system.

	 https://www.vagrantup.com/downloads.html
	 https://www.virtualbox.org/wiki/Downloads

Before you begin working in the enviornment, lets download the git repository.
	
	git clone git@github.com:stannard95/devops.git

Once you have done, set up the virtual machine
	
	vagrant up

Your virtual machine has been set up, try loggining in.

	vagrant ssh

If you can't see anything, try ' cd / ' to see all the directories.


Reload the virtual machine and, load up your browser and type this in your search bar:

	- vagrant reload
	
	development.local/

	
#Useful commands

	- 'vagrant destroy -f vagrant up' (Destroys the 	
	virtual machine and loads it back up)

	- 'sudo apt-get update -y' (Updates the virtual 
	machine with any new changes.
