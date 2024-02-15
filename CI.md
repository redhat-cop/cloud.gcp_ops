# CI

## cloud.gcp_ops Collection

GitHub Actions are used to run the Continuous Integration for redhat-cop/cloud.gcp_ops collection. The workflows used for the CI can be found [here](https://github.com/redhat-cop/cloud.gcp_ops/tree/main/.github/workflows). These workflows include jobs to run the sanity tests, linters and changelog check. The following table lists the python and ansible versions against which these jobs are run.

| Jobs | Description | Python Versions | Ansible Versions |
| ------ |-------| ------ | -----------|
| changelog |Checks for the presence of Changelog fragments | 3.9 | devel |
| Linters | Runs `ansible-lint`, `black`,`flake8` and `isort`| 3.9 and 3.11 for ansible-lint| devel |
| Sanity | Runs ansible sanity checks | 3.9, 3.10, 3.11, 3.12 | 2.14 (not on3.12), 2.15 (not on 3.12), 2.16 (not on 3.9), stable (not on 3.9), Devel (not on 3.9) |
