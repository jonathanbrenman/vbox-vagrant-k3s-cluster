create:
	vagrant up
	cd ansible; ansible-playbook ./playbooks/cluster.yml -i inventory/hosts.ini

destroy:
	vagrant destroy -f