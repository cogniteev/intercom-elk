`Intercom ELK` is a starting block using docker and an ELK stack to analyze your Intercom data.

### How to use it?

1. Fork this repository
1. Add your application configuration
1. Launch it!

### Logstash

Add your configuration files in the `./logstash` directory. Logstash files
may have the `.conf` extension. You can also add your patterns or any other
files. Just keep in mind that they will be stored in the `/etc/logstash/`
directory.

A default configuration is provided to retrieve all users and events from
Intercom. You just need to provide your application name and API key.

### Kibana configuration

The `./kibana-config` allows you to deploy a Kibana configuration the first
time you application is launched.
To do that, simply put an
[Elasticdump](https://www.npmjs.com/package/elasticdump) json export
of the *.kibana* Elasticsearch index in this directory. Json files must have
the following names:

* `./kibana-config/mapping.json`
* `./kibana-config/data.json`

If files are missing, Kibana will simply start with an empty configuration.
You can then prepare your application by creating your *saved searchs*,
*virtualizations*, and *dashboards*, and then export the configuration to Json
with the following utility:

```shell
$ scripts/export-kibana-config
```

The script leverages [*quay.io/cogniteev/elk-export-es-index*](https://quay.io/repository/cogniteev/elk-export-es-index) Docker image to export
*.kibana* index in a container under JSON format. Then it uses
`docker cp` commands to retrieve the JSON files back to your workstation.

Note: the Elasticsearch container of your application must be running.

### Available *Makefile* targets

#### env

Writes to standard output a helpful bourne-shell alias definition that
encapsulates several arguments that need to be passed to Docker Compose.

```shell
$ make env
alias dc-elk="docker-compose -p 'intercomelk' -f 'standard.yml'"
```

You may use the following command to define it in your shell:

```shell
$ eval "$(make env)"
$ type dc-elk
dc-elk is aliased to `docker-compose -p 'intercomelk' -f 'standard.yml''
```

#### pull

Retrieves latest version of all Docker images used by this Docker Compose application.

#### up

Run containers in the background. Equivalent to `docker-compose up -d`

### wait

Wait for the *kibana* container to stop.

### Available *Makefile* options

Here are the environment variables that can be passed to `make` to customize
default behavior.

Name | Default | Description
-----|---------|------------
ELK_APP | intercomelk | Docker containers prefix
ELK_CONFIG | standard.yml | path to docker-compose input file
DOCKER_COMPOSE | docker-compose | path to docker-compose executable

### License

`Intercom ELK` is licensed under the Apache License, Version 2.0. See
[LICENSE](LICENSE) file for full license text.