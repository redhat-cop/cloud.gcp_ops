#!/usr/bin/env bash

set -eux

function cleanup() {
    rm -f set_env.sh vars.yml access_token.yml
    exit 1
}

trap 'cleanup "${@}"'  ERR

# Create variable files
ansible-playbook setup.yml -e 'resource_prefix=test' "$@"

# display variable file
cat vars.yml
cat set_env.sh
cat access_token.yml

# Test role with Ansible variables
ansible-playbook play.yml -e "@vars.yml" "$@"

# Test role with Ansible environment
source ./set_env.sh
ansible-playbook play.yml -e "@access_token.yml" "$@"