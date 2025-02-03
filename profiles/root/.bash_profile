# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs
export POSTGRES_ODBC=1
export ODBCHOME=/apps/infa/105/ODBC7.1
export ODBCINI=/apps/infa/shared/config/odbc.ini
export Driver=/apps/infa/105/ODBC7.1/lib/DWpsql28.so
export LD_LIBRARY_PATH=/apps/infa/105/ODBC7.1/lib:/apps/infa/105/server/bin:/usr/lib64:/usr/lib:/usr/local/bin
export INFA_TRUSTSTORE=/apps/infa/keys
export INFA_TRUSTSTORE_PASSWORD=Qzp1rV9ivTA5X3WQ5Y2cmw==
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/apps/infa/105/ODBC7.1/bin
export LANG=C
export LC_ALL=C
export INFA_CODEPAGENAME=UTF-8
export INFA_LICENSE_NAME=10.5.3_License_cdipcapp_239758