#!/usr/local/bin/fish
printf "Deploying Netatalk To GKE Cluster..."
kubectl apply -f k8s/netatalk-pv.yml > /dev/null 2>&1
kubectl apply -f k8s/sealed-secret.yml > /dev/null 2>&1
kubectl apply -f k8s/deployment.yml > /dev/null 2>&1
kubectl apply -f k8s/service.yml > /dev/null 2>&1

kubectl delete pod -n files -l app=netatalk > /dev/null 2>&1
printf "Completed.\n\n"

printf "Deployment Complete\n"