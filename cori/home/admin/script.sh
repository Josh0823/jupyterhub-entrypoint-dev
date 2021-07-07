#!/bin/bash

# Example for what a startup script could look like

module load mypackage
module load anotherpackage
cd /a/directory/somewhere
source venv/bin/activate

cd $HOME
