export APP_NAME=nhahv/bitnami-cassandra-lucene-index
export CONTAINER_NAME=$(subst /,-,$(APP_NAME))

ifeq ("$(wildcard $(/var/run/docker.sock))","")
	export DOCKER_HOST=tcp://127.0.0.1:2375
endif

.PHONY: build
ifdef repo
export DOCKER_REPO=${repo}
else
export DOCKER_REPO=docker.io
endif

ifdef tag
export TAG=${tag}
else
export TAG=latest
endif

build: ## Build the container
	@echo Building [${APP_NAME}:${TAG}]
	docker build -t ${APP_NAME}:${TAG} .

run: ## Run container on port configured in `config.env`
	docker run -i -t --rm  -p=9042:9042 -p=7000:7000 --name="${CONTAINER_NAME}" ${APP_NAME}

stop:
	@echo Stoping [${APP_NAME}:${TAG}] - Container Name: ${CONTAINER_NAME}
	docker stop ${CONTAINER_NAME}; docker rm ${CONTAINER_NAME}

push: _login _push-latest _push-version

_test:

	@echo ${DOCKER_REPO}

_login:
	@echo Login to repository [${DOCKER_REPO}]
	@docker login ${DOCKER_REPO}

_push-latest:
	@echo Create tag: [${APP_NAME}:${TAG}]
	docker tag ${APP_NAME} ${APP_NAME}:latest
	docker push ${APP_NAME}:latest



_push-version:


