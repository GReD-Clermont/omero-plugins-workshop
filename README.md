# i2k-2022-workshop

This repository contains the scripts used for the I2K 2022 workshop "Batch processing images from OMERO in Fiji" as well as the initial Docker configuration to set up OMERO locally, with parade-crossfilter included.

Sample images should normally be available from the release page.


## Setup

If you do not have access to an OMERO server, you can use the provided Docker configuration to start an instance on your computer.
For this, you would first need to get [Docker](https://www.docker.com/products/docker-desktop/).

Once it is installed, you then have to open a terminal in the "0-docker" folder and type: 
```
docker compose up -d
```

A local server will start and will then be available on `localhost`:
* The OMERO.web interface should be accessible at: http://localhost:4080
* By default, the password for `root` is `omero`.
* You can add a normal group and a normal user, if you wish, through the admin interface: http://localhost:4080/webadmin/
