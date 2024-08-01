cloud.gcp_ops.manage_machine_image
=========

A role to create / delete a GCP custom machine image.

Requirements
------------

- GCP Service Account with permission to create a custom machine image.

Role Variables
--------------

**manage_machine_image_operation**: Whether to create or delete the GCP custom machine image. _Choices_: 'create', 'delete'. _Default_: 'create'.

**manage_machine_image_overwrite_image**: Whether to delete the GCP custom image if it already exists. _Choices_: 'false', 'true'. _Default_: 'false'.

**manage_machine_image_image_name**: Name of the GCP custom machine image to create / delete. _Required_: true. _Type_: str.

**manage_machine_image_source_disk_name**: The source disk name to create this image based on. _Type_: str.
In order to create an image, you must provide one of the following:
  * **This property**
  * The **manage_machine_image_source_image_name**
  * The **manage_machine_image_source_raw_disk**
  * The **manage_machine_image_source_snapshot_name**.

**manage_machine_image_source_snapshot_name**: The source snapshot name to create this image based on. _Type_: str. In order to create an image, you must provide one of the following:
  * **This property**
  * The **manage_machine_image_source_image_name**
  * The **manage_machine_image_source_raw_disk**
  * The **manage_machine_image_source_disk_name**.

**manage_machine_image_source_image_name**: The source image name to create this image based on. _Type_: str. In order to create an image, you must provide one of the following:
  * **This property**
  * The **manage_machine_image_source_snapshot_name**
  * The **manage_machine_image_source_raw_disk**
  * The **manage_machine_image_source_disk_name**.

**manage_machine_image_source_raw_disk**: The parameters of the raw disk image. _Type_: dict.

**manage_machine_image_image_encryption_key**: Encrypts the image using a customer-supplied encryption key. Required: false. _Type_: str.

**manage_machine_image_description**: A description of the GCP machine image. Provide this property when you create the resource. _Required_: false. _Type_: str.

**manage_machine_image_disk_size_gb**: Size of the machine image when restored onto a persistent disk (in GB). _Required_: false. _Type_: int.

**manage_machine_image_family**: The name of the image family to which this image belongs. The name of the image family must comply with RFC1035. _Required_: false. _Type_: str.

**manage_machine_image_labels**: Labels to apply to this image. _Required_: false. _Type_: dict.

**manage_machine_image_licenses**: Any applicable license URI. _Required_: false. _Type_: str.

**manage_machine_image_source_type**: The type of the image used to create this disk. The default and only value is RAW.

**manage_machine_image_guest_os_features**: A list of features to enable on the guest operating system. _Required_: false. _Type_: dict.

**manage_machine_image_source_disk_encryption_key**: The customer-supplied encryption key of the source disk. Required if the source disk is protected by a customer-supplied encryption key. _Type_: dict.

**manage_machine_image_zone**: A reference to the zone where the disk resides. If not set, it defaults to 'us-central1-a'.

Dependencies
------------

- NA

Example Playbook
----------------

    - hosts: localhost
      gather_facts: false

      vars:
        project: "{{ lookup('env', 'GCP_PROJECT') }}"
        auth_kind: "{{ lookup('env', 'GCP_AUTH_KIND') }}"
        service_account_file: "{{ lookup('env', 'GCP_SERVICE_ACCOUNT_FILE') }}"
        disk_name: your-disk-name
        image_name: your-new-image-name
        description: Just a simple description

      tasks:
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

See [LICENCE](https://github.com/redhat-cop/cloud.gcp_ops/blob/stable-2/LICENSE) to see the full text.

Author Information
------------------

- Ansible Cloud Content Team
