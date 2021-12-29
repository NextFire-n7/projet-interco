DOCKER_DIR=docker

# List here all images to build and used in the docker-compose.yml files
all: router box client
	@

# List here dependencies if applicable
router: base-alpine
box: router
client: base-ubuntu

# Generic rule
%:
	docker build -t $@ $(DOCKER_DIR)/$@

# to remove all built images
mrproper:
	docker image rm -f $(shell ls $(DOCKER_DIR))
