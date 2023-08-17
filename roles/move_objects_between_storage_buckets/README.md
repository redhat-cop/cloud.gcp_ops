move_objects_between_storage_buckets
==================

A role to move an object from one GCP storage bucket to another.

Requirements
------------

GCP credentials with permission to upload, download and delete objects from GCP storage bucket.


Role Variables
--------------

* **move_objects_between_storage_buckets_source_bucket**: The name of the GCP storage bucket to retrieve objects from. **Required**
* **move_objects_between_storage_buckets_dest_bucket**: The name of the GCP storage bucket to download objects to. **Required**
* **move_objects_between_storage_buckets_objects**: A list of existing objects from the source bucket. **Required**

Dependencies
------------

- role: [gcp_setup_credentials](../gcp_setup_credentials/README.md)

## Example:
```
---
- name: Playbook for moving one object from one GCP storage bucket into another.
  hosts: localhost
  gather_facts: false

  roles:
    - role: cloud.gcp_ops.move_objects_between_storage_buckets
      move_objects_between_storage_buckets_source_bucket: my-src-storage
      move_objects_between_storage_buckets_dest_bucket: my-dest-storage
      move_objects_between_storage_buckets_objects:
        - object-1
        - object-2
```

License
-------

GNU General Public License v3.0 or later

See [LICENCE](https://github.com/redhat-cop/cloud.gcp_ops/blob/main/LICENSE) to see the full text.

Author Information
------------------

- Ansible Cloud Content Team
