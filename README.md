# development-environment
A vagrant provisioned development environment using the [development-environment-base](https://github.com/FINkit/development-environment-base) box.

This will install:
* Intellij Community Edition
* Spring Tool Suite
* Eclipse
* Maven
* Cloud Foundry CLI
* BOSH 2.0 CLI
* and a number of other supporting development tools.

For full details of the tooling and versions provided with this environment please refer to https://github.com/FINkit/development-environment-base/blob/master/ansible/main.yml

## Prerequisites
### Hardware
* 8GB RAM (16GB is recommended)
* 30GB disk space

### Software
* [Vagrant 1.9.5](https://releases.hashicorp.com/vagrant/1.9.5/)
* [Virtualbox 5.1.22](https://www.virtualbox.org/wiki/Download_Old_Builds_5_1) (newer versions do work, but we guarantee the version listed works)
* [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

_Note: Windows users will need to add the installation directory of Virtualbox to their `PATH` environment variable. This is to ensure that versions of both Vagrant & Virtualbox applications are supported prior to starting the development environment._

_Note: Windows 7 and Windows 8 users will need to [upgrade Powershell to 5.1](https://www.microsoft.com/en-us/download/details.aspx?id=54616) if you use a version of Vagrant greater than 1.9.5._

## Getting started
1. Clone this repository with:
  ```git clone https://github.com/FINkit/development-environment```
2. Change into the `development-environment` directory and run:
  ```vagrant up```
3. Follow on screen instructions.

You will be asked a series of questions about what configuration you want to give your development environment. These are stored in a local `.env` file, which can be edited later (or deleted if you want re-prompting).

## IMPORTANT	
When the UI loads you will be prompted for a password. Please wait for the entire provisioning process to complete before entering the password. You will be notified in the terminal window when you can login.

The username and password for the development environment are `vagrant:vagrant`.
