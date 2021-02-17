#!/usr/local/bin/fish

printf "Enabling Cloud Build APIs..."
gcloud services enable cloudbuild.googleapis.com > /dev/null 2>&1
printf "Completed.\n"

printf "Building pez.sh Container..."
gcloud builds submit --tag gcr.io/rwejlgaard/pez.sh ./src > /dev/null 2>&1
printf "Completed.\n"

printf "Deploying pez.sh To GKE Cluster..."
kubectl apply -f k8s/deployment.yml > /dev/null 2>&1
kubectl apply -f k8s/service.yml > /dev/null 2>&1
kubectl rollout restart -n web deployment/pezsh > /dev/null 2>&1
printf "Completed.\n\n"

printf "Deployment Complete\n"