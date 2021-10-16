FROM node:12-alpine

WORKDIR /usr/src/app

# Only copy the package.json file to work directory
COPY package*.json ./

# Install all Packages
# RUN npm install --quiet -g gulp bower yo mocha karma-cli pm2 && npm cache clean --force
# RUN npm install
RUN npm install
# Copy all other source code to work directory
# ADD . /usr/src/app/
COPY . .

# TypeScript
# RUN npm run tsc
# # Start
# CMD [ "npm", "start" ]
EXPOSE 8002