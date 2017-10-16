# development-environment

## Overview
A vagrant provisioned development environment using the [development-environment-base](https://github.com/FINkit/development-environment-base) box, with the following pre-installed tools:

* [Apache Maven](https://maven.apache.org/), version 3.5.0
* [BOSH CLI](https://github.com/cloudfoundry/bosh-cli), version 2.0.43
* [Cloud Foundry CLI](https://docs.cloudfoundry.org/cf-cli/), version 6.32.0
* [Docker Compose](https://docs.docker.com/compose/), version 1.16.1
* [Git](https://git-scm.com/), version 2.14.2
* [Go](https://golang.org/), version 1.9.1
* [Gradle](https://gradle.org/), version 4.2.1
* [IntelliJ Community Edition](https://www.jetbrains.com/idea/), version 2017.2.5
* [Postman](https://www.getpostman.com/), version 5.3.0
* [Spring Tool Suite](https://spring.io/tools/sts),  3.9.0
* [Terraform CLI](https://www.terraform.io/), version 0.10.7

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

The username and password for the development environment are `vagrant:vagrant`.
