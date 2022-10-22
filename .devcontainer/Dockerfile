FROM mariadb:10.6.4-focal
LABEL maintainer="modamod <modhaffer.rahmani@gmail.com>"

# No need to add `apt-get clean` here, reference:
# - https://github.com/snipe/snipe-it/pull/9201
# - https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#apt-get

RUN export DEBIAN_FRONTEND=noninteractive; \
    export DEBCONF_NONINTERACTIVE_SEEN=true; \
    echo 'tzdata tzdata/Areas select Etc' | debconf-set-selections; \
    echo 'tzdata tzdata/Zones/Etc select UTC' | debconf-set-selections; \
    apt-get update -qqy \
 && apt-get install -qqy --no-install-recommends \
apt-utils \
apache2 \
apache2-bin \
libapache2-mod-php7.4 \
php7.4-curl \
php7.4-ldap \
php7.4-mysql \
php7.4-gd \
php7.4-xml \
php7.4-mbstring \
php7.4-zip \
php7.4-bcmath \
php7.4-redis \
patch \
curl \
wget  \
vim \
git \
cron \
mysql-client \
supervisor \
cron \
gcc \
make \
autoconf \
libc-dev \
pkg-config \
libmcrypt-dev \
php7.4-dev \
ca-certificates \
unzip \
dnsutils \
mariadb-server \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN curl -L -O https://github.com/pear/pearweb_phars/raw/master/go-pear.phar
RUN php go-pear.phar

RUN pecl install mcrypt-1.0.3

RUN bash -c "echo extension=/usr/lib/php/20190902/mcrypt.so > /etc/php/7.4/mods-available/mcrypt.ini"

RUN phpenmod mcrypt
RUN phpenmod gd
RUN phpenmod bcmath
