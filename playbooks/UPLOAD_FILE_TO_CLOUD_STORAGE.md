# cloud.gcp_ops.upload_file

A playbook to upload a file from a remote host to GCP Cloud Storage.

## Requirements

GCP user account with at minimum the storage.objectCreator IAM role or equivalent permissions.

## Playbook Variables

* **host_with_file**: Name of the remote host with file to upload to. Default: `"all"`.
* **upload_file_to_cloud_storage_bucket**: The name of the GCP storage bucket to upload the file to. **Required**
* **upload_file_to_cloud_storage_file_path**: Path to file to upload. **Required**
* **upload_file_to_cloud_storage_object_name**: The name to give the object in cloud storage. If not provided, defaults to the base file name (without path) of `upload_file_to_cloud_storage_file_path`.

## Dependencies

* Role: [gcp_setup_credentials](https://github.com/redhat-cop/cloud.gcp_ops/blob/main/roles/gcp_setup_credentials/README.md)

## Example Usage

With GCP credentials set as ENV variables or included in vars, create vars and inventory files.

`vars.yaml`:

```yaml
---
upload_file_to_cloud_storage_bucket: my-bucket
upload_file_to_cloud_storage_file_path: /path/to/file/on/remote/host
```

`inventory.ini`:

```ini
[all]
sample_host ansible_ssh_user=some_user ansible_host=xxx.xxx.xxx.xxx
```

Run the playbook:

```shell
ansible-playbook cloud.gcp_ops.upload_file_to_cloud_storage -e "@vars.yaml" -i inventory.ini
```

## License

GNU General Public License v3.0 or later

See [LICENCE](https://github.com/ansible-collections/cloud.aws_ops/blob/main/LICENSE) to see the full text.

## Author Information

* Ansible Cloud Content Team
