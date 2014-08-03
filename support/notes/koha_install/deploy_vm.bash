#! /bin/bash

if [ -z $hostname ]
then
    echo "\$hostname must be set (note: \$hostname and \$HOSTNAME are different.)"
    exit
fi
sudo su -c "echo $hostname > /etc/hostname"

sudo apt-get install vim

### Modify .bashrc
if ! grep -q "KOHA INSTALL MODIFICATIONS" .bashrc
then

cat >> $HOME/.bashrc <<BASHRC
# KOHA INSTALL MODIFICATIONS
set -o vi

# Koha variables
export KOHA_CONF_DIR=\$HOME/koha-dev
export KOHA_CONF_NAME=koha-conf.xml
export KOHA_CONF=\$KOHA_CONF_DIR/\$KOHA_CONF_NAME
export KOHA_GIT_DIR=kohaclone
export PERL5LIB=\$HOME/\$KOHA_GIT_DIR/lib
BASHRC
fi

source $HOME/.bashrc

### Add index data for Yaz and Zebra. If the following lines don't appear in /etc/apt/sources.list, add them:
#    # Index Data
#    deb http://ftp.indexdata.dk/debian squeeze main
#    deb-src http://ftp.indexdata.dk/debian squeeze main

# Then run 
# wget -O- http://ftp.indexdata.dk/debian/indexdata.asc | sudo apt-key add -
# sudo apt-get update


/sbin/ifconfig | grep 'inet\>'
# After reboot, run 
#    /sbin/ifconfig | grep 'inet\>' 
# to find ip address.
#
# Edit /etc/hosts on 'lousiville', add $hostname and ip address
# Edit /etc/hosts on vm, set up $hostname and ip address

# bywater current koha version


bywater_koha="v3.12.07"
cd kohaclone
git fetch --all
git checkout -b stable-${bywater_koha} ${bywater_koha}
sudo dpkg --set-selections < install_misc/debian.packages
sudo apt-get dselect-upgrade
mysqladmin -uroot create koha

# Wrap this in a loop, counting down a '$retries' variable. Fail with error if this doesn't work. Log failure.
# required_modules=$(perl koha_perl_deps.pl -m -u | grep 'Yes$' | awk '{ print $1}'); echo $required_modules; cpan $required_modules

# Wrap this in a loop, prompt user on every failure, asking if they want to keep trying to install; Log warning on failure.
# optional_modules=$(perl koha_perl_deps.pl -m -u | grep 'No$'  | awk '{ print $1}'); echo $optional_modules; cpan $optional_modules

# perl Makefile.PL
# make && make test && make install
cd -

sudo ln -s $KOHA_CONF_DIR/koha-httpd.conf /etc/apache2/sites-available/koha

# Add the following lines to /etc/apache2/ports.conf:
# Listen 80
# Listen 8080

# Add logic to fix hostname in ./koha-dev/etc/{koha-httpd.conf,koha-conf.xml}
sed -i "s/koha_template/$hostname/g" $KOHA_CONF_DIR/{koha-httpd.conf,koha-conf.xml}

sudo a2enmod rewrite deflate
sudo a2ensite koha
sudo apache2ctl restart


