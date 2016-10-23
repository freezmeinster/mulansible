#!/usr/bin/env bash

ANSIBLE_LIBRARY="$(pwd)/library"
ansible-playbook -i devhost.conf prepare.yml