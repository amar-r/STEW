# STEW - Secure Template Enforcement for Windows

This is my learning project for Chef and CIS Windows Server 2022 hardening. I'm using this to understand how Chef works and how to apply security configurations programmatically.

## What is STEW?

STEW (Secure Template Enforcement for Windows) is a standalone Chef project focused on applying CIS-aligned Windows Server 2022 hardening settings using Chef cookbooks. This project demonstrates local Windows hardening automation using Chef without a Chef server.

## Project Structure

- `cookbooks/stew/` - The main Chef cookbook containing hardening recipes
- `.kitchen.yml` - Test Kitchen configuration for automated testing
- `Berksfile` - Chef dependency management
- `GETTING_STARTED.md` - Step-by-step guide for beginners

## Features

- Password policy enforcement (CIS 1.1.x)
- Account lockout policy (CIS 1.2.x)
- Audit policy configuration (CIS 17.x)
- Security options (CIS 2.x)
- Service hardening (CIS 3.x)
- User rights assignment (CIS 4.x)

## Learning Goals

- Understand Chef cookbook structure
- Learn how to apply CIS benchmarks programmatically
- Practice Windows security hardening
- Use Chef in local mode without a Chef server

## Quick Start

1. Install Chef Client on Windows Server 2022
2. Clone this repository
3. Run: `chef-client --local-mode --runlist 'recipe[stew::default]'`

See `GETTING_STARTED.md` for detailed instructions.

## License

MIT

---

## 🔧 Features

- Automates CIS Level 1 baseline enforcement
- Uses native Windows configuration (registry, audit policy)
- Standalone execution (no Chef Server required)
- Built-in support for [Test Kitchen](https://kitchen.ci/) and Vagrant
- Modular cookbook design for easy extension

---

## 📦 Requirements

- Vagrant with a Windows Server 2022 box (e.g., `gusztavvargadr/windows-server-2022-standard`)
- Chef Workstation
- VirtualBox or Hyper-V (for local testing)

---

## 🚀 Quick Start

```bash
git clone https://github.com/YOUR_USERNAME/STEW.git
cd STEW
kitchen create
kitchen converge
