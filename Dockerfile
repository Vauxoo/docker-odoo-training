FROM ubuntu:16.04
ENV PYTHONIOENCODING=utf-8
ADD install.sh /install.sh
RUN /install.sh
