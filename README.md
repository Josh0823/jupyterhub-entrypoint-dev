# JupyterHub Entrypoint Service

This is a custom entrypoint service for JupyterHub that maintains a registry 
of entrypoints to launch Jupyter notebooks in through a REST API. Users can
add new entrypoints such as conda envs or make their own through bash scripts,
and then add these entrypoints to the registry. This allows WrapSpawners to 
query the user's preference and launch in that particular environment by
including a pre-launch hook.

Originally developed for use at NERSC.

## Requirements

- jupyterhub
- jinja2
- tornado

#### Optional dependencies (for NERSC use)
- aiocache
- asyncssh

## Installation
To use the development environment do the following:

    git clone https://github.com/Josh0823/jupyterhub-entrypoint-dev
    cd jupyterhub-entrypoint-dev
    sh ./build.sh
    docker compose up
