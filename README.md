### mdba-hub   [![Build Status](https://travis-ci.org/AtlasOfLivingAustralia/mdba-hub.svg?branch=master)](https://travis-ci.org/AtlasOfLivingAustralia/mdba-hub/)

# Murray-Darling Basin Authority (MDBA) Data Portal

Current version: 1.0-SNAPSHOT

Deploying a new version of mdba-hub to Nexus
===========================================

Before deploying a new version, check that the biocache-hubs dependency version is up to date in grails-app/conf/BuildConfig.groovy.

Travis-CI is used to deploy new versions of mdba-hub to Nexus. This is done automatically by updating the version number in the application.properties file and pushing to GitHub.

Once the new version of mdba-hub is deployed to Nexus, the version number in ansible-inventories needs to change. To do this, the version number must be changed in: 

https://github.com/AtlasOfLivingAustralia/ansible-inventories/blob/master/mdba.ala.org.au

If the biocache_hub_version is commented out then presumably it will use the most recent version it can find.

Deploying the current Nexus deployed version of mdba-hub to a virtual machine
========================================================================

If you have not yet installed Ansible, Vagrant, or VirtualBox, use the instructions at the [ALA Install README.md file](https://github.com/AtlasOfLivingAustralia/ala-install/blob/master/README.md) to install those first for your operating system.

Then, to deploy mdba-hub onto a local virtual box install use the following instructions:

```
$ cd gitrepos
$ git clone git@github.com:AtlasOfLivingAustralia/ala-install.git
$ (cd ala-install/vagrant/ubuntu-trusty && vagrant up)
```

Add a line to your /etc/hosts file with the following information, replacing '10.1.1.3' with whatever IP address is assigned to the virtual machine that Vagrant starts up in VirtualBox:

```
10.1.1.3 mdba.ala.org.au
```

Then you can clone the ansible instructions and install it onto the given machine:

```
$ git clone git@github.com:AtlasOfLivingAustralia/ansible-inventories.git
$ ansible-playbook -i ansible-inventories/mdba.ala.org.au ala-install/ansible/mdba-hub-standalone.yml --private-key ~/.vagrant.d/insecure_private_key -vvvv --user vagrant --sudo
```
