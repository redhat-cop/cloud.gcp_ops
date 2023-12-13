# cloud.gcp_ops roles/playbooks to demo Ansible on GCP

This repository hosts the `cloud.gcp_ops` Ansible Collection.

The collection includes a variety of Ansible roles and playbooks to help automate the management of resources on GCP.

<!--start requires_ansible-->
## Ansible version compatibility

This collection has been tested against following Ansible versions: **>=2.14.0**.

## Included content

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

## Installation and Usage

### Requirements

The [google.cloud](https://github.com/ansible-collections/google.cloud), [community.libvirt](https://github.com/ansible-collections/community.libvirt) and [community.general](https://github.com/ansible-collections/community.general) collections MUST be installed in order for this collection to work.

### Installation

Clone the collection repository.

```shell
  mkdir -p ~/.ansible/collections/ansible_collections/cloud/gcp_ops
  cd ~/.ansible/collections/ansible_collections/cloud/gcp_ops
  git clone https://github.com/redhat-cop/cloud.gcp_ops .
```

### Using this collection

Once installed, you can reference the cloud.gcp_ops collection content by its fully qualified collection name (FQCN), for example:

```yaml
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
```

### See Also

* [Ansible Using collections](https://docs.ansible.com/ansible/latest/user_guide/collections_using.html) for more details.


## Contributing to this collection

We welcome community contributions to this collection. If you find problems, please open an issue or create a PR against this collection repository.

### Testing and Development

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

#### Integration Tests

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

## License

GNU General Public License v3.0 or later

See [LICENSE](https://github.com/ansible-collections/cloud.gcp_ops/blob/main/LICENSE) to see the full text.
