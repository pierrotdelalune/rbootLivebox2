rbootLivebox2
=============

Celerity scenario to reboot remotely a Sagem Livebox 2 by Orange.

Prerequities
------------

Jruby is required as this tool relies on Celerity gem.

List of required gems:

* celerity
* highline

Usage
-----

  rbootLivebox2 [OPTION] ... URL
 
  -h, --help:
     show help
 
  --dryrun:
     go through each step of the scenario but does not reboot the Livebox 2
 
  URL: The URL of the Livebox 2
