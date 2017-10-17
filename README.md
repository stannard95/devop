#Devops Using a vagrant machine

When installing vagrant make sure it matches your operating system.

	 https://www.vagrantup.com/downloads.html

Before you begin working in the enviornment, lets download the git repository.
	
	git remote add origin git@github.com:stannard95/devops.git
	git push -u origin master

Once you have done, set up the virtual machine
	
	vagrant up

Your virtual machine has been set up, try loggining in.

	vagrant ssh

If you can't see anything, try ' cd / ' to see all the directories.


Before we can maky any changes to your virtual machine, lets update.

	sudo apt-get update -y


Try ' ls ' in your terminal and you should see a vagrant file. Lets open it up with ' subl . '

Inside this file, remove all the comments and don't delete the uncommented lines of code. Just below, type this.

	config.vm.network "private network", ip: "192.168.10.100"

Now that we've made a change to our virtual machine, reload it in the terminal.

	vagrant reload

After this, we will use 'please' to install plugins. This will allow us to change the host name.

	please create

Now head back into sublime and add a new line with which will change the name of the host.
	
	- config.hostsupdater.aliases = ["development.local"]

Reload the virtual machine and, load up your browser and type this in your search bar:

	development.local/

	
#Useful commands

	- 'vagrant destroy -f vagrant up' (Destroys the 	
	virtual machine and loads it back up)

	- 'sudo apt-get update -y' (Updates the virtual 
	machine with any new changes.
