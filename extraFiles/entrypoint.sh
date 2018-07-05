#!/bin/bash
# Start service so we can create GC2 system tables and users.
supervisord -n -c /etc/supervisord.conf