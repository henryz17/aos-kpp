#download ubuntu image
FROM --platform=linux/arm64 ubuntu:20.04

#LABELS
LABEL org.opencontainers.image.authors="support@atmos.ucla.edu"
LABEL version="1.1"
LABEL description="Kinetic Pre Processor 2.2.3 on Ubuntu 20.04"

#Update Ubuntu and disable prompts
#ARG DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt upgrade -y
RUN apt install -y dos2unix vim gfortran make gcc sed bison flex python
RUN apt clean

#Define Env variables
ENV KPP_HOME=/usr/local/kpp-2.2.3
ENV PATH="${PATH}:$KPP_HOME/bin"


COPY --chmod=0755 updatenrun.sh /usr/local/bin/updatenrun.sh
COPY kpp-2.2.3 /usr/local/kpp-2.2.3
WORKDIR /usr/local/kpp-2.2.3
RUN make clean
RUN make distclean
RUN make
RUN mv bin kpp
RUN mkdir bin
RUN mv kpp bin
WORKDIR /home
SHELL ["/bin/bash", "-c"]
