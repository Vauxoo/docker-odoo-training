FROM ubuntu:16.04
ADD install.sh /install.sh
RUN /install.sh myosusr && \
        rm -rf /tmp/* && \
        find /var/tmp -type f -print0 | xargs -0r rm -rf && \
        find /var/log -type f -print0 | xargs -0r rm -rf && \
        find /var/lib/apt/lists -type f -print0 | xargs -0r rm -rf && \
        echo 'myosusr ALL=NOPASSWD: ALL' >> /etc/sudoers

USER myosusr
WORKDIR /home/myosusr
RUN git --git-dir=/home/myosusr/odoo-repo/.git gc --aggressive
# Testing
RUN sudo /etc/init.d/postgresql start && \
    /home/myosusr/odoo-repo/odoo-bin --stop-after-init
ADD extraFiles/entrypoint.sh /usr/local/bin/entrypoint.sh
ADD extraFiles/supervisor.conf /etc/supervisord.conf
RUN sudo chmod +x /usr/local/bin/entrypoint.sh

RUN sudo easy_install supervisor
RUN ls -al /usr/local/bin/entrypoint.sh

EXPOSE 22 8069

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]