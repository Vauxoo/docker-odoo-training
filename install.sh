#!/bin/bash
echo """You can install this script running:
wget https://raw.githubusercontent.com/moylop260/docker-odoo-curso-basic/master/install.sh -O install.sh
chmod +x install.sh
sudo ./install.sh
"""

apt-get update
apt-get install -y python-pip libxml2-dev libxslt-dev libevent-dev \
    libsasl2-dev libldap2-dev python-lxml libjpeg-dev libsasl2-dev \
    libssl-dev python-dev tmux vim wkhtmltopdf git curl wget tmux unzip \
    locales tree sudo

# Configure locales
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen en_US.UTF-8
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
update-locale LANG=en_US.UTF-8
echo "LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 PYTHONIOENCODING=UTF-8" | tee -a /etc/bash.bashrc
source /etc/bash.bashrc

# Install after configure locales to auto-create cluster with UTF-8
apt-get install -y postgresql

pip install -U pip

/etc/init.d/postgresql start
useradd -d /home/myosusr -m -s /bin/bash -p myosurpwd myosusr

su - postgres -c "createuser -s odoo"

# Download odoo
su - myosusr -c "git clone --single-branch --depth=10 https://github.com/odoo/odoo.git odoo-repo"
# Install odoo dependencies
pip install -Ur /home/myosusr/odoo-repo/requirements.txt
apt-get install -y npm
ln -s /usr/bin/nodejs /usr/bin/node
npm install -g less
(cd /usr/bin && wget -qO- -t 1 --timeout=240 https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz | tar -xJ --strip-components=2 wkhtmltox/bin/wkhtmltopdf)

# configure vim IDE
curl http://j.mp/spf13-vim3 -L -o - | sh
su - myosusr -c "touch /home/myosusr/.vimrc"
echo -e """filetype plugin indent on
\" show existing tab with 4 spaces width
set tabstop=4
\" when indenting with '>', use 4 spaces width
set shiftwidth=4
\" On pressing tab, insert 4 spaces
set expandtab
""" > /home/myosusr/.vimrc
