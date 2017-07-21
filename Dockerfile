FROM ubuntu:16.04
ADD install.sh /install.sh
RUN /install.sh && \
        rm -rf /tmp/* && \
        find /var/tmp -type f -print0 | xargs -0r rm -rf && \
        find /var/log -type f -print0 | xargs -0r rm -rf && \
        find /var/lib/apt/lists -type f -print0 | xargs -0r rm -rf && \
        echo 'odoo ALL=NOPASSWD: ALL' >> /etc/sudoers

USER odoo
RUN git init odoo-repo && \
        git --git-dir=~/odoo-repo/.git remote add origin https://github.com/odoo/odoo.git && \
        git --git-dir=~/odoo-repo/.git fetch master --depth=1 && \
        git --git-dir=~/odoo-repo/.git fetch 10.0 --depth=1 && \
        git --git-dir=/home/odoo/odoo/.git gc gc --aggressive
