#!/usr/bin/env bash

wget_info=$(yum list | grep "wget")
if [ -z $wget_info];then
    yum install -y wget
fi

info() {
    printf "${blue}➜ %s${reset}\n" "$*"
}

error() {
    printf "${red}➜ %s${reset}\n" "$*"
}

download_package() {
    if [ -f $2/${1##*/} ]; then
        info "skip download ${1##*/}, because find cache in $2/${1##*/}"
    else
        info "Downloading: ${1##*/}"
        wget $1 -P $2
        info "Downloaded: $2/${1##*/}"
    fi
}

MYSQL_DOWNLOAD_DOMAIN="repo.mysql.com"
MYSQL_RPM_PACKAGE="mysql-community-release-el7-5.noarch.rpm"
CONF_FILE_DIR="$( cd "$( dirname "$0" )" && pwd )"
DOWNLOAD_TEMP_DIR="/tmp/cloudera_install"

download_package "http://${MYSQL_DOWNLOAD_DOMAIN}/${MYSQL_RPM_PACKAGE}" ${DOWNLOAD_TEMP_DIR}
# check download package
is_installed=$(rpm -qa | grep ${MYSQL_RPM_PACKAGE})

if [ -z ${is_installed} ]; then
    rpm -ivh ${DOWNLOAD_TEMP_DIR}/${MYSQL_RPM_PACKAGE}
else
    error "${MYSQL_RPM_PACKAGE} already installed!"
    info "Nothing to do"
    exit 1
fi

info "install mysql-server starting..."
yum -y install mysql-server
info "install mysql-server completed!"

cp -f ${CONF_FILE_DIR}/my.cnf /etc/my.cnf

info "mysql starting..."
systemctl start mysqld
info "mysql started!"

info "mysql config starting..."
# Enter current password for root (enter for none):
# OK, successfully used password, moving on...
# [...]
# Set root password? [Y/n] Y
# New password:
# Re-enter new password:
# Remove anonymous users? [Y/n] Y
# [...]
# Disallow root login remotely? [Y/n] N
# [...]
# Remove test database and access to it [Y/n] Y
# [...]
# Reload privilege tables now? [Y/n] Y
# All done!
echo -e "\nY\nroot\nroot\nY\nN\nY\nY\n" | /usr/bin/mysql_secure_installation
mysql -uroot -proot -e "source $CONF_FILE_DIR/recommend_config.sql"
info "mysql config completed!"

info "restart mysql..."
systemctl restart mysqld
info "mysql started!"

info "COMPLETED!"