# aws_setup_credentials

A role to define credentials for google.cloud modules. The role defines a variable named **gcp_setup_credentials\_\_output** which contains GCP credentials for google.cloud modules based on user input.

## Requirements

N/A

## Role Variables

- **gcp_auth_kind**: The type of credential to use. Choices: ``application``, ``machineaccount``, ``serviceaccount``, ``accesstoken``. Default to ``serviceaccount``
- **gcp_service_account_content**: The contents of a Service Account JSON file, either in a dictionary or as a JSON string.
- **gcp_service_account_file**: The path of a Service Account JSON file.
- **gcp_service_account_email**: An optional service account email address if ``gcp_auth_kind`` is set to ``machineaccount``and the user does not wish to use the default email.
- **gcp_access_token**: An OAuth2 access token if ``gcp_auth_kind`` is set to ``accesstoken``.
- **gcp_project**: The GCP project to use..
- **gcp_scopes**: A List of GCP scopes to be used.


## Dependencies

- NA

## Example Playbook

    - hosts: localhost
      gather_facts: false

      roles:
        - role: cloud.gcp_ops.gcp_setup_credentials
          gcp_service_account: path_to_my_service_account_file
          gcp_project: my-sample-project

      tasks:
        - name: Create a GCP storage bucket
          module_defaults:
            group/gcp:
              '{{ gcp_setup_credentials__output }}'
          block:
            - name: Create a GCP Storage bucket
              google.cloud.gcp_storage_bucket:
                name: my-bucket-test

## License

GNU General Public License v3.0 or later

See [LICENCE](https://github.com/ansible-collections/cloud.aws_troubleshooting/blob/main/LICENSE) to see the full text.

## Author Information

- Ansible Cloud Content Team
