import_image_and_run_gcp_instance
=================================

A role that imports a local .raw image into a GCP custom image and run a GCP instance.

Requirements
------------

GCP credentials with permissions:
  * to upload an object into a GCP storage bucket;
  * to create a GCP custom image and get information about it;
  * to start a GCP compute instance.

Role Variables
--------------

* **import_image_and_run_gcp_instance_import_image_name**: (Required) The name you want to assign to the GCP custom image.
* **import_image_and_run_gcp_instance_bucket_name**: (Required) The name of the GCP storage bucket name where you want to upload the .raw image. It must exist in the region the instance is created.
* **import_image_and_run_gcp_instance_image_path**: (Required) The path where the .raw image is stored.
* **import_image_and_run_gcp_instance_instance_name**: (Required) The name of the GCP compute instance you want to create using the imported custom image.
* **import_image_and_run_gcp_instance_deletion_protection** (bool): (Optional) Whether the resource should be protected against deletion.
* **import_image_and_run_gcp_instance_labels** (dict): (Optional) Labels to apply to this instance. A list of key->value pairs.
* **import_image_and_run_gcp_instance_metadata** (dict): (Optional) The metadata key/value pairs to assign to instances that are created from this template. These pairs can consist of custom metadata or predefined keys.
* **import_image_and_run_gcp_instance_machine_type** (str): (Optional) A reference to a machine type which defines VM kind.
* **import_image_and_run_gcp_instance_scheduling** (dict): (Optional) Sets the scheduling options for this instance.
* **import_image_and_run_gcp_instance_service_accounts** (list): (Optional) A list of service accounts, with their specified scopes, authorized for this instance. Only one service account per VM instance is supported.
* **import_image_and_run_gcp_instance_tags** (list): (Optional) A list of tags to apply to this instance. Tags are used to identify valid sources or targets for network firewalls and are specified by the client during instance creation. The tags can be later modified by the setTags method. Each tag within the list must comply with RFC1035.
* **import_image_and_run_gcp_instance_network_interfaces** (list): (Required) An array of configurations for this interface. This specifies how this interface is configured to interact with other network services, such as connecting to the internet. At least one network interface is required. For a full list of parameters visit https://docs.ansible.com/ansible/latest/collections/google/cloud/gcp_compute_instance_module.html#parameter-network_interfaces. It must exist in the region the instance is created.
* **import_image_and_run_gcp_instance_gcp_zone** (str): (Optional) A reference to the zone where the compute machine resides. If not set, it defaults to 'us-central1-a'.

Dependencies
------------

- role: [gcp_setup_credentials](../gcp_setup_credentials/README.md)

Example Playbook
----------------
This role can be used together with the [cloud.gcp_ops.clone_on_prem_vm](../clone_on_prem_vm/README.md) role as shown below.

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

All the variables defined in section ``Playbook Variables`` can be defined inside the ``vars.yml`` file.

Create a ``playbook.ym`` file like this:

```
---
- hosts: localhost
  gather_facts: false

  tasks:
    - name: Import 'cloud.gcp_ops.clone_on_prem_vm' role
      ansible.builtin.import_role:
        name: cloud.gcp_ops.clone_on_prem_vm
      vars:
        clone_on_prem_vm_source_vm_name: "{{ clone_on_prem_vm_source_vm_name }}"
        clone_on_prem_vm_image_name: "{{ clone_on_prem_vm_image_name }}"
        clone_on_prem_vm_local_image_path: "{{ clone_on_prem_vm_local_image_path }}"
        clone_on_prem_vm_uri: "{{ clone_on_prem_vm_uri }}"
      delegate_to: kvm

    - name: Import 'cloud.gcp_ops.import_image_and_run_gcp_instance' role
      ansible.builtin.import_role:
        name: cloud.gcp_ops.import_image_and_run_gcp_instance
      vars:
        import_image_and_run_gcp_instance_bucket_name: "{{ import_image_and_run_gcp_instance_bucket_name }}"
        import_image_and_run_gcp_instance_image_path: "{{ import_image_and_run_gcp_instance_image_path }}"
        import_image_and_run_gcp_instance_instance_name: "{{ import_image_and_run_gcp_instance_instance_name }}"
        import_image_and_run_gcp_instance_machine_type: "{{ import_image_and_run_gcp_instance_machine_type }}"
        import_image_and_run_gcp_instance_import_image_name: "{{ import_image_and_run_gcp_instance_import_image_name }}"
        import_image_and_run_gcp_instance_network_interfaces: "{{ import_image_and_run_gcp_instance_network_interfaces }}"
        import_image_and_run_gcp_instance_zone: "{{ import_image_and_run_gcp_instance_zone }}"
```

Run the playbook:

```shell
ansible-playbook playbook.yml -i inventory.yml -e "@vars.yml"
```


License
-------

GNU General Public License v3.0 or later

See [LICENCE](https://github.com/ansible-collections/cloud.gcp_ops/blob/main/LICENSE) to see the full text.

Author Information
------------------

- Ansible Cloud Content Team
