FROM ubuntu:16.04
ADD install.sh /install.sh
RUN /install.sh && \
        rm -rf /tmp/* && \
        find /var/tmp -type f -print0 | xargs -0r rm -rf && \
        find /var/log -type f -print0 | xargs -0r rm -rf && \
        find /var/lib/apt/lists -type f -print0 | xargs -0r rm -rf && \
        echo 'odoo ALL=NOPASSWD: ALL' >> /etc/sudoers

USER odoo
RUN git --git-dir=/home/odoo/odoo/.git gc
