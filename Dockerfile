FROM ubuntu:16.04
ADD install.sh /install.sh
RUN /install.sh
