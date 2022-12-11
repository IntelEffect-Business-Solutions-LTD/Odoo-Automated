#!/bin/bash

# Update apt-get
sudo apt-get update

# Install dependencies
sudo apt-get install git python3-pip build-essential wget python3-dev python3-venv python3-wheel libxslt-dev libzip-dev libldap2-dev libsasl2-dev python3-setuptools node-less libxml2-dev

# Create a new user for Odoo
sudo adduser --system --home=/opt/odoo --group odoo

# Create a directory for the Odoo installation
sudo mkdir /opt/odoo/odoo-server

# Clone the Odoo repository
sudo git clone https://www.github.com/odoo/odoo --depth 1 --branch 13.0 /opt/odoo/odoo-server

# Create a virtual environment for the Odoo installation
sudo python3 -m venv /opt/odoo/odoo-server-venv

# Activate the virtual environment
source /opt/odoo/odoo-server-venv/bin/activate

# Install the requirements for Odoo
pip3 install -r /opt/odoo/odoo-server/requirements.txt

# Deactivate the virtual environment
deactivate

# Create a new directory for the custom addons
sudo mkdir /opt/odoo/odoo-server/custom-addons

# Add the custom addons directory to the Odoo configuration
echo '' >> /opt/odoo/odoo-server/odoo.conf
echo '[options]' >> /opt/odoo/odoo-server/odoo.conf
echo 'addons_path = /opt/odoo/odoo-server/custom-addons,/opt/odoo/odoo-server/odoo/addons' >> /opt/odoo/odoo-server/odoo.conf

# Give the odoo user permission to access the directories
sudo chown -R odoo: /opt/odoo/

# Create a new system service for Odoo
sudo touch /etc/systemd/system/odoo.service

# Edit the system service file
sudo nano /etc/systemd/system/odoo.service
