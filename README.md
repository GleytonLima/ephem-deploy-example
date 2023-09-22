# Steps to Build Ephem with Docker

## Build the Docker Image

```bash
docker build -t ephem .
```

## Manual Steps

```bash
sudo apt-get update
sudo apt-get upgrade -y

sudo adduser --system --home=/opt/odoo16 --group odoo16
sudo chown -R odoo16:odoo16 /opt/odoo16

sudo apt-get install -y python3-pip
sudo apt-get install python-dev python3-dev libxml2-dev libxslt1-dev zlib1g-dev libsasl2-dev libldap2-dev build-essential libssl-dev libffi-dev libmysqlclient-dev libjpeg-dev libjpeg8-dev liblcms2-dev libblas-dev libatlas-base-dev python3-venv

sudo apt-get install -y npm
# check version
sudo ln -s /usr/bin/nodejs /usr/bin/node
sudo npm install -g less less-plugin-clean-css
sudo apt-get install -y node-less

# install postgresql
sudo apt-get install postgresql -y
sudo su - postgres
createuser --createdb --username postgres --no-createrole --no-superuser --pwprompt odoo16
# after define de password
psql
ALTER USER odoo16 WITH SUPERUSER;
exit

# install git
apt-get install git -y

sudo su - odoo16 -s /bin/bash
git clone https://www.github.com/odoo/odoo --depth 1 --branch 16.0 --single-branch /opt/odoo16/odoo

# instal dependencies
python3 -m venv odoo-venv
source odoo-venv/bin/activate
pip3 install wheel
pip3 install -r odoo/requirements.txt

# create a ssh key pair to download ephem project. pass the public key to the project owner to add to the repository
ssh-keygen -t ed25519 -C "youremail@example.com"
cat ~/.ssh/id_ed25519.pub
```
