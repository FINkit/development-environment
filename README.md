# development-environment
A vagrant provisioned development environment using the [development-environment-base](https://github.com/FINkit/development-environment-base) box.

## Prerequisites
### Hardware
* 8GB RAM (16GB is recommended)
* 30GB disk space

### Software
* [Vagrant 1.9.5](https://releases.hashicorp.com/vagrant/1.9.5/)
* [Virtualbox 5.1.22](https://www.virtualbox.org/wiki/Download_Old_Builds_5_1) (newer versions do work, but we guarantee the version listed works)
* [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

_Note: Windows users will need to add the installation directory of Virtualbox to their `PATH` environment variable._

_Note: Windows 7 and Windows 8 users will need to [upgrade Powershell to 5.1](https://www.microsoft.com/en-us/download/details.aspx?id=54616) if you use a version of Vagrant greater than 1.9.5._

## Getting started
1. Clone this repository with:
  ```git clone https://github.com/FINkit/development-environment```
2. Change into the `development-environment` directory and run:
  ```vagrant up```

You will be asked a series of questions about what config you want to give your environment. These are stored in a local `.env` file, which can be edited later (or deleted if you want re-prompting).
