#Set a builder image for our docker image
FROM node:alpine as builder

#setting workdir in container
WORKDIR /usr/app

#Copy only package.json file into the directory
COPY package.json .

#Install dependencies
RUN npm i

#Copy everything else to the container
COPY . .

#Run build
RUN npm run build

#Set the server to server our static files
FROM nginx

#Copy the static file from previous build

COPY --from=builder /usr/app/build /usr/share/nginx/html

