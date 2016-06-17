`Intercom ELK` is a preconfigured ELK stack to analyze Intercom events of your app.

It is built with standard pillars such as ELK and docker.

### Getting started

#### Prerequisites

1. [Install Docker with Docker Compose](https://docs.docker.com/compose/install/)
1. TODO

#### Install

1. Clone this repository or download [master zip](https://github.com/cogniteev/intercom-elk/archive/master.zip)
1. Starts the `Intercom ELK` containers using Docker Compose: `docker-compose -p intercomelk -f docker-compose.yml up -d`
1. Visit [http://localhost:9000](http://localhost:9000) or `http://docker-host-ip:9000`. You should see the Intercom-ELK dashboard, but there is no data yet.

#### Import log files

TODO

#### Play

Go back to [http://localhost:9000](http://localhost:9000) or `http://docker-host-ip:9000`. You should have figures and graphs, __congrats !__

###### Output

In the ELK stack, the output of choice is elasticsearch.

Notice the `document_id` field that allows to push an event twice while still having only one entry in elasticsearch. Duplicated events are automatically de-duplicated for better consistency.

### Troubleshoot

 * __Connection refused to [http://localhost:9000](http://localhost:9000)__

 Check that the logstash web-client is started properly with kitematic, or with the command:

 ```docker-compose -p intercomelk -f docker-compose.yml ps```

If docker is running in a VM, which is the case on OS X and Windows, make sure to replace `localhost` with the ip of the VM running docker.

```docker-compose -p intercomelk -f docker-compose.yml ps```

You can issue a full restart with:

```shell
docker-compose -p intercomelk -f docker-compose.yml stop
docker-compose -p intercomelk -f docker-compose.yml up -d
```

If required, delete the docker containers once stopped with:
```shell
docker-compose -p intercomelk -f docker-compose.yml rm
```

### Purge

If you need to purge old logs, you can use [Elastic curator](https://www.elastic.co/guide/en/elasticsearch/client/curator/current/index.html) 

For instance to keep the most recent 100GB of logs:
```shell
docker run --rm --link intercomelk_elasticsearch_1:elasticsearch digitalwonderland/elasticsearch-curator --host elasticsearch -n delete --disk-space 100
```

### License

`OnCrawl ELK` is licensed under the Apache License, Version 2.0. See
[LICENSE](LICENSE) file for full license text.
