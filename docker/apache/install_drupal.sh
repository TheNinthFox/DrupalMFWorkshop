#!/bin/bash

if [ -e /var/www/app/composer.json ]; then
	echo "Drupal installation exists already";
else
	composer create-project drupal-composer/drupal-project:8.x-dev /var/www/app --no-interaction;
fi
