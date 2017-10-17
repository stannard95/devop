#Devops Using a vagrant machine

When installing vagrant make sure it matches your operating system.

	 https://www.vagrantup.com/downloads.html

Before you begin working in the enviornment, lets download the git repository.
	
	git clone git@github.com:stannard95/devops.git

Once you have done, set up the virtual machine
	
	vagrant up

Your virtual machine has been set up, try loggining in.

	vagrant ssh

If you can't see anything, try ' cd / ' to see all the directories.


Before we can maky any changes to your virtual machine, lets update.

	sudo apt-get update -y


Try ' ls ' in your terminal and you should see a vagrant file. Lets open it up with ' subl . '


Now that we've made a change to our virtual machine, reload it in the terminal.

	vagrant reload


Reload the virtual machine and, load up your browser and type this in your search bar:

	development.local/

	
#Useful commands

	- 'vagrant destroy -f vagrant up' (Destroys the 	
	virtual machine and loads it back up)

	- 'sudo apt-get update -y' (Updates the virtual 
	machine with any new changes.
