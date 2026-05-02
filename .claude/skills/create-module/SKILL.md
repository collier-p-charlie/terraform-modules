---
name: create-module
description: This skill is used to create a new terraform module.
---

# Create Terraform Module

This skill is used to create a **Terraform** module.

## Instructions

### 1. Establish the Context

To create an **AWS** module to create an **S3** bucket, create the directory `modules/aws/s3` using `mkdir -p` in bash.
The tag for the module would be `aws-s3.v1.0.0` initially (following the folder structure).
The general structure would be `<provider>-<resource>.v<MAJOR>.<MINOR>.<PATCH>`, but `1.0.0` on creation.
If we were creating an **IAM** role module under `modules/aws/iam/role`, the tag would match `aws-iam-role` instead.
We can create a `git` branch and check it out using `git checkout -b feature/<tag>` in bash.

### 2. Base Files

The folder created should contain the following base files:

- `main.tf` for the main **terraform** configuration;
- `variables.tf` for input variable declarations;
- `outputs.tf` for output value declarations;
- `provider.tf` for the provider information; and
- `README.md` for module documentation, managed by `terraform-docs`.

### 3. Main

The structure of this should look as follows:

```terraform
locals {}

resource "provider_resource" "this" {}
```

All variables should be references with a local variable; i.e. `var.` is only used within `locals`.
Unless otherwise specified or multiple resources of the same type are used, we use `"this"` for resource naming.

### 4. Variables

The most basic variable looks as follows

```terraform
variable "NAME" {
  type        = TYPE
  description = "DESC"
  default     = null  # only add if not-required
}
```

Add a validation block if a provided value could break the deployment, e.g. an integer being positive

```terraform
validation {
  condition     = var.NAME > 0
  error_message = "<VAR> must be positive"
}
```

or for **ENUM** where only certain variable fields are allowed.
Some of this context may be obtained from the documentation, e.g. **S3** bucket names cannot exceed 64 characters.
For **AWS** modules, ensure a _tags_ variable is present and applied to all resources.

### 5. Outputs

If any outputs are specified / required for downstream modules, they are specified here as follows

```terraform
output "name" {
  value       = <resource_type>.this.<attribute>
  description = "DESC"
}
```

### 6. Provider

Since we are creating a module, we should prefer to use the latest version of **terraform** and the **provider**, unless otherwise specified.
The format of the `provider.tf` can be shown below for the **AWS** provider example.

```terraform
terraform {
  required_version = "~> <LATEST_TERRAFORM_MAJOR>.<LATEST_TERRAFORM_MINOR>.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> <LATEST_AWS_PROVIDER_MINOR>"
    }
  }
}
```

Before writing this file, always look up the current latest stable versions:
- **Terraform**: check https://github.com/hashicorp/terraform/releases
- **AWS provider**: check https://github.com/hashicorp/terraform-provider-aws/releases

For **Terraform**, use `~> X.Y.0` (e.g. `~> 1.15.0`) — this allows patch upgrades within the minor version but not minor version bumps.
For the **AWS** provider, use `~> X.Y` (e.g. `~> 6.43`) to allow minor and patch upgrades but not major version bumps.

### 7. README

The base `README` file should contain

```markdown
# <PROVIDER> <RESOURCE>
```

Use a human-readable title, e.g. `# AWS S3` rather than `# aws/s3`.

```markdown
<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
```

This is where `terraform-docs` populates between.
Above this we can add custom documentation for the module.
Indeed, any context for design choices that will not come from the basic terraform documentation.

### 8. Formatting and Validating

We can utilise `pre-commit` for automated validating and updating documentation etc.
To run `pre-commit` we execute

```bash
git add <path-to-module>
ROOT=$(pwd) && cd <path-to-module> && terraform init && cd $ROOT  # to terraform init correctly
pre-commit run --files <path-to-module>/*
```

We need to `git add` first otherwise `pre-commit` will not detect the files.
If other files are changed outside of this module path, we should instead use the `--all-files` flag to run `pre-commit` on all files.
The `pre-commit` checks include basic repository-level checks like from https://github.com/pre-commit/pre-commit-hooks.
For **terraform** we check formatting (and fix it), validate the terraform and also update the docs using `terraform-docs` (all from here https://github.com/antonbabenko/pre-commit-terraform).
Before running the `pre-commit` we need to `terraform init` otherwise the `terraform_validate` will break.
If some files are fixed (e.g. `README` gets updated), the `pre-commit` will say it failed.
So we need to run the `pre-commit` command again to see **Passed**.

After success, delete the `.terraform` directory and `.terraform.lock.hcl`.

### 9. Updating CHANGELOG and VERSION

The `CHANGELOG.md` should be updated to describe the changes.
In this case, a description of the module being created and its purpose.

```markdown
## [<version>]() YYYY-mm-dd

### Added
- <DESCRIPTION HERE>
```

For creating a new module, this would be a minor update say `X.Y.Z` to `X.(Y+1).Z`.
The version in `pyproject.toml` should also be updated, depending on the type of change made to the module.

### 10. Pushing Code

Once the module has been created locally and tested, we can run

```bash
git commit -m "<relevant-commit-message>"
git push origin HEAD  # to push to remote
```

**Important**: do not manually run `terraform-docs` before committing.
It is already executed as part of `pre-commit` in step 8.
Just stage whatever files `pre-commit` modified and commit.
