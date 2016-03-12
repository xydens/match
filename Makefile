.PHONY: all build push run

DOCKER_TAG ?= pavlov/match

all: run

build:
	docker build -t $(DOCKER_TAG) .

push: build
	docker push $(DOCKER_TAG)

run: build
	docker run -it $(DOCKER_TAG)
