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
$ git clone https://github.com/intersystems-ib/workshop-dicom-orthanc
$ cd workshop-dicom-orthanc
$ docker-compose build
```

Then, open the `workshop-dicom-orthanc` in your VS Code.

In order to deploy docker containers you only need to execute the following command from your terminal/console:

```console
$ docker-compose up -d
```

# ORTHANC

Orthanc is an open source and standalone DICOM server. Orthanc aims at providing a simple, yet powerful standalone DICOM server. It is designed to improve the DICOM flows in hospitals and to support research about the automated analysis of medical images. Orthanc lets its users focus on the content of the DICOM files, hiding the complexity of the DICOM format and of the DICOM protocol.

The Orthanc container is configured by orthanc.json file in which is defined the user and password (demo/demo-pwd) for the web application and the data for all available modalities (in this case just IRIS for Health instance).

# Configuration

After the Docker deployment you'll find one IRIS for Health instance running with the name IRIS and an ORTHANC instance. The deployment of the containers will configure a DICOM namespace with a fully functional production configured to work with DICOM files and ORTHANC by default.
You will find in /shared/durable/in folder some DICOM files that you can use to test the production

The applications are accessible from the following routes: 

* [IRIS for Health Management Portal](http://localhost:52773/csp/sys/UtilHome.csp)
* [ORTHANC instance](http://localhost:8282)

The production configured by default has 2 different Business Services:

* EnsLib.DICOM.Service.File: gets all the files available in /shared/durable/in folder and resend it to Workshop.DICOM.Production.StorageFile to resend it to Orthanc by TCP.
* EnsLib.DICOM.Service.TCP: receives all DICOM files sent by TCP calls from Orthanc and redirect it to Demo.DICOM.Process.StorageLocal to save it in a file into /shared/durable/repository folder. 
