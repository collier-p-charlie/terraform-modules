# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.


## Overview

This repository exists to home Terraform modules for use in infrastructure deployments.


## Repository Structure

### .github

The [.github](.github) folder contains **GitHub** configuration files.
- [ISSUE_TEMPLATE](.github/ISSUE_TEMPLATE) contains templates for creating issues in the **GitHub UI**;
- [scripts](.github/scripts) contains useful bash scripts for use in `pre-commit` and **GitHub** _actions_;
  - [check-branch-name](.github/scripts/check-branch-name.sh) ensures the correct branch naming conventions;
  - [check-changed-file](.github/scripts/check-changed-file.sh) is used for ensuring particular files have been updated;
  - [check-changelog-has-version](.github/scripts/check-changelog-has-version.sh) is used to ensure the [CHANGELOG](CHANGELOG.md) is updated;
  - [check-tag](.github/scripts/check-tag.sh) is used to see a particular `git` tag already exists;
  - [check-version-bump](.github/scripts/check_version_bump.py) is used to ensure the version follows semantic versioning updates; and
  - [create-tag](.github/scripts/create-tag.sh) is used to create the `git` tag.
- [workflows](.github/workflows) contains the **GitHub** _action_ configurations;
  - [auto-tagging](.github/workflows/auto-tagging.yaml) is used to `git` tag after **PR** closure, with tag coming from the branch name;
  - [check-changelog](.github/workflows/check-changelog.yaml) is used to ensure the [CHANGELOG](CHANGELOG.md) is updated at **PR** time;
  - [check-version-upgraded](.github/workflows/check-version-upgraded.yaml) ensures the project versioning is upgraded not degraded; and
  - [enforce-branch-naming](.github/workflows/enforce-branch-naming.yaml) checks the `git` branch name follows the convention.
- [pull_request_template](.github/pull_request_template.md) is the **Markdown** used to pre-populate the **PR** description.

### Modules

This folder contains the **terraform** modules.
The main subfolders are organised by provider, e.g. `aws` or `snowflake`.


### Root Files

The following are files at the root of the repository.

- [terraform-docs](.terraform-docs.yml) contains the configuration for the `terraform-docs` automatic documentation on module updates;
- [CHANGELOG](CHANGELOG.md) is the changelog for the repository, following semantic versioning;


## Running and Setup

Ensure `terraform`, `terraform-docs` and `uv` are installed by running 

```bash 
terraform -v
terraform-docs -v
uv --version
```

To install `pre-commit`, we use `uv` and run `uv sync` which utilises the `uv.lock` and project requirements.
Then we can ensure `pre-commit install` is run on root to ensure it is installed.
