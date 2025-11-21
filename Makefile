IMAGE ?= ghcr.io/quentinreytinas/caddy-ovh:latest

.PHONY: image
image:
	docker build -t $(IMAGE) .

.PHONY: image-multiarch
image-multiarch:
	docker buildx build \
		--platform linux/amd64,linux/arm64 \
		--tag $(IMAGE) \
		--push \
		.
