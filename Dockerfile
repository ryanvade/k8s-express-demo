# Use a throwaway build image to compile the TS
# http://label-schema.org/rc1/
FROM node:14 AS BUILD

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY package.json yarn.lock ./
RUN yarn install
COPY . /usr/src/app
RUN yarn build

# Use a smaller alpine image to run the application
FROM node:14-alpine

LABEL maintainer="Ryan Owens <rowens at uncomn.com>" org.label-schema.schema-version="1.0" org.label-schema.vendor="UNCOMN" org.label-schema.name="uncomn/k8s-express-demo"
WORKDIR /app
COPY --from=BUILD /usr/src/app/dist /usr/src/app/package.json /usr/src/app/yarn.lock ./
RUN yarn install --production
EXPOSE 3000
# Don't want to use Root to run the application..
USER 1000
ENV NODE_ENV "production"
CMD ["node", "/app/index.js"]