FROM php:7.3.2-apache 

WORKDIR /var/www/app

# Config
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ./install_drupal.sh /var/www/install_drupal.sh

# Requirements
RUN apt-get update && apt-get install -y libzip-dev zip libpng-dev libmcrypt-dev git
RUN usermod -u 1000 www-data

RUN docker-php-ext-configure zip --with-libzip
RUN docker-php-ext-install mysqli mbstring gd zip pdo pdo_mysql opcache

# mcrypt
RUN pecl install mcrypt-1.0.2
RUN docker-php-ext-enable mcrypt

# xdebug
RUN pecl install xdebug-beta
RUN docker-php-ext-enable xdebug
#RUN echo 'zend_extension="/usr/local/lib/php/extensions/no-debug-non-zts-20180731/xdebug.so"' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.remote_port=9000' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.remote_enable=1' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.remote_connect_back=1' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.idekey="PHPSTORM"' >> /usr/local/etc/php/php.ini

# Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php
RUN mv composer.phar /usr/bin/composer
RUN chmod +x /usr/bin/composer
RUN php -r "unlink('composer-setup.php');"

# Drupal Console Launcher
RUN curl https://drupalconsole.com/installer -L -o drupal.phar
RUN mv drupal.phar /usr/bin/drupal
RUN chmod +x /usr/bin/drupal

# Drush Launcher
RUN curl -OL https://github.com/drush-ops/drush-launcher/releases/download/0.6.0/drush.phar
RUN chmod +x drush.phar
RUN mv drush.phar /usr/bin/drush

# Apache stuff
RUN apt-get install apache2-utils
RUN a2enmod rewrite

# Drupal
RUN chmod +x /var/www/install_drupal.sh

RUN chown -R www-data:www-data /var/www
RUN chmod -R g+s /var/www
RUN chmod -R u+s /var/www

