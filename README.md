# Terraform Modules

This repository contains **terraform** modules for use within **IAC** deployments.

- [Prerequisites](#prerequisites)


## Prerequisites

This repository depends on the following requirements:
- [Python](https://www.python.org) of version `>=3.13` for code execution;
- [uv](https://docs.astral.sh/uv/) for **Python** package management;
- [Terraform](https://developer.hashicorp.com/terraform) installation, currently of version `1.14.3` (can be installed with `brew install` on **MacOS**);
- [Terraform-docs](https://terraform-docs.io) installation, for automated module documentation (can be installed with `brew install terraform-docs`).

To install the `pre-commit` checks we need to install **Python** then run the following:

```bash
uv venv  # create the virtual environment
uv sync  # sync dependencies (i.e. install pre-commit)
pre-commit install  # setup pre-commit
```

Then before every commit, the **terraform** _modules_ and _code_ will be automatically formatted and the **terraform** _module documentation_ will also automatically update.
This is defined within the [pre-commit-config](.pre-commit-config.yaml) configuration file.
