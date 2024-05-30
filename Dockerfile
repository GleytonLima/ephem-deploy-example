FROM ubuntu:22.04

# install git
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y git
RUN apt-get install -y python3
RUN apt-get install -y libpq-dev python3-dev libxml2-dev libxslt1-dev zlib1g-dev libsasl2-dev libldap2-dev build-essential libssl-dev libffi-dev libmysqlclient-dev libjpeg-dev libjpeg8-dev liblcms2-dev libblas-dev libatlas-base-dev python3-venv
RUN apt-get install -y python3-pip
RUN apt-get install -y nano
RUN apt-get install -y postgresql-client

ENV HOME=/root
# You need your private key and public key in the same folder as this Dockerfile
COPY ssh_keys/id_ed25519 ssh_keys/id_ed25519.pub $HOME/.ssh/
RUN chmod 600 $HOME/.ssh/id_ed25519 && \
    chmod 644 $HOME/.ssh/id_ed25519.pub

RUN sed -i 's/\r$//' $HOME/.ssh/id_ed25519
RUN sed -i 's/\r$//' $HOME/.ssh/id_ed25519.pub
ARG SSH_KEY_PASSWORD
ENV SSH_KEY_PASSWORD=$SSH_KEY_PASSWORD

RUN ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# Clone odoo16
RUN git clone https://www.github.com/odoo/odoo --depth 1 --branch 16.0 --single-branch $HOME/odoo

RUN pip install --upgrade pip setuptools
RUN pip install wheel
RUN pip install -r $HOME/odoo/requirements.txt

# Install wkhtmltopdf for pdf upload
RUN apt-get -y install wget
RUN wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_amd64.deb
RUN dpkg -i libssl1.1_1.1.0g-2ubuntu4_amd64.deb

RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
RUN apt install -y ./wkhtmltox_0.12.5-1.bionic_amd64.deb

RUN eval `ssh-agent -s` && \
    echo $SSH_KEY_PASSWORD | SSH_ASKPASS=/bin/cat setsid -w ssh-add && \
    git clone git@github.com:borse/PHERM-odoo13---custom-addons.git --depth 1 --branch 16_national_dev --single-branch $HOME/odca

WORKDIR $HOME

