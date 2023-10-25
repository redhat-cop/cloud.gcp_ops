# cloud.gcp_ops.move_vm_from_on_prem_to_gcp

A playbook to migrate an existing on prem VM running on KVM hypervisor to GCP.

## Requirements

This playbook uses the ``cloud.gcp_ops.clone_on_prem_vm`` role to clone an existing VM on prem using the KVM hypervisor and the ``cloud.gcp_ops.import_image_and_run_gcp_instance`` role to import a local .raw image into a GCP custom machine image and run a GCP instance. For a complete list of requirements, see [clone_on_prem_vm](../clone_on_prem_vm/README.md#Requirements) and [import_image_and_run_gcp_instance](../roles/import_image_and_run_gcp_instance/REAME.md#Requirements), respectively.

## Playbook Variables

For a full list of accepted variables see: [clone_on_prem_vm](../clone_on_prem_vm/README.md#Role-Variables) and respectively [import_image_and_run_gcp_instance](../roles/import_image_and_run_gcp_instance/REAME.md#Role-Variables).

## Dependencies

* Role: [gcp_setup_credentials](https://github.com/redhat-cop/cloud.gcp_ops/blob/main/roles/gcp_setup_credentials/README.md)

## Example Usage

You can define GCP credentials as ENV variables, inside the playbook  or create a ``credentials.yml`` file.

All the variables defined in section ``Playbook Variables`` can be defined inside the ``vars.yml`` file.

Create an `inventory.yml` file with information about the host running the KVM hypervisor.

```yaml
---
all:
  hosts:
    kvm:
      ansible_host: myhost
      ansible_user: myuser
      ansible_ssh_private_key_file: /path/to/private_key
      groups: mygroup
```

Run the playbook:

```shell
ansible-playbook cloud.gcp_ops.move_vm_from_on_prem_to_gcp.move_vm_from_on_prem_to_gcp -e "@credentials.yaml" -e "@vars.yaml" -i inventory.yml
```

## License

GNU General Public License v3.0 or later

See [LICENCE](https://github.com/ansible-collections/cloud.gcp_ops/blob/main/LICENSE) to see the full text.

## Author Information

* Ansible Cloud Content Team
