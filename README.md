# Terraform Modules

This repository contains **terraform** modules.

- [Prerequisites](#prerequisites)
- [Module Structure](#module-structure)
- [Module Tagging](#module-tagging)


## Prerequisites

This repository depends on the following requirements:
- [Python](https://www.python.org) of version `>=3.13` for code execution;
- [uv](https://docs.astral.sh/uv/) for **Python** package management;
- [Terraform](https://developer.hashicorp.com/terraform) installation, currently of version `1.14.3` (can be installed with `brew install` on **MacOS**).

To install the `pre-commit` checks we need to install **Python** then run the following:

```bash
uv venv  # create the virtual environment
uv sync  # sync dependencies (i.e. install pre-commit)
pre-commit install  # setup pre-commit
```

Then before every commit, the **terraform** _modules_ and _code_ will be automatically formatted and the **terraform** _module documentation_ will also automatically update.
This is defined within the [pre-commit-config](.pre-commit-config.yaml) configuration file.


## Module Structure

Each module will consist of the following files:

- `main.tf` for the main _module_ **HCL** code;

- `variables.tf` for any input _variables_ for the _module_;
  - These are input within the **Terragrunt** using `inputs = {}`.

- `output.tf` containing any _outputs_ we want from the _module_ to use downstream;
  - These can be used in **Terragrunt** using dependencies as follows:
  ```hcl
  dependency "module" {
    config_path = "path/to/dependent/module"
  }

  inputs = {
    param = dependency.module.outputs.output_name  # how to use downstream
  }
  ```

- `README.md` a **README** **Markdown** file which auto-generates from **pre-commit**;
  - It must be initialised as empty with the markers
  ```markdown
  <!-- BEGIN_TF_DOCS -->
  <!-- END_TF_DOCS -->
  ```

- `shared_variables.tf` for any _shared variables_ which can be used across modules;
  - For example, [this](modules/aws/s3/shared_variables.tf) shared variables is a **symlink** to the outer shared variables.
  - For this **AWS** example, we need these variables to initialise the _provider_.
  - To create the **symlink**, from the folder we simply run
  ```bash
  ln -s ../shared_variables.tf .
  ```

- `provider.tf` for any _provider_ configuration for the _module_.
  - Similar to _shared variables_ we have a similar **symlink** setup for **AWS** modules [here](modules/aws/s3/provider.tf).


## Module Tagging

Every _module_ has a _tag_ so that it can be versioned. The format of the tag should be as follows:

```bash
<dir-name>.v<version>
```

so for example, the **AWS** **S3** module has a tag `aws-s3.v0.0.1`.
This semantic versioning of modules is used in the `source` reference of any **Terragrunt** or **terraform** reference to these modules.
This ensures the environments are using the correct versions, and allows different environments to be using independent modules.
When making changes to a _module_, we must ensure to tag.
This can be done by naming the branch `feature/<tag>` on **PR**; the **PR** will check the tag does not exist [here](.github/workflows/check-tag.yaml) and then automatically tag on **PR** closure [here](.github/workflows/auto-tagging.yaml).

To see all available tags we can run commands as such:

```bash
git tag  # shows all tags
git tag -l "*s3*"  # shows all tags containing 's3'
```

### Manual Tagging

We can tag our module after merging the **PR** can be done as follows:

```bash
git tag "TAG" && git push origin "TAG"
git tag -a "TAG" -m "<msg>"  # for annotated tags with commit message
```

We can commit code, tag, and then push the code and tags together by doing:

```bash
git commit -m "<commit-message>"
git tag -a "TAG" -m "<tag-message>"
git push origin HEAD --tags
```
