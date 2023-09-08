#!/usr/bin/env bash

set -eux

function cleanup() {
    ansible-playbook teardown.yaml "$@"
    exit 1
}

trap 'cleanup "${@}"' ERR

# Create resources for testing
ansible-playbook setup.yaml "$@"

# Upload to Cloud Storage
ansible-playbook upload_file.yaml -e "@upload_file_vars.yaml" -i ./inventory/upload_file.ini "$@"

# Validate that file has been successfully uploaded as expected
ansible-playbook validate.yaml -e "@upload_file_vars.yaml" "$@"

# Delete resources
ansible-playbook teardown.yaml "$@"
