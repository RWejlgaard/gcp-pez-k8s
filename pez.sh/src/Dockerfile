FROM httpd:2.4

# Create app directory
WORKDIR /usr/local/apache2/htdocs/

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY ./public-html/ /usr/local/apache2/htdocs/

#RUN npm install
## If you are building your code for production
## RUN npm ci --only=production
#
## Bundle app source
#COPY . .

EXPOSE 80
#CMD [ "node", "src/server.js" ]