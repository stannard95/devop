# Devops: Using a vagrant machine



# Downloading vagrant and virtual box
Skip this step if you have these installed already.

When installing vagrant and virtual box make sure it matches your operating system.

	 https://www.vagrantup.com/downloads.html
	 https://www.virtualbox.org/wiki/Downloads
	 
# Setting up your environment

Before you begin working in your environment, lets download the git repository using the terminal.
	
	git clone git@github.com:stannard95/devops.gi
	cd 'directory-name'
	


Once you have done this, set up the virtual machine.
	
	vagrant up

Your virtual machine has been set up, try to login.

	vagrant ssh

Now that you're in the machine lets go to the app directory and run the node via the terminal. This will connect you to the local port.

	cd app
	node app.js
	
Load up your browser and type this in your search bar:
	
	development.local:3000

	
## Git Testing

This is test to see whether George can push to the git repo.
