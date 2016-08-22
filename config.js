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