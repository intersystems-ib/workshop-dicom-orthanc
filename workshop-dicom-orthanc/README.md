# DICOM with IRIS for Health and PACS
This repository contains the material required to deploy an IRIS for Health Community instance and a ORTHANC installation. DICOM files for demo purposes are included too. 

You can find more in-depth information in https://learning.intersystems.com.

# What do you need to install? 
* [Git](https://git-scm.com/downloads) 
* [Docker](https://www.docker.com/products/docker-desktop) (if you are using Windows, make sure you set your Docker installation to use "Linux containers").
* [Docker Compose](https://docs.docker.com/compose/install/)
* [Visual Studio Code](https://code.visualstudio.com/download) + [InterSystems ObjectScript VSCode Extension](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript)

# Setup
Build the image we will use during the workshop:

```console
$ git clone https://github.com/intersystems-ib/workshop-multple-instances
$ cd workshop-multiple-instances
$ docker-compose build
```

Then, open the `workshop-multiple-instances` in your VS Code.

In order to deploy docker containers you only need to execute the following command from your terminal/console:

```console
$ docker-compose up -d
```

# Configuration

After the Docker deployment you'll find two IRIS instances running with the names mirrorA and mirrorB. An Arbiter will be running too.
By default the deployment of the containers will install two applications (PHONEBOOK and COMPANY) for each IRIS instance. This applications will create three different namespaces (PERSONAL, CUSTOMER and PHONEBOOK) with their respective databases. With these databases you will be able to configure it to work in Mirror.

The applications are accessible from the following routes: 

* [Phonebook app in mirrorA](http://localhost:52775/csp/phonebook/Phonebook.AllStart.cls)
* [Company app in mirrorA](http://localhost:52775/csp/company/Company.csp)
* [Phonebook app in mirrorB](http://localhost:52776/csp/phonebook/Phonebook.AllStart.cls)
* [Company app in mirrorB](http://localhost:52775/csp/company/Company.csp)

From these applications you will be able to create new records for the databases and check how the mirror works, replicating the mirrored databases from mirrorA to mirrorB. You can refer to [IRIS documentation](https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=GHA_mirror_set_config) to get more information about mirroring.