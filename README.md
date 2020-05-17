docker-symfony4
==============


This is a complete stack for running Symfony 4 (latest version: Flex) into Docker containers using docker-compose tool.

# Installation

First, make folder

```bash
$ mkdir my-project
```

Next, clone this repository:

```bash
$ cd my-project
$ git clone https://github.com/tpapic/docker-symfony4.git
```

Next, get symfony project

```bash
$ cd docker-symfony4
$ chmod +x get-symfony.sh
$ ./get-symfony.sh https://github.com/{YOUR_REPO_URL}.git
```

Then, run:

```bash
$ docker-compose up
```

_Note :_ you can execute composer install in php-fpm container

```bash
$ docker exec php-fpm composer install
```

You are done, you can visit your Symfony application on the following URL: `http://symfony.loc` (and access Kibana on `http://symfony.loc:81`)

####Folder structure
* my-project
    * docker-symfony4
    * YOUR_SYMFONY_PROJECT

_Note :_ you can rebuild all Docker images by running:

```bash
$ docker-compose build
```

# How it works?

Here are the `docker-compose` built images:

* `db`: This is the MySQL database container (can be changed to postgresql or whatever in `docker-compose.yml` file),
* `php`: This is the PHP-FPM container including the application volume mounted on,
* `nginx`: This is the Nginx webserver container in which php volumes are mounted too,
* `elasticsearch`: This is the Elasticsearch server used to store our web server and application logs,
* `logstash`: This is the Logstash tool from Elastic Stack that allows to read logs and send them into our Elasticsearch server,
* `kibana`: This is the Kibana UI that is used to render logs and create beautiful dashboards. 

This results in the following running containers:

```bash
> $ docker-compose ps
             Name                           Command               State                 Ports
-----------------------------------------------------------------------------------------------------------
mysql                            docker-entrypoint.sh --def ...   Up      0.0.0.0:3306->3306/tcp, 33060/tcp
elasticsearch                    /usr/local/bin/docker-entr ...   Up      0.0.0.0:9200->9200/tcp, 9300/tcp
kibana                           /usr/local/bin/dumb-init - ...   Up      0.0.0.0:81->5601/tcp
logstash                         /usr/local/bin/docker-entr ...   Up      5044/tcp, 9600/tcp
nginx                            nginx                            Up      443/tcp, 0.0.0.0:80->80/tcp
php-fpm                          php-fpm7 -F                      Up      0.0.0.0:9000->9001/tcp
```

# Read logs

You can access Nginx and Symfony application logs in the following directories on your host machine:

* `logs/nginx`
* `logs/symfony`

# Use Kibana!

You can also use Kibana to visualize Nginx & Symfony logs by visiting `http://symfony.loc:81`.

# Use xdebug!

Configure your IDE to use port 5902 for XDebug.
Docker versions below 18.03.1 don't support the Docker variable `host.docker.internal`.  
In that case you'd have to swap out `host.docker.internal` with your machine IP address in php-fpm/xdebug.ini.

# Code license

You are free to use the code in this repository under the terms of the 0-clause BSD license. LICENSE contains a copy of this license.
