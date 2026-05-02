---
name: update-module
description: This skill is used to update an existing terraform module.
---

# Update Terraform Module

This skill is used to update an existing **Terraform** module.

## Instructions

### 1. Establish the Context

To update the **AWS S3** module, we first check to see if the existing directory exists. This would exist under `modules/aws/s3`.
For more complicated module names, you may need to traverse `modules/aws` manually and make a determination as to which module needs update.
For example, to update an **AWS IAM** role module with directory structure

```text
modules/aws/iam/role
modules/aws/iam/instance-profile
modules/aws/iam/oidc-provider
```

we would use the `modules/aws/iam/role` directory as it best matches.
After finding the directory, we know the form of the tag as `<provider>-<resource>.v<MAJOR>.<MINOR>.<PATCH>`.
To find the current version, we can run

```bash
git tag -l "<provider>-<resource>*"
```

This will list all tags matching that resource - from this we can get the latest version.
Depending on the level of change, this determines the new tag and branch name - the major, minor or patch is increased.
Once this has been determined from the context, we can run `git checkout -b feature/<tag>` or `bugfix/<tag>` in bash to create the branch.

### 2. Files

The module should contain the following files:

- `main.tf` for the main **terraform** configuration;
- `variables.tf` for input variable declarations;
- `outputs.tf` for output value declarations;
- `provider.tf` for the provider information; and
- `README.md` for module documentation, managed by `terraform-docs`.

Each can be updated depending on the change requested.
New variables should always be referenced in `locals {}` in `main.tf`, then later referenced using `local.VAR`.
The `README` description should be updated if it is a meaningful change that requires it.

### 3. Formatting and Validating

We can utilise `pre-commit` for automated validating and updating documentation once the `hcl` has been updated.
To run `pre-commit` we execute

```bash
git add <path-to-module>
ROOT=$(pwd) && cd <path-to-module> && terraform init && cd $ROOT  # to terraform init correctly
pre-commit run --files <path-to-module>/*
```

If other files are changed outside of this module path, we should instead use the `--all-files` flag to run `pre-commit` on all files.
The `pre-commit` checks include basic repository-level checks like from https://github.com/pre-commit/pre-commit-hooks.
For **terraform** we check formatting (and fix it), validate the terraform and also update the docs using `terraform-docs` (all from here https://github.com/antonbabenko/pre-commit-terraform).
Before running the `pre-commit` we need to `terraform init` otherwise the `terraform_validate` will break.
If some files are fixed (e.g. `README` gets updated), the `pre-commit` will say it failed.
So we need to run the `pre-commit` command again to see **Passed**.

After success, delete the `.terraform` directory and `.terraform.lock.hcl`.

### 4. Updating CHANGELOG and VERSION

The `CHANGELOG.md` should be updated to describe the changes with a new record.
In this case, a description of the module being created and its purpose.

```markdown
## [<version>](<git-diff-link>) YYYY-mm-dd

### Changed / Fixed
- <DESCRIPTION HERE>
```

For updating a module, the version will update according to the same semantic version upgrade in the module tag.
Say if `aws-s3.v1.0.0` becomes `aws-s3.v1.1.0` and the current repository version is `1.2.1`, then we would amend the _minor_ to `1.3.0`.
The version in `pyproject.toml` should also be updated to match this repository version.
A `git diff` link should also be added to see changes between module version in the **UI**.
This is of the form

```text
https://<repository-domain>/compare/<tag1>...<tag2>
```

This shows the difference between commits from `tag1` and `tag2`.
The repository domain can be found in `pyproject.toml` under `[project.urls]`.
We know `tag2` as this is the new repository version, but `tag1` is the repository version relating to the `aws-s3.v1.0.0` changes, in this example.
To find the repository tag we can use:

```bash
git show <previous-module-tag>:pyproject.toml | grep -E ^version
```

This will output `version = "<tag1>"` with the tag we want.

### 5. Pushing Code

Once the module has been updated and `pre-commit` checks have passed, we run the following to push the code to remote:

```bash
git commit -m "<relevant-commit-message>"
git push origin HEAD  # to push to remote
```
