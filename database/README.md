# Crawler-Database


If you wish to set up the database from scratch you have two options:

1. Use a tool such as PGadmin and backup the existing database running on Elephant SQL and restore it to a new host.
    
2. Copy the contents of All_Tables.sql into a postgres terminal, note the tables are set up in the file in a specifc order so that table constraints are met.

Once tables are created, do the same with All_Functions.sql
        
## Running Locally with Docker

A simple dockerfile is provided for running up a local dev PG server. 

Build the dockerfile `docker built -t jack/crawler-db .`

Run and load in tables and fucntions (Note I have mapped to port 5430 to avoid conflict as I have a local pg server running):

`docker run --name crawler-db -d -p 5430:5432 jack/crawler-db`

`pgsql -h localhost -p 5430 -u jack -W`

Create the database
`create database crawler; `

Change to the database
`\c crawler `

Enable pgcrypto for password hashing
`create extension pgcrypto;`

Now paste the data for the functions and tables.