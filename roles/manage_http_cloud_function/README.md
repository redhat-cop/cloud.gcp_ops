# manage_http_cloud_function

A role to create and delete cloud functions.


## Role Variables

- operation - Choices include 'create' and 'delete'.
`required` always

- manage_http_cloud_function_name - A user-defined name of the function. Function names must be unique globally and match pattern `projects/*/locations/*/functions/*`.
`required` always

- manage_http_cloud_function_location - The location of this cloud function.
`required` always

- manage_http_cloud_function_project - ID of the Google Cloud Platform project to use.
`required` always

- manage_http_cloud_function_runtime - The runtime in which to run the function.
`required` when `operation=create`

- manage_http_cloud_function_available_memory_mb - The amount of memory in MB available for a function.

- manage_http_cloud_function_description - The amount of memory in MB available for a function.

- manage_http_cloud_function_scopes - Array of scopes to be used.

- manage_http_cloud_function_entry_point - The name of the function (as defined in source code) that will be executed.
`required` when `operation=create`

- source_archive_url - The Google Cloud Storage URL, starting with gs://, pointing to the zip archive which contains the function.
`required` when `operation=create`

- auth_kind - The type of credential used. Currently supports "serviceaccount".
`required` always

- service_account_file - The path of a Service Account JSON file if serviceaccount is selected as type.
`required` always

Return Value
------------
On successful creation of cloud function, the cloud function's details can be accessed using the variable `manage_http_cloud_function_func_details` set during the role execution.

## Examples
```
- name: Create a cloud function
  ansible.builtin.include_role:
    name: cloud.gcp_ops.manage_http_cloud_function
  vars:
    operation: create
    manage_http_cloud_function_name: my-test-cloud-function
    manage_http_cloud_function_location: us-central1
    manage_http_cloud_function_project: project-uscentral-demo
    manage_http_cloud_function_entry_point: helloHttp
    manage_http_cloud_function_source_archive_url: gs://test-storage-bucket/function-source.zip
    manage_http_cloud_function_runtime: nodejs20
    auth_kind: serviceaccount
    service_account_file: /path/to/auth/credentials.json

- name Print the details of created cloud function
  debug:
    var: manage_http_cloud_function_func_details

- name: Delete a cloud function using manage_http_cloud_function role
  ansible.builtin.include_role:
    name: cloud.gcp_ops.manage_http_cloud_function
  vars:
    operation: delete
    manage_http_cloud_function_name: my-test-cloud-function
    manage_http_cloud_function_location: us-central1
    manage_http_cloud_function_project: project-uscentral-demo
    auth_kind: serviceaccount
    service_account_file: /path/to/auth/credentials.json
```