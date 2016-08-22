#!/bin/bash

NAME=$1
URL=$2

echo "Starting directory creation... "

if [ ! -d "/ghost" ]; then
	mkdir /ghost
fi

if [ ! -d "/ghost/"$NAME ]; then
	mkdir /ghost/$NAME
fi

if [ ! -d "/ghost/"$NAME"/config" ]; then
	mkdir /ghost/$NAME/config
fi 

if [ ! -d "/ghost/"$NAME"/content" ]; then
	mkdir /ghost/$NAME/content
	mkdir /ghost/$NAME/content/themes
	mkdir /ghost/$NAME/content/themes/casper
	mkdir /ghost/$NAME/content/apps
	mkdir /ghost/$NAME/content/images
	mkdir /ghost/$NAME/content/data	
fi

echo "Directories created with sucess... "

echo "Creating config.js... "

echo "

var path = require('path'),  
    config;

config = {  
  production: {
    url: 'http://localhost:2368',
    mail: {},
    database: {
      client: 'sqlite3',
      connection: {
        filename: path.join('/usr/src/ghost/content/data/ghost.db')
      },
      debug: true
    },

    server: {
      host: '0.0.0.0',
      port: '2368'
    }
  }
};

module.exports = config;  

	 " > /ghost/$NAME/content/apps/config.js

echo "Config.js created with sucess... "

echo "Creating default theme"

wget https://github.com/godofredoninja/Mapache/archive/master.zip
unzip master.zip -d /ghost/$NAME/content/themes/casper
rm master.zip 

docker run -td --name $NAME -e VIRTUAL_HOST=$URL -v /ghost/$NAME/content/themes:/usr/src/ghost/content/themes -v /ghost/$NAME/content/apps:/usr/src/ghost/content/apps -v /ghost/$NAME/content/images:/usr/src/ghost/content/images -v /ghost/$NAME/content/data:/usr/src/ghost/content/data --restart=always -m 150M --memory-swap 300M ghost /bin/bash -c "npm start --production"

echo "Docker container $NAME created with sucess..."

echo "Configuring New Container"

docker exec $NAME cp /usr/src/ghost/content/apps/config.js /usr/src/ghost

docker ps -a