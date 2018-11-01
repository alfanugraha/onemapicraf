sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 51716619E084DAB9
sudo add-apt-repository ppa:openjdk-r/ppa
deb http://cran.rstudio.com/bin/linux/ubuntu trusty/

nano /etc/apt/sources.list.d/pgdg.list
deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
sudo add-apt-repository -y ppa:ubuntugis/ppa
    
  sudo apt-get update




sudo apt-get install libcurl4-openssl-dev libxml2 libxml2-dev
sudo apt-get install r-base python-dev python-virtualenv git-core 
sudo apt-get install postgresql-9.5 postgresql-server-dev-9.5
sudo apt-get install postgis postgresql-9.5-postgis-2.3
sudo apt-get install git subversion mercurial libxslt1.1 libxslt-dev gcc g++
  
# Setting tomcat
sudo apt-get install openjdk-8-jdk
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$PATH:/usr/lib/jvm/java-8-openjdk-amd64/bin

sudo apt-get install libxalan-c111 xalan unzip policycoreutils apache2 libtidy-0.99-0 libtidy-dev python-gdal libapache2-mod-wsgi mc
sudo apt-get install apt-get install libgdal-dev libevent-dev python-dev build-essential 

ufw enable
ufw allow 8080
ufw allow 3838

sudo pip install uwsgi psycopg2 owslib
apt-get install uwsgi-pugin-python

# install shiny server
$ sudo apt-get install gdebi-core
$ wget https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.7.907-amd64.deb
$ sudo gdebi shiny-server-1.5.7.907-amd64.deb
install library to ~/R/x86_64-pc-linux-gnu-library/3.4


dpkg -l | grep postgres
sudo apt-get --purge remove postgresql-10 postgresql-10-postgis-2.4 postgresql-10-postgis-2.4-scripts postgresql-client-10
/etc/postgresql/9.5/main/postgresql.conf
/etc/postgresql/9.5/main/pg_hba.conf

su - postgres
psql
\password postgres
sudo su - postgres -c "psql -d palapa -f /usr/share/postgresql/9.5/contrib/postgis-2.3/postgis.sql" > /dev/null 2
su postgres -c "psql -d palapa -f /usr/share/postgresql/9.5/contrib/postgis-2.3/spatial_ref_sys.sql" > /dev/null 2
su postgres -c "psql -d palapa -f /usr/share/postgresql/9.5/contrib/postgis-2.3/rtpostgis.sql" > /dev/null 2

sudo su - postgres -c "createdb -O palapa template_postgis_wraster -E utf-8"
su postgres -c "psql -d template_postgis_wraster -f /usr/share/postgresql/9.5/contrib/postgis-2.3/postgis.sql" > /dev/null 2
su postgres -c "psql -d template_postgis_wraster -f /usr/share/postgresql/9.5/contrib/postgis-2.3/spatial_ref_sys.sql" > /dev/null 2
su postgres -c "psql -d template_postgis_wraster -f /usr/share/postgresql/9.5/contrib/postgis-2.3/rtpostgis.sql" > /dev/null 2
su postgres -c "psql -d template_postgis_wraster -f /usr/share/postgresql/9.5/contrib/postgis-2.3/topology.sql" > /dev/null 2
su postgres -c "psql -d template_postgis_wraster -f /usr/share/postgresql/9.5/contrib/postgis-2.3/postgis_comments.sql" > /dev/null 2
su postgres -c "psql -d template_postgis_wraster -f /usr/share/postgresql/9.5/contrib/postgis-2.3/raster_comments.sql" > /dev/null 2
su postgres -c "psql -d template_postgis_wraster -f /usr/share/postgresql/9.5/contrib/postgis-2.3/topology_comments.sql" > /dev/null 2

su postgres -c "pg_restore -d palapa_dev /root/paket/kugi_09_12_16.tar" > /dev/null 2>&1
su postgres -c "pg_restore -d palapa_prod /root/paket/kugi_09_12_16.tar" > /dev/null 2>&1
su postgres -c "pg_restore -d palapa_pub /root/paket/kugi_09_12_16.tar" > /dev/null 2>&1
su postgres -c "pg_restore -d template_palapa /root/paket/kugi_09_12_16.tar" > /dev/null 2>&1
su postgres -c "pg_restore -d ADMIN_DEV /root/paket/kugi_09_12_16.tar" > /dev/null 2>&1
su postgres -c "pg_restore -d palapa /root/paket/palapa_init_v6.backup" > /dev/null 2>&1


pip install --ignore-installed six


/etc/apache2/sites-available/


# "Menseting GSPapala API daemon"
cp /opt/gspalapa-api/gs-api.service /etc/init.d
chmod 700 /etc/init.d/gs-api.service
update-rc.d gs-api.service defaults
update-rc.d gs-api.service enable
service --status-all
initctl reload-configuration


/lib/systemd/system/semua servis di sini



psql -d template_postgis_wraster -f /usr/share/postgresql/9.5/contrib/postgis-2.3/postgis.sql
psql -d template_postgis_wraster -f /usr/share/postgresql/9.5/contrib/postgis-2.3/spatial_ref_sys.sql
psql -d template_postgis_wraster -f /usr/share/postgresql/9.5/contrib/postgis-2.3/rtpostgis.sql
psql -d template_postgis_wraster -f /usr/share/postgresql/9.5/contrib/postgis-2.3/topology.sql
psql -d template_postgis_wraster -f /usr/share/postgresql/9.5/contrib/postgis-2.3/postgis_comments.sql
psql -d template_postgis_wraster -f /usr/share/postgresql/9.5/contrib/postgis-2.3/raster_comments.sql
psql -d template_postgis_wraster -f /usr/share/postgresql/9.5/contrib/postgis-2.3/topology_comments.sql

sudo su - postgres -c "createdb -O palapa -T template_postgis_wraster palapa_dev"
sudo su - postgres -c "createdb -O palapa -T template_postgis_wraster palapa_prod"
sudo su - postgres -c "createdb -O palapa -T template_postgis_wraster palapa_pub"
sudo su - postgres -c "createdb -O palapa -T template_postgis_wraster ADMIN"
sudo su - postgres -c "createdb -O palapa -T template_postgis_wraster ADMIN_DEV"
sudo su - postgres -c "createdb -O palapa -T template_postgis_wraster template_palapa"


sudo su - postgres -c "pg_restore -d palapa_dev /home/paket/kugi_09_12_16.tar" > /dev/null 2>&1
sudo su - postgres -c "pg_restore -d palapa_prod /home/paket/kugi_09_12_16.tar" > /dev/null 2>&1
sudo su - postgres -c "pg_restore -d palapa_pub /home/paket/kugi_09_12_16.tar" > /dev/null 2>&1
sudo su - postgres -c "pg_restore -d template_palapa /home/paket/kugi_09_12_16.tar" > /dev/null 2>&1
sudo su - postgres -c "pg_restore -d ADMIN_DEV /home/paket/kugi_09_12_16.tar" > /dev/null 2>&1
sudo su - postgres -c "pg_restore -d palapa /home/paket/palapa_init_v6.backup" > /dev/null 2>&1



/etc/apache2/sites-available
a2enmod headers
a2nsite pycsw.conf gspalapa.conf

# gs-api.service
setuid root
setgid root

start on runlevel [2345]
stop on runlevel [016]

chdir /opt/gspalapa-api

exec /usr/local/bin/uwsgi --thunder-lock --enable-threads --socket 0.0.0.0:8000 --protocol http



<filter>
<filter-name>CorsFilter</filter-name>
<filter-class>org.apache.catalina.filters.CorsFilter</filter-class>
<init-param>
<param-name>cors.allowed.origins</param-name>
<param-value>*</param-value>
</init-param>
</filter>
<filter-mapping>
<filter-name>CorsFilter</filter-name>
<url-pattern>/*</url-pattern>
</filter-mapping>