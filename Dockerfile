# syntax=docker/dockerfile:1

FROM amazonlinux:2023.4.20240416.0
WORKDIR /

# OS - Install the necessary libraries and programs
RUN yum update -y

# PowerCenter - Install the necessary libraries and programs
RUN yum install -y e2fsprogs-libs.x86_64
RUN yum install -y keyutils-libs.x86_64
RUN yum install -y libsepol.x86_64
RUN yum install -y libselinux.x86_64
RUN yum install -y libidn.x86_64
RUN yum install -y libnsl.x86_64
RUN yum install -y libxcrypt-compat
#RUN yum install -y postgresql
RUN yum install -y which
RUN yum install -y shadow-utils
RUN yum install -y tar
RUN yum install -y util-linux
RUN yum install -y bc
RUN yum install -y hostname
RUN yum install -y net-tools
RUN yum install -y procps
#RUN yum install -y iputils-ping

# Set the environment variables for the root user
ENV POSTGRES_ODBC=1
ENV ODBCHOME=/apps/infa/105/ODBC7.1
ENV ODBCINI=/apps/infa/shared/config/odbc.ini
ENV Driver=/apps/infa/105/ODBC7.1/lib/DWpsql28.so
ENV LD_LIBRARY_PATH=/apps/infa/105/ODBC7.1/lib:/apps/infa/105/server/bin:/usr/lib64:/usr/lib:/usr/local/bin
ENV INFA_TRUSTSTORE=/apps/infa/keys
ENV INFA_TRUSTSTORE_PASSWORD=Qzp1rV9ivTA5X3WQ5Y2cmw==
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/apps/infa/105/ODBC7.1/bin
ENV LANG=C
ENV LC_ALL=C
ENV INFA_CODEPAGENAME=UTF-8
ENV INFA_LICENSE_NAME=10.5.3_License_cdipcapp_239758

# Create the service users
RUN useradd -m idmc
RUN usermod -a -G root idmc
RUN echo 'idmc:infa' | chpasswd

# Create the folder structure
RUN mkdir -p -m7777 /apps/infa/105/server/bin
RUN mkdir -m7777 /apps/infa/backup
RUN mkdir -m7777 /apps/infa/cdipc
RUN mkdir -m7777 /apps/infa/idmc
RUN mkdir -m7777 /apps/infa/keys
RUN mkdir -m7777 /apps/infa/licenses
RUN mkdir -p -m7777 /apps/infa/shared/tgt
RUN mkdir -m7777 /apps/infa/shared/src
RUN mkdir -m7777 /apps/infa/shared/config
RUN mkdir -m7777 /apps/infa/software
RUN mkdir -m7777 /apps/infa/scripts

# Update the folder owners
RUN chown -R idmc:root /apps/infa/idmc

# Copy the pre-requisite files
COPY licenses /apps/infa/licenses
COPY shared /apps/infa/shared
COPY keys /apps/infa/keys
COPY software/informatica_1053_server_linux-x64.tar /apps/infa/105/informatica_1053_server_linux-x64.tar
COPY software/informatica_cdi-pc_server_installer_linux64_*.tar /apps/infa/cdipc/informatica_cdi-pc_server_installer_linux64.tar
COPY software/agent64_install_ng_ext.*.bin /apps/infa/idmc/agent64_install_ng_ext.bin
COPY software/informatica_cdi-pc_tls_cert_utility_linux-x64_*.zip /apps/infa/software
COPY shared/config/odbc.ini /apps/infa/shared/config/odbc.ini
COPY scripts/init.sh /apps/infa/scripts/init.sh
COPY profiles/root/.bash_profile /root/.bash_profile

# Prepare the PowerCenter installation files
WORKDIR /apps/infa/105/server/bin
RUN ln -s /usr/lib64/libnsl.so.2  /apps/infa/105/server/bin/libnsl.so.1
RUN ln -s /usr/lib64/libidn.so.12 /usr/lib64/libidn.so.11
WORKDIR /apps/infa/105
RUN tar -xvf informatica_1053_server_linux-x64.tar
RUN rm -f informatica_1053_server_linux-x64.tar
RUN cp SilentInput.properties SilentInput.properties.backup
COPY shared/config/SilentInput_Default.properties /apps/infa/105/SilentInput.properties

# Prepare the CDI-PC installation files
WORKDIR /apps/infa/cdipc
RUN tar -xvf informatica_cdi-pc_server_installer_linux64.tar
RUN chown -R root /apps/infa/cdipc

# Install the OpenSSH server
RUN yum install -y openssh-server sudo
RUN echo 'root:root' | chpasswd
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -b 4096 -t rsa
COPY shared/config/sshd_config /etc/ssh/sshd_config

# Finishing Up
RUN chmod +x /apps/infa/scripts/init.sh
RUN chmod +x /apps/infa/idmc/agent64_install_ng_ext.bin
CMD ["/apps/infa/scripts/init.sh"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]