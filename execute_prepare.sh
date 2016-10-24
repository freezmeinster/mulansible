#!/usr/bin/env bash

ANSIBLE_LIBRARY="$(pwd)/library"
HOST=muladev
HOST_INVENTORY=devhost.conf
ansible -m raw -a "echo 'nameserver 8.8.8.8' > /etc/resolv.conf" -i $HOST_INVENTORY $HOST
ansible -m raw -a "mkdir -p /usr/local/etc/pkg/repos" -i $HOST_INVENTORY $HOST
ansible -m raw -a "echo 'FreeBSD: { enabled: no }' > /usr/local/etc/pkg/repos/FreeBSD.conf" -i $HOST_INVENTORY $HOST
ansible -m raw -a "echo 'Oleafs: { enabled: yes, url: http://pkg.o-leafs.com/FreeBSD:11:amd64/quarterly}' > /usr/local/etc/pkg/repos/Oleafs.conf" -i $HOST_INVENTORY $HOST
ansible -m raw -a "env ASSUME_ALWAYS_YES=yes pkg bootstrap" -i $HOST_INVENTORY $HOST
ansible -m raw -a "pkg install -y python27" -i $HOST_INVENTORY $HOST
ansible -m raw -a "ln -s /usr/local/bin/python2.7 /usr/bin/python" -i $HOST_INVENTORY $HOST
ansible-playbook -i $HOST_INVENTORY prepare.yml
