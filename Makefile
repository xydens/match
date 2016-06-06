.PHONY: all build push run

DOCKER_TAG ?= pavlov/match
ELASTICSEARCH_URL ?=
PORT ?= 8000

all: run

build:
	docker build -t $(DOCKER_TAG) .

push: build
	docker push $(DOCKER_TAG)

run: build
	docker run \
		-e ELASTICSEARCH_URL \
		-p $(PORT):80 \
		-it $(DOCKER_TAG)
