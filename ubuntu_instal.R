sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 51716619E084DAB9
sudo add-apt-repository ppa:openjdk-r/ppa
deb http://cran.rstudio.com/bin/linux/ubuntu trusty/

nano /etc/apt/sources.list.d/pgdg.list
deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
    
  sudo apt-get update



sudo apt-get install libcurl4-openssl-dev libxml2 libxml2-dev
sudo apt-get install r-base python-dev python-virtualenv git-core 
sudo apt-get install postgresql-9.5
sudo apt-get install postgis postgresql-9.5-postgis-2.3
sudo apt-get install git subversion mercurial libxslt1.1 libxslt-dev gcc g++
  
# Setting tomcat
sudo apt-get install openjdk-8-jdk
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$PATH:/usr/lib/jvm/java-8-openjdk-amd64/bin

sudo apt-get install libxalan-c111 xalan unzip policycoreutils apache2 libtidy-0.99-0 libtidy-dev python-gdal libapache2-mod-wsgi mc
sudo apt-get install apt-get install libgdal-dev libevent-dev python-dev build-essential 
sudo apt-get install systemd firewalld

sudo pip install uwsgi psycopg2 owslib

# install shiny server
$ sudo apt-get install gdebi-core
$ wget https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.7.907-amd64.deb
$ sudo gdebi shiny-server-1.5.7.907-amd64.deb


dpkg -l | grep postgres
sudo apt-get --purge remove postgresql-10 postgresql-10-postgis-2.4 postgresql-10-postgis-2.4-scripts postgresql-client-10
/etc/postgresql/9.5/main/postgresql.conf
