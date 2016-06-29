export ELK_APP ?= intercomelk
export ELK_CONFIG ?= docker-compose.dev.yml

DOCKER_COMPOSE ?= docker-compose
DOCKER ?= docker

EXTRA_IMAGES =                          \
	cogniteev/elk-kibana-config:1.0     \
	cogniteev/elk-logstash:1.0          \
	cogniteev/elk-export-es-index:1.0

build ps logs kill stop:
	@$(DOCKER_COMPOSE) -p $(ELK_APP) -f $(ELK_CONFIG) $@

env:
	@echo alias dc-$(ELK_APP)=\"$(DOCKER_COMPOSE) -p ''\''$(ELK_APP)'\''' -f ''\''$(PWD)/$(ELK_CONFIG)'\'''\"

pull:
	$(DOCKER_COMPOSE) -f $(ELK_CONFIG) pull

up:
	$(DOCKER_COMPOSE) -p $(ELK_APP) -f $(ELK_CONFIG) up -d

wait:
	$(DOCKER) wait `$(MAKE) ps | awk '{print $$1}' | tail -n +3 | grep "kibana_1$$"`
