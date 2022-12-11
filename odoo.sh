#!/bin/bash

# Update the package list and upgrade the system
sudo apt update
sudo apt upgrade -y

# Install the necessary dependencies
sudo apt install -y python3 python3-pip postgresql

# Create a new user for the Odoo installation
sudo adduser --system --home=/opt/odoo --group odoo

# Install Odoo using pip
sudo -u odoo pip3 install odoo

# Create a new configuration file for Odoo
sudo tee /etc/odoo-server.conf <<EOF
[options]
; This is the password that allows database operations:
admin_passwd = admin
db_host = False
db_port = False
db_user = odoo
db_password = False
addons_path = /opt/odoo/addons
EOF

# Create a new systemd service file for Odoo
sudo tee /etc/systemd/system/odoo.service <<EOF
[Unit]
Description=Odoo
After=network.target

[Service]
Type=simple
SyslogIdentifier=odoo
PermissionsStartOnly=true
User=odoo
Group=odoo
ExecStart=/usr/local/bin/odoo-bin -c /etc/odoo-server.conf

[Install]
WantedBy=multi-user.target
EOF

# Start the Odoo service and enable it to start on boot
sudo systemctl start odoo
sudo systemctl enable odoo
