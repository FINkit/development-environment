# development-environment
A vagrant provisioned development environment using the [development-environment-base](https://github.com/FINkit/development-environment-base) box.

This will install:
* Intellij Community Edition
* Spring Tool Suite
* Maven
* Cloud Foundry CLI
* BOSH 2.0 CLI
* and a number of other supporting development tools.

For full details of the tooling and versions provided with this environment please refer to [the parent ansible playbook](https://github.com/FINkit/development-environment-base/blob/master/ansible/main.yml) as well as the [developer packages playbook](https://github.com/FINkit/development-environment-base/blob/master/ansible/roles/developer_packages/tasks/main.yml).

## Prerequisites
### Minimum Hardware
* 8GB RAM (by default 4GB is allocated to the VM, see [Getting Started](#getting-started) to increase this)
* 20GB disk space

### Software
* [Vagrant 1.9.5](https://releases.hashicorp.com/vagrant/1.9.5/) - Windows 7 & 8 users see [known issues](#known-issues)
* [Virtualbox 5.1.22](https://www.virtualbox.org/wiki/Download_Old_Builds_5_1) (newer versions do work, but we guarantee the version listed works)
* [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

## Getting Started
1. Clone this repository with:
  ```git clone https://github.com/FINkit/development-environment```
2. Change into the `development-environment` directory and run:
  ```vagrant up```

## IMPORTANT	
When the UI loads you will be prompted for a password. Please wait for the entire provisioning process to complete before entering the password. You will be notified in the terminal window when you can login.

The username and password for the development environment are `vagrant:vagrant`.

## Customising the hardware requirements
The following environment variables can be set to tune the development environment.

| Variable | What for | Default |
| -------- | -------- | ------- |
| `DEVENV_PROCESSORS` | How many CPU cores to allocate | 2 |
| `DEVENV_CPUEXECUTIONCAP` | The amount of time (as %) a host CPU spends to emulate a virtual CPU | 100 |
| `DEVENV_MEMORY` | How much memory, in MB, to allocate | 4096 |

## Known Issues

Vagrant `1.9.7` and newer on Windows 7 & Windows 8 hangs. This is a [bug with Vagrant](https://github.com/hashicorp/vagrant/issues/8783) which is not being fixed, and cannot be addressed by any Vagrant image.

Windows 7 and Windows 8 users will need to [upgrade Powershell to 5.1](https://www.microsoft.com/en-us/download/details.aspx?id=54616) if you use a version of Vagrant greater than `1.9.6`.
