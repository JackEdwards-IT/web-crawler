# Web Crawler Project

## Intro

For my capstone uni project I created a web crawler in Node.js as part of a small team. My job was to develop the back-end for the crawler. 
I created a REST API that handled login and all CRUD operations dealing with users and links to crawl. I also built the crawler functionality 
based on a node library and designed and implemented the database using PostgreSQL.

Another team member created the front end utilising Angular. My goal with this project is to create my own front end from scratch using Vue.js. 
This will be a great learning opportunity but will also enable me to showcase a full stack application that I have created every aspect of.

## Work in Progress

The backend was created around 6 months ago. Original repos can be found on my uni github [here](https://github.com/s3727853/WebCrawler-Database) and [here](https://github.com/s3727853/WebCrawler-Backend). I have combined them all in this repo for ease of local dev with docker compose.

This is predominantly a learning exercise for me and will be the first time I use Vue.js to create a dynamic SPA. I anticipate progress will be slow as I learn.

Simple [Trello Board](https://trello.com/b/Rwrt0Uhr) to track progress.

## API

Postman API doc [Postman](https://www.getpostman.com/collections/5744d8c9c9425fa406a2)

Note API endpoint links are out of date.

## Local dev with Docker

### API

Build the dockerfile located in the backend folder. This is then utilised by docker compose.

`docker build -t jack/node-crawler .`

### Database

Build the dockerfile located in the database folder and on first run load all the functions and tables into a new database. ENV variables for user and password are located in the Dockerfile for dev use only. 

Build:

`docker build -t jack/crawler-db .`


### Docker Compose

#### Intial Setup

Once images are built for the API and Database the backend can be started using the docker compose file in the projects root directory. 

On first run the database tables and functions will need to be manually added.
(Note I have mapped to port 5430 to avoid conflict as I have a local pg server running)

Connect to database
`pgsql -h localhost -p 5430 -u jack -W`

Create the database
`create database crawler; `

Change to the database
`\c crawler `

Enable pgcrypto for password hashing
`create extension pgcrypto;`

Now paste in the data for the functions and tables found in the Database folder.

Note the database storage is mapped to `${HOME}/crawler-db/` to ensure data is maintained.

#### Running with Docker Compose

`docker-compose up -d`

#### Testing

A demo test route is provided to check that the API and database are communicating.
`GET http://localhost:3001/api/demo` returns a table from the db.