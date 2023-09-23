FROM node:16-alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install
RUN mkdir node_modules/.cache && chmod -R 777 node_modules/.cache
COPY . .
RUN npm run build

# /app/build <--- has all the stuff

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

#Don't haave to specifically start up nginx ourselves. Will do it by default.