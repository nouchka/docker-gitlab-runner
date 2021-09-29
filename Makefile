DOCKER_IMAGE=gitlab-runner

include Makefile.docker

.PHONY: check-version
check-version:
	docker run --rm --entrypoint $(DOCKER_IMAGE) $(DOCKER_NAMESPACE)/$(DOCKER_IMAGE):$(VERSION) --version| grep 'Version:'|awk '{print $$2}'
