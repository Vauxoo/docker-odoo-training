#!/bin/bash
echo """You can install this script running:
wget https://raw.githubusercontent.com/moylop260/docker-odoo-curso-basic/master/install.sh -O install.sh
chmod +x install.sh
sudo ./install.sh myusros  # Change 'myusros' to use your custom OS' user name
"""
export USER=$1

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
echo -e "export LANG=en_US.UTF-8\nexport LANGUAGE=en_US.UTF-8\nexport LC_ALL=en_US.UTF-8\nexport PYTHONIOENCODING=UTF-8" | tee -a /etc/bash.bashrc
source /etc/bash.bashrc

# Install after configure locales to auto-create cluster with UTF-8
apt-get install -y postgresql

pip install -U pip

/etc/init.d/postgresql start
useradd -d /home/${USER} -m -s /bin/bash -p ${USER}pwd ${USER}

su - postgres -c "createuser -s ${USER}"

# Download odoo
su - ${USER} -c "git clone --single-branch --depth=10 https://github.com/odoo/odoo.git odoo-repo"
# Install odoo dependencies
pip install -Ur /home/${USER}/odoo-repo/requirements.txt
apt-get install -y npm
ln -s /usr/bin/nodejs /usr/bin/node
npm install -g less
(cd /usr/bin && wget -qO- -t 1 --timeout=240 https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz | tar -xJ --strip-components=2 wkhtmltox/bin/wkhtmltopdf)

# tools
pip install -U bpython

# configure vim IDE
git clone --depth=1 --single-branch https://github.com/spf13/spf13-vim.git /tmp/spf13-vim
su - ${USER} -c "/tmp/spf13-vim/bootstrap.sh"
su - ${USER} -c "mkdir -p ~/.vim/spell"
su - ${USER} -c "wget -q http://ftp.vim.org/pub/vim/runtime/spell/es.utf-8.spl -O ~/.vim/spell/es.utf-8.spl"
echo -e """filetype plugin indent on
\" show existing tab with 4 spaces width
set tabstop=4
\" when indenting with '>', use 4 spaces width
set shiftwidth=4
\" On pressing tab, insert 4 spaces
set expandtab
colorscheme heliotrope
\" Disable pymode because show ImporError
let g:pymode=0
set spelllang=en,es
""" >> /home/${USER}/.vimrc
sed -i 's/ set mouse\=a/\"set mouse\=a/g' /home/${USER}/.vimrc
sed -i "s/let g:neocomplete#enable_at_startup = 1/let g:neocomplete#enable_at_startup = 0/g" /home/${USER}/.vimrc
