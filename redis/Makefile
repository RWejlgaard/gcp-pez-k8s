IMAGE_NAME ?= gcr.io/rwejlgaard/redis
CURRENT_VERSION ?= $(shell gcloud container images list-tags $(IMAGE_NAME) | awk '{ print $$2}' | sed -n 2p)
NEW_VERSION  ?= $(shell gcloud container images list-tags $(IMAGE_NAME) | awk '{ print $$2}' | sed -n 2p | awk 'BEGIN{FS=OFS="."} {$$3+=1} 1')
NS       ?= redis

default: build

build:
	gcloud builds submit --tag $(IMAGE_NAME):$(NEW_VERSION) ./src

apply: export SEMVER=$(CURRENT_VERSION)
apply:
	kubectl apply -f k8s/sealed-secret.json
	kubectl apply -f k8s/redis-pv.yml
	envsubst < k8s/deployment.yml | kubectl -n $(NS) apply -f -
	kubectl apply -f k8s/service.yml
	kubectl delete pod -n $(NS) -l app=redis