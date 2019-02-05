# Build Phase

# 'as <stage name>' specifies the current stage
FROM node:alpine as builder
WORKDIR /opt/app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /opt/app/build will contain all build files

# Run Phase

# don't need to specify the stage name here
FROM nginx
# tells elasticbeanstalk to use map port 80
EXPOSE 80
# copy build files from build stage
COPY --from=builder /opt/app/build /usr/share/nginx/html
# default command of nginx container will start nginx
# so no need to specify 