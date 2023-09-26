import_image_and_run_gcp_instance
=================================

A role that imports a local .raw image into an GCP custom image and run an GCP instance.

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

* **import_image_and_run_gcp_instance_network_interfaces** (list): (Optional) An array of configurations for this interface. This specifies how this interface is configured to interact with other network services, such as connecting to the internet. Only one network interface is supported per instance.

* **import_image_and_run_gcp_instance_scheduling** (dict): (Optional) Sets the scheduling options for this instance.

* **import_image_and_run_gcp_instance_service_accounts** (list): (Optional) A list of service accounts, with their specified scopes, authorized for this instance. Only one service account per VM instance is supported.

* **import_image_and_run_gcp_instance_tags** (list): (Optional) A list of tags to apply to this instance. Tags are used to identify valid sources or targets for network firewalls and are specified by the client during instance creation. The tags can be later modified by the setTags method. Each tag within the list must comply with RFC1035.

* **import_image_and_run_gcp_zone** (str): (Optional) A reference to the zone where the compute machines reside. If not set, it defaults to 'us-central1-a'.

Dependencies
------------

- role: [gcp_setup_credentials](../gcp_setup_credentials/README.md)

Example Playbook
----------------
This role can be used together with the [cloud.gcp_ops.clone_on_prem_vm](../clone_on_prem_vm/README.md) role as shown below. If you wish to use it separately, just ensure you set the **clone_on_prem_vm_local_image_path** parameter.

    - hosts: localhost
      gather_facts: false

      vars:
        on_prem_source_vm_name: "ubuntu-guest"
        on_prem_vm_image_name: "ubuntu-guest-image"
        bucket_name: "vm-s3-bucket"
        instance_name: "vm-clone"
        local_image_path: "~/images/"
        kvm_host:
          name: kvm
          ansible_host: 192.168.1.117
          ansible_user: vagrant
          ansible_ssh_private_key_file: ~/.ssh/id_rsa.pub
        machine_type: "t2.micro"
        import_image_name: "import-clone"

      tasks:
        - name: Add host to inventory
          ansible.builtin.add_host:
            name: "{{ kvm_host.name }}"
            ansible_host: "{{ kvm_host.ansible_host }}"
            ansible_user: "{{ kvm_host.ansible_user }}"
            ansible_ssh_common_args: -o "UserKnownHostsFile=/dev/null" -o StrictHostKeyChecking=no -i {{ kvm_host.ansible_ssh_private_key_file }}
            groups: "libvirt"

        - name: Import 'cloud.gcp_ops.clone_on_prem_vm' role
          ansible.builtin.import_role:
            name: cloud.gcp_ops.clone_on_prem_vm
          vars:
            clone_on_prem_vm_source_vm_name: "{{ on_prem_source_vm_name }}"
            clone_on_prem_vm_dest_image_name: "{{ on_prem_vm_image_name }}"
            clone_on_prem_vm_local_image_path: "{{ local_image_path }}"
          delegate_to: kvm

        - name: Import 'cloud.gcp_ops.import_image_and_run_gcp_instance' role
          ansible.builtin.import_role:
            name: cloud.gcp_ops.import_image_and_run_gcp_instance
          vars:
            import_image_and_run_gcp_instance_bucket_name: "{{ bucket_name }}"
            import_image_and_run_gcp_instance_image_path: "{{ clone_on_prem_vm_local_image_path }}"
            import_image_and_run_gcp_instance_instance_name: "{{ instance_name }}"
            import_image_and_run_aws_instance_machine_type: "{{ instance_type }}"
            import_image_and_run_aws_instance_import_image_name: "{{ import_image_name }}"

License
-------

GNU General Public License v3.0 or later

See [LICENCE](https://github.com/ansible-collections/cloud.gcp_ops/blob/main/LICENSE) to see the full text.

Author Information
------------------

- Ansible Cloud Content Team
