===========================
cloud.gcp_ops Release Notes
===========================

.. contents:: Topics

v2.0.0
======

Release Summary
---------------

This release removes support for ansible-core < 2.15.

Minor Changes
-------------

- Bump version of ansible-lint to minimum 24.7.0 (https://github.com/redhat-cop/cloud.gcp_ops/pull/14).

Breaking Changes / Porting Guide
--------------------------------

- Bump minimum version requirement for ansible-core to 2.15 (https://github.com/redhat-cop/cloud.gcp_ops/pull/14).

v1.0.0
======

Release Summary
---------------

This collection release includes several Ansible roles and playbooks to help automate the management of resources on GCP.

New Playbooks
-------------

- cloud.gcp_ops.move_vm_from_on_prem_to_gcp - A playbook to migrate an existing on prem VM running on KVM hypervisor to GCP.
- cloud.gcp_ops.upload_file_to_cloud_storage - A playbook to upload a file from a remote host to GCP Cloud Storage.

New Roles
---------

- cloud.gcp_ops.clone_on_prem_vm - A role to clone an existing on prem VM using the KVM hypervisor.
- cloud.gcp_ops.import_image_and_run_gcp_instance - A role that imports a local .raw image into a GCP custom image and run a GCP instance.
- cloud.gcp_ops.manage_machine_image - A role to create / delete a GCP custom machine image.
