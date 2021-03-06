// Using the postgres-node library setup the database connection pool for use in
// api controllers.

import { Pool } from 'pg';

// Read in .env variables.
require('dotenv').config();

const pool = new Pool({
  connectionLimit: 4, // our elephantSQL plan has a 5 connection limit
  user: process.env.DB_USERNAME,
  password: process.env.DB_PASSWORD,
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME
});

export default pool;