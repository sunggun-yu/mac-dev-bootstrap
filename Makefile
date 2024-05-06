# set the comma separated inventory.
# goal must be comma separated for multiple goal
# if goals is empty, it runs only default goal (host)
ifeq ($(goals),)
	INVENTORY:=--limit default
else
	INVENTORY:=--limit $(goals)
endif

# set tag. tag value must be comma separated
ifneq ($(tags),)
	TAGS:=-t $(tags)
endif

.PHONY: install
install: ansible-install requirements
	@$(ACTIVATE_VENV) && $(ANSIBLE_PLAYBOOK) $(INVENTORY) main.yml --ask-become-pass $(TAGS)

.PHONY: requirements
requirements: ansible-install
	@$(ACTIVATE_VENV) && $(ANSIBLE_GALAXY) install -r requirements.yml

##@ Build Dependencies ------------------------------------------------------------

# Python VENV root
VENV ?= $(shell pwd)/.venv
$(VENV):
	mkdir -p $(VENV)

# command for Activating the VENV in the Makefile
ACTIVATE_VENV = . $(VENV)/bin/activate 

# Tool Versions
ANSIBLE_VERSION ?= 9.5.1

## Tool Binaries
ANSIBLE_PLAYBOOK ?= ansible-playbook
ANSIBLE_GALAXY ?= ansible-galaxy

# Ensure Python VENV is created and can be activated
.PHONY: python-venv
python-venv: $(VENV)
	@python3 -m venv --python=python3.12 $(VENV)
	@$(ACTIVATE_VENV) && which python3

# Ensure Ansible is installed
# Installation is done using Python VENV in the project directory `.venv` in order to ensure that Ansible is running any user environment
.PHONY: ansible-install
ansible-install: python-venv
	@$(ACTIVATE_VENV) && python3 -m pip install ansible==$(ANSIBLE_VERSION)
