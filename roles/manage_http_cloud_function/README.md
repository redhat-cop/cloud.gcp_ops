# manage_http_cloud_function

A role to create and delete cloud functions.


## Role Variables

- operation - Choices include 'create' and 'delete'.

- func_name - A user-defined name of the function. Function names must be unique globally and match pattern `projects/*/locations/*/functions/*`.

- func_location - The location of this cloud function.

- func_project - ID of the Google Cloud Platform project to use.

- auth_kind - The type of credential used. Currently supports "serviceaccount".

- service_account_file - The path of a Service Account JSON file if serviceaccount is selected as type.


## Examples

- name: Delete a cloud function using manage_http_cloud_function role
  ansible.builtin.include_role:
    name: cloud.gcp_ops.manage_http_cloud_function
  vars:
    operation: delete
    func_name: my-test-cloud-function
    func_location: us-central1
    func_project: project-uscentral-demo
    auth_kind: serviceaccount
    service_account_file: /path/to/auth/credentials.json
