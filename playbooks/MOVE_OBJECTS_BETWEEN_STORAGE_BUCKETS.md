## cloud.gcp_ops.move_objects_between_storage_buckets

A playbook to move objects between GCP Storage buckets.

Variables
--------------

* **move_objects_between_storage_buckets_source_bucket**: The name of the GCP storage bucket to retrieve objects from. **Required**
* **move_objects_between_storage_buckets_dest_bucket**: The name of the GCP storage bucket to download objects to. **Required**
* **move_objects_between_storage_buckets_objects**: A list of existing objects from the source bucket. **Required**

See [cloud.gcp_ops.gcp_setup_credentials](https://github.com/redhat-cop/cloud.gcp_ops/blob/main/roles/gcp_setup_credentials/README.md) for required credentials variables.