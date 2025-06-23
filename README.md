# STEW: Secure Template Enforcement for Windows

**STEW** is a standalone [Chef](https://www.chef.io/) cookbook designed to automate the hardening of Windows Server 2022 systems in alignment with [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks). It helps enforce secure baseline settings using code, making compliance simple, repeatable, and testable.

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
