Role Name
=========

A role to create / delete a GCP custom machine image.

Requirements
------------

- NA

Role Variables
--------------

**manage_machine_image_operation**: Whether to create or delete the GCP custom machine image. Choices: 'create', 'delete'. Default: 'create'.
**manage_machine_image_overwrite_image** Whether to delete the GCP custom image if it already exists. Choices: 'false', 'true'. Default: 'false'.
**manage_machine_image_image_name** Name of the GCP custom machine image to create / delete. Required: true. Type: str.
**manage_machine_image_source_disk_name**: The source disk name to create this image based on. You must provide either this property or the manage_machine_image_source_raw_disk property but not both to create an image. Type: str.
**manage_machine_image_source_snapshot_name**: The source snapshot name to create this image based on. Type: str.
**manage_machine_image_source_image_name** The source image name to create this image based on. Type: str.
**manage_machine_image_source_raw_disk**: The parameters of the raw disk image. Type: dict.
**manage_machine_image_image_encryption_key**: Encrypts the image using a customer-supplied encryption key. Required: false. Type: str.
**manage_machine_image_description**: A description of the GCP machine image. Provide this property when you create the resource. Required: false. Type: str.
**manage_machine_image_disk_size_gb**: Size of the machine image when restored onto a persistent disk (in GB). Required: false. Type: int.
**manage_machine_image_family**: The name of the image family to which this image belongs. The name of the image family must comply with RFC1035. Required: false. Type: str.
**manage_machine_image_labels**: Labels to apply to this image. Required: false. Type: dict.
**manage_machine_image_licenses**: Any applicable license URI. Required: false. Type: str.
**manage_machine_image_source_type**: The type of the image used to create this disk. The default and only value is RAW.
**manage_machine_image_guest_os_features**: A list of features to enable on the guest operating system. Required: false. Type: dict.
**manage_machine_image_source_disk_encryption_key**: The customer-supplied encryption key of the source disk. Required if the source disk is protected by a customer-supplied encryption key. Type: dict.

Dependencies
------------

- NA

Example Playbook
----------------

    - hosts: localhost
      gather_facts: false

      vars:
        project: your-project-name
        auth_kind: serviceaccount
        service_account_file: /path/to/auth/credentials.json
        disk_name: your-disk
        image_name: your-new_image
        description: Just a simple description

      roles:
        - name: Create a new custom machine image
          ansible.builtin.include_role:
            name: cloud.gcp_ops.manage_machine_image
          vars:
            manage_machine_image_operation: create
            manage_machine_image_source_disk_name: "{{ disk_name }}"
            manage_machine_image_image_name: "{{ image_name }}"
            manage_machine_image_image_description: "{{ description }}"

License
-------

GNU General Public License v3.0 or later

See [LICENCE](https://github.com/ansible-collections/cloud.gcp_ops/blob/main/LICENSE) to see the full text.

Author Information
------------------

- Ansible Cloud Content Team
