FROM node:lts-alpine
ENV NODE_ENV=production

WORKDIR /usr/src/app
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", ".env", "./"]

RUN npm install --production

COPY . .
EXPOSE 3000
EXPOSE 3005
EXPOSE 8080
RUN chown -R node /usr/src/app
USER node
CMD ["npm", "start"]