.PHONY: help

help:
	@grep -E '^[a-zA-Z0-9._-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


#########################################
# Stacks Elastic
version := 7.16.3
elk-pull: ## Elastic - Pull all images from docker.elastic.co
	@docker pull docker.elastic.co/kibana/kibana:${version}
	@docker pull docker.elastic.co/elasticsearch/elasticsearch:${version}
	@docker pull docker.elastic.co/logstash/logstash-oss:${version}
	@docker pull docker.elastic.co/apm/apm-server-oss:${version}
	@docker pull docker.elastic.co/beats/auditbeat-oss:${version}
	@docker pull docker.elastic.co/beats/filebeat-oss:${version}
	@docker pull docker.elastic.co/beats/heartbeat-oss:${version}
	@docker pull docker.elastic.co/beats/metricbeat-oss:${version}
	@docker pull docker.elastic.co/beats/packetbeat-oss:${version}

elk-std-up: ## Elastic - Start base stack (Elasticsearch/Kibana)
	@cd elk/standard && VERSION=${version} docker compose up -d
elk-std-down: ## Elastic - Stop base stack (Elasticsearch/Kibana)
	@cd elk/standard && VERSION=${version} docker compose down

elk-clust-up: ## Elastic - Start clustered stack (Elasticsearch(x3)/Kibana)
	@cd elk/cluster && VERSION=${version} docker compose up -d
elk-clust-down: ## Elastic - Stop clustered stack (Elasticsearch(x3)/Kibana)
	@cd elk/cluster && VERSION=${version} docker compose down

elk-apm-up: ## Elastic - Start apm standalone stack (Elasticsearch/Kibana/APM)
	@cd elk/apm && VERSION=${version} docker compose up -d
elk-apm-down: ## Elastic - Stop apm standalone stack (Elasticsearch/Kibana/APM)
	@cd elk/apm && VERSION=${version} docker compose down
#########################################
