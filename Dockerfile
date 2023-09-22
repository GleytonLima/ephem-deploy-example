FROM ubuntu:22.04

# install git
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y git
RUN apt-get install -y python3
RUN apt-get install -y libpq-dev python3-dev libxml2-dev libxslt1-dev zlib1g-dev libsasl2-dev libldap2-dev build-essential libssl-dev libffi-dev libmysqlclient-dev libjpeg-dev libjpeg8-dev liblcms2-dev libblas-dev libatlas-base-dev python3-venv
RUN apt-get install -y python3-pip

# Create user "odoo16"
RUN adduser --system --home=/opt/odoo16 --group odoo16
RUN chown -R odoo16:odoo16 /opt/odoo16
RUN mkdir -p /opt/odoo16
RUN mkdir -p /opt/odoo16/.ssh
# You need your private key and public key in the same folder as this Dockerfile
COPY ssh_keys/id_rsa ssh_keys/id_rsa.pub /opt/odoo16/.ssh/
RUN chown -R odoo16:odoo16 /opt/odoo16
RUN chmod 600 /opt/odoo16/.ssh/id_rsa && \
    chmod 644 /opt/odoo16/.ssh/id_rsa.pub

USER odoo16

# Clone odoo16
RUN git clone https://www.github.com/odoo/odoo --depth 1 --branch 16.0 --single-branch /opt/odoo16/odoo

RUN pip install --upgrade pip setuptools
RUN pip install wheel
RUN pip install -r /opt/odoo16/odoo/requirements.txt


WORKDIR /opt/odoo16
