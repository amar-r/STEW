# STEW Cookbook

Secure Template Enforcement for Windows (STEW) is a Chef cookbook for applying CIS-aligned hardening to Windows Server 2022. It configures password policies, audit policies, and disables insecure services using Chef resources.

## Features
- Password policy enforcement
- Audit policy configuration
- Disabling insecure Windows services
- Modular, attribute-driven design

## CIS Alignment
This cookbook implements a subset of CIS Microsoft Windows Server 2022 Benchmark recommendations. Review and adjust attributes as needed for your environment.

## Usage
1. Clone this repo and install [Vagrant](https://www.vagrantup.com/) and [Test Kitchen](https://kitchen.ci/).
2. Run `kitchen converge` to apply the hardening to a Windows Server 2022 VM.
3. Adjust attributes in `attributes/default.rb` as needed.

## Local Testing
```
kitchen test
```

## Requirements
- Vagrant
- kitchen-vagrant
- ChefDK or Chef Workstation

## License
MIT
