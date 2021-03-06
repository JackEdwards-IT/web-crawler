# Crawler API 

Assumed prerequisites: Node.js is installed on your environment along with the npm package manager 

## `.env`

Enviroment variables store passwords and senstive settings. They are therfore not included in the repo files (.gitignore has an entry)
and you will need to manually create the file when developing locally. The file should be named: .env

Example:

```sh
# .env
NODE_ENV=development
DB_NAME=""
DB_HOST=""
DB_PORT=""
DB_PASSWORD=""
DB_USERNAME=""
JWT_SECRET=""
JWT_EXPIRE_TIME=""
FRONTEND_URL="https://redback-crawler.herokuapp.com"
LH_URL="http://localhost:8080"
```

## Development

Please note this is currently running on port 3001 in development mode (when you run it locally) and when accessing API routes you will need to reflect this.

## First time setup 

First time setup requires you to run the following command within the Crawldashians_backend folder to install all the node dependencies for the project. 

```sh
npm install 
```
 
After that has completed, to run the application use one of the below: 

### Local


```sh
npm run start:dev
```

## Production

### Local

```sh
npm run start:prod
```
## Docker Container for local dev (Used by docker-compose for the full stack)

A dockerfile has been provided based on the official node image. This image is provided as simple way to run up a the API for demonstration or use when
developing/testing another element of the project that requires the API.

To run a containerised version:

Build: `sudo docker build -t jack/node-crawler .`

Run: `sudo docker run -d -p 3001:3001 jack/node-crawler`

Check the Dockerfile for ENV variables if you need to change them.