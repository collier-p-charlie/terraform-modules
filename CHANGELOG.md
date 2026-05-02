# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

That is, given a version number `MAJOR.MINOR.PATCH`, increment the:

- **MAJOR** version when you make incompatible changes
- **MINOR** version when you add functionality in a backwards compatible manner
- **PATCH** version when you make backwards compatible bug fixes


## [1.2.0]() 2026-05-02

### Added
- AWS Secrets Manager module (`modules/aws/secretsmanager`) for creating a secret with configurable recovery window

## [1.1.1](https://github.com/collier-p-charlie/terraform-modules/compare/1.1.0...1.1.1) 2026-05-02

### Fixed
- AWS S3 module: replaced `versioning_enabled` (bool) with `versioning_status` (string enum: `Enabled`, `Suspended`, `Disabled`); `Disabled` skips the versioning resource entirely, preventing invalid `Suspended` state on bucket creation; default changed to `Enabled`

## [1.1.0]() 2026-05-02

### Added
- AWS S3 module (`modules/aws/s3`) for creating an S3 bucket with optional versioning, force-destroy support, and tag propagation

## [1.0.0]()

- Start of changelog.
