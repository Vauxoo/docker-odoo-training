#!/bin/bash

apt-get update
apt-get install -y python-pip libxml2-dev libxslt-dev libevent-dev \
    libsasl2-dev libldap2-dev python-lxml libjpeg-dev libsasl2-dev \
    libssl-dev python-dev tmux vim wkhtmltopdf git curl wget tmux unzip \
    locales
locale-gen "en_US.UTF-8 es_ES.UTF-8"
update-locale LANG="en_US.UTF-8"
echo "LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 PYTHONIOENCODING=UTF-8" | tee -a /etc/bash.bashrc
source /etc/bash.bashrc
apt-get install -y postgresql

pip install -U pip

curl http://j.mp/spf13-vim3 -L -o - | sh

(cd /usr/bin && wget -qO- -t 1 --timeout=240 https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz | tar -xJ --strip-components=2 wkhtmltox/bin/wkhtmltopdf)

/etc/init.d/postgresql start
useradd -d /home/odoo -m -s /bin/bash -p odoopwd odoo

su - postgres -c "createuser -s odoo"

su - odoo -c "git clone https://github.com/odoo/odoo.git"
pip install -r /home/odoo/odoo/requirements.txt

apt-get install -y npm
ln -s /usr/bin/nodejs /usr/bin/node
npm install -g less
