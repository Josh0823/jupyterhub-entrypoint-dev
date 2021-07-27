# JupyterHub Entrypoint Service

This is a development environment for the <a href="https://github.com/Josh0823/jupyterhub-entrypoint">jupyterhub-entrypoint service</a>. It consists of numerous docker containers that talk to one another to simulate NERSC's deployment of JupyterHub.

The following containers are included
- hub: container that runs JupyterHub. Manages all services
- jupyterhub-entrypoint: container that runs the jupyterhub-entrypoint service, exists a seperate repo
- cori & perlmutter: containers used to mimic the Cori and Perlmutter systems at NERSC. Used to test validation for conda and script paths via ssh
- shifter: container used to represent the shifter API at NERSC. Manages list of available shifter images for user

## Requirements

- jupyterhub
- jinja2
- tornado
- aiocache
- asyncssh

## Installation
To use the development environment do the following:

    # Clone the docker setup to local
    git clone https://github.com/NERSC/jupyterhub-entrypoint-dev.git
    cd jupyterhub-entrypoint-dev
    # Clone the entrypoint service source code to local
    git clone https://github.com/NERSC/jupyterhub-entrypoint.git
    # Build the images and run the docker setup
    sh ./build.sh
    docker compose up
