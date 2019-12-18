# base image
FROM node:alpine

# set working directory
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# install and cache app dependencies
COPY front/package.json /app/package.json
RUN npm install
RUN npm install -g @vue/cli

# start app
CMD ["npm", "run", "dev"]

