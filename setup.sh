#!/bin/bash

printf "Checking for required npm version..."
npm install -g npm > ~/pez.sh-k8s/logs/npm.txt 2>&1
printf "Completed.\n"

printf "Installing pez.sh dependencies..."
cd ./pez.sh
npm install > ~/pez.sh-k8s/logs/pezsh.txt 2>&1
printf "Completed.\n"

#printf "Installing microservies dependencies..."
#cd ../microservices
#npm install > ~/pez.sh-k8s/logs/microservices.txt 2>&1
#printf "Completed.\n"

printf "Installing React app dependencies..."
cd ../react-app
npm install > ~/pez.sh-k8s/logs/react.txt 2>&1
printf "Completed.\n"

printf "Building React app and placing into sub projects..."
npm run build > ~/pez.sh-k8s/logs/build.txt 2>&1
printf "Completed.\n\n"

printf "Script completed successfully!\n"
