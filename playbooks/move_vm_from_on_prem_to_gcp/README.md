# cloud.gcp_ops.move_vm_from_on_prem_to_gcp

A playbook to migrate an existing on prem VM running on KVM hypervisor to GCP.

## Requirements

**qemu** and **qemu-img** packages installed on the host running the KVM hypervisor.

The ``cloud.gcp_ops.clone_one_prem_vm`` requires privilege escalation because the .qcow2 file created by ``virt-clone`` is owned by root and ``qemu-img convert`` requires access to convert it to .raw.

VM Import requires a role to perform certain operations on your behalf. You must create a service role named vmimport with a trust relationship policy document that allows VM Import to assume the role, and you must attach an IAM policy to the role.

GCP credentials with permissions:
  * to upload an object into a GCP storage bucket;
  * to create a GCP custom image and get information about it;
  * to start a GCP compute instance.

## Playbook Variables

* **kvm_host** (dict): Information about the host running the KVM hypervisor that are dynamically added to the inventory.
    * **name** (str): This is a user-defined name for the host you are adding to the inventory.
    * **ansible_host** (str): This variable specifies the hostname or IP address of the host you are adding to the inventory.
    * **ansible_user** (str): This variable specifies the SSH username that Ansible should use when connecting to the host.
    * **ansible_ssh_private_key_file** (str): This variable specifies the path to the SSH private key file that Ansible should use for authentication when connecting to the host.
    * **groups**: (list) This variable enabled you to assign the newly added host to one or more groups in the inventory.

### For google.cloud.clone_on_prem_vm

* **clone_on_prem_vm_source_vm_name** (str): (Required) The name of the on-prem VM you want to clone.
* **clone_on_prem_vm_image_name** (str): (Optional) The name you want to call the cloned image. If not set, the **clone_on_prem_vm_source_vm_name** will be used with a _-clone_ suffix.
* **clone_on_prem_vm_overwrite** (bool): (Optional) Whether to overwrite or not an already existing on prem VM clone. Default: true.
* **clone_on_prem_vm_local_image_path** (str): (Optional) The path where you would like to save the image. If the path does not exists on localhost, the role will create it. If this parameter is not set, the role will save the image in a _~/tmp_ folder.
* **clone_on_prem_vm_uri** (str): (Optional) Libvirt connection uri. Default: "qemu:///system".

### For google.cloud.import_image_and_run_gcp_instance

**import_image_and_run_gcp_instance_import_image_name** (str): (Required) The name you want to assign to the GCP custom image.
* **import_image_and_run_gcp_instance_bucket_name** (str): (Required) The name of the GCP storage bucket name where you want to upload the .raw image. It must exist in the region the instance is created.
* **import_image_and_run_gcp_instance_image_path** (str): (Required) The path where the .raw image is stored.
* **import_image_and_run_gcp_instance_instance_name** (str): (Required) The name of the GCP compute instance you want to create using the imported custom image.
* **import_image_and_run_gcp_instance_deletion_protection** (bool): (Optional) Whether the resource should be protected against deletion.
* **import_image_and_run_gcp_instance_labels** (dict): (Optional) Labels to apply to this instance. A list of key->value pairs.
* **import_image_and_run_gcp_instance_metadata** (dict): (Optional) The metadata key/value pairs to assign to instances that are created from this template. These pairs can consist of custom metadata or predefined keys.
* **import_image_and_run_gcp_instance_machine_type** (str): (Optional) A reference to a machine type which defines VM kind.
* **import_image_and_run_gcp_instance_network_interfaces** (list): (Required) An array of configurations for this interface. This specifies how this interface is configured to interact with other network services, such as connecting to the internet. Only one network interface is supported per instance. It must exist in the region the instance is created.
* **import_image_and_run_gcp_instance_scheduling** (dict): (Optional) Sets the scheduling options for this instance.
* **import_image_and_run_gcp_instance_service_accounts** (list): (Optional) A list of service accounts, with their specified scopes, authorized for this instance. Only one service account per VM instance is supported.
* **import_image_and_run_gcp_instance_tags** (list): (Optional) A list of tags to apply to this instance. Tags are used to identify valid sources or targets for network firewalls and are specified by the client during instance creation. The tags can be later modified by the setTags method. Each tag within the list must comply with RFC1035.
* **import_image_and_run_gcp_zone** (str): (Optional) A reference to the zone where the compute machines reside. If not set, it defaults to 'us-central1-a'.

## Dependencies

* Role: [gcp_setup_credentials](https://github.com/redhat-cop/cloud.gcp_ops/blob/main/roles/gcp_setup_credentials/README.md)

## Example Usage

You can define GCP credentials as ENV variables, inside the playbook  or create a ``credentials.yml`` file.
All the variables defined in section ``Playbook Variables`` can be defined inside the ``vars/main.yml`` file.

Run the playbook:

```shell
ansible-playbook cloud.gcp_ops.move_on_prem_vm_to_gcp -e "@credentials.yaml"
```

## License

GNU General Public License v3.0 or later

See [LICENCE](https://github.com/ansible-collections/cloud.gcp_ops/blob/main/LICENSE) to see the full text.

## Author Information

* Ansible Cloud Content Team