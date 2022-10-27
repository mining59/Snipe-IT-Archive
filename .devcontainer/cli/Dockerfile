# From official php image.
FROM php:7.4-cli-alpine3.12
# Create a user group and account under id 1000.
RUN addgroup -g 1000 -S user && adduser -u 1000 -D user -G user
# Install quality-of-life packages.
RUN apk add --no-cache bash curl git vim npm
# Install composer for php deps.
RUN apk add --no-cache mysql
# Install redis driver.
RUN mkdir -p /usr/src/php/ext/redis; \
    curl -fsSL --ipv4 https://github.com/phpredis/phpredis/archive/5.3.4.tar.gz | tar xvz -C "/usr/src/php/ext/redis" --strip 1; \
    docker-php-ext-install redis
# Install nodejs and npm for frontend.
RUN apk add --no-cache nodejs npm
# Prevent container from exiting early.
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN npm install -g wait-port
COPY --from=mlocati/php-extension-installer:1.2.19 /usr/bin/install-php-extensions /usr/local/bin/
RUN set -eux; \
    install-php-extensions \
        bcmath \
        gd \
        ldap \
        mysqli \
        pdo_mysql \
        zip; \
    rm -f /usr/local/bin/install-php-extensions;

RUN apk add --no-cache  mysql-client
CMD ["sleep", "infinity"]
