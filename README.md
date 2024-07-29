# cloud.gcp_ops roles/playbooks Validate Content Collection

This repository hosts the `cloud.gcp_ops` Ansible Collection.

## Description

This collection is curated to provide users with a robust set of roles, playbooks, and rulebooks that simplify and streamline various GCP operations.

## Requirements

The [google.cloud](https://github.com/ansible-collections/google.cloud), [community.libvirt](https://github.com/ansible-collections/community.libvirt) and [community.general](https://github.com/ansible-collections/community.general) collections MUST be installed in order for this collection to work.

<!--start requires_ansible-->
### Ansible version compatibility

This collection has been tested against following Ansible versions: **>=2.15.0**.

### Python version compatibility

This collection requires Python 3.11 or greater.

### Included content

Click on the name of a role to view that content's documentation:

<!--start collection content-->
### Roles
Name | Description
--- | ---
[cloud.gcp_ops.clone_on_prem_vm](https://github.com/ansible-collections/cloud.gcp_ops/blob/main/roles/clone_on_prem_vm/README.md)|A role to clone an existing on prem VM using the KVM hypervisor.
[cloud.gcp_ops.import_image_and_run_gcp_instance](https://github.com/ansible-collections/cloud.gcp_ops/blob/main/roles/import_image_and_run_gcp_instance/README.md)|A role that imports a local .raw image into an GCP custom image and run an GCP instance.
[cloud.gcp_ops.manage_machine_image](https://github.com/redhat-cop/cloud.gcp_ops/blob/main/roles/manage_machine_image/README.md)|A role to create / delete a GCP custom machine image.

### Playbooks
Name | Description
--- | ---
[cloud.gcp_ops.upload_file_to_cloud_storage](https://github.com/redhat-cop/cloud.gcp_ops/blob/main/playbooks/upload_file_to_cloud_storage/README.md)|A playbook to upload a local file to GCP Cloud Storage.
[cloud.gcp_ops.move_vm_from_on_prem_to_gcp](https://github.com/ansible-collections/cloud.gcp_ops/blob/main/playbooks/move_vm_from_on_prem_to_gcp/README.md)|A playbook to migrate an existing on prem VM running on KVM hypervisor to GCP.
<!--end collection content-->

## Installation

To consume this Validated Content from Automation Hub, please ensure that you add the following lines to your ansible.cfg file.

```
[galaxy]
server_list = automation_hub

[galaxy_server.automation_hub]
url=https://cloud.redhat.com/api/automation-hub/
auth_url=https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/token
token=<SuperSecretToken>
```
The token can be obtained from the [Automation Hub Web UI](https://console.redhat.com/ansible/automation-hub/token).

Once the above steps are done, you can run the following command to install the collection.

```
ansible-galaxy collection install cloud.gcp_ops
```

## Use Case

Once installed, you can reference the cloud.gcp_ops collection content by its fully qualified collection name (FQCN), for example:

```yaml

  # Create GCP custom machine image.
  - hosts: all
    vars:
        project: "{{ gcp_project }}"
        auth_kind: "{{ gcp_cred_kind }}"
        service_account_file: "{{ gcp_cred_file }}"
    tasks:
      - name: Create a new custom machine image
        ansible.builtin.include_role:
            name: cloud.gcp_ops.manage_machine_image
        vars:
            manage_machine_image_operation: create
            manage_machine_image_source_disk_name: "{{ disk_name }}"
            manage_machine_image_image_name: "{{ image_name }}"
            manage_machine_image_image_description: "{{ description }}"


  # clone an existing on prem VM using the KVM hypervisor.
  - hosts: kvm
    tasks:
      - name: Import 'cloud.gcp_ops.clone_on_prem_vm' role
        ansible.builtin.include_role:
          name: cloud.gcp_ops.clone_on_prem_vm
        vars:
          clone_on_prem_vm_source_vm_name: "{{ clone_on_prem_vm_source_vm_name }}"
          clone_on_prem_vm_image_name: "{{ clone_on_prem_vm_image_name }}"
          clone_on_prem_vm_local_image_path: "{{ clone_on_prem_vm_local_image_path }}"
          clone_on_prem_vm_uri: "{{ clone_on_prem_vm_uri }}"
```

## Contributing to this collection

We welcome community contributions to this collection. If you find problems, please open an issue or create a PR against this collection repository.
See [CONTRIBUTING.md](https://github.com/redhat-cop/cloud.gcp_ops/blob/main/CONTRIBUTING.md) for more details.

## Testing

The project uses `ansible-lint` and `black`.
Assuming this repository is checked out in the proper structure,
e.g. `collections_root/ansible_collections/cloud/gcp_ops/`, run:

```shell
  tox -e linters
```

Sanity and unit tests are run as normal:

```shell
  ansible-test sanity
```

### Integration Tests

Integration tests require GCP credentials that must be provided to ansible-test. To authenticate using service account credentials:

1. [Create a service account key](https://support.google.com/cloud/answer/6158849?hl=en&ref_topic=6262490#serviceaccounts&zippy=%2Cservice-accounts) in the GCP console and save the json cred file.

2. Create the file `tests/integration/cloud-config-gcp.ini` containing the following:

   ```ini
    [default]
    gcp_project: <project ID>
    gcp_cred_file: </path/to/cred/file.json>
    gcp_cred_kind: serviceaccount
   ```

To authenticate with [application default credentials](https://cloud.google.com/docs/authentication/provide-credentials-adc) via the [GCloud CLI](https://cloud.google.com/sdk/docs/install):

1. Once you have installed `gcloud` and performed basic initialization (via `gcloud init`) run:

   ```shell
    gcloud auth application-default login
   ```

2. Create the file `tests/integration/cloud-config-gcp.ini` containing the following:

   ```ini
    [default]
    gcp_project: <project ID>
    gcp_cred_kind: application
   ```

Once credentials are set up, run all integration tests with `ansible-test integration` or run a subset of integration tests with `ansible-test integration <target>`

This collection is tested using GitHub Actions. To know more about CI, refer to [CI.md](https://github.com/https://github.com/redhat-cop/cloud.gcp_ops/blob/main/CI.md).

## Support

For the latest supported versions, refer to the release notes below.

If you encounter issues or have questions, you can submit a support request through the following channels:
 - GitHub Issues: Report bugs, request features, or ask questions by opening an issue in the [GitHub repository](https://github.com/redhat-cop/cloud.gcp_ops/).
 - Ansible Community: Engage with the Ansible community on the Ansible Project Mailing List or [Ansible Forum](https://forum.ansible.com/g/AWS).

## Release Notes

See the [raw generated changelog](https://github.com/redhat-cop/cloud.gcp_ops/blob/main/CHANGELOG.rst).


## Related Information

 - [Ansible User guide](https://docs.ansible.com/ansible/latest/user_guide/index.html).
 - [Ansible Community code of conduct](https://docs.ansible.com/ansible/latest/community/code_of_conduct.html)

## License

GNU General Public License v3.0 or later

See [LICENSE](https://github.com/ansible-collections/cloud.gcp_ops/blob/main/LICENSE) to see the full text.
