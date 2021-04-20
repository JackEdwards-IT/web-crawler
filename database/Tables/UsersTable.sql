CREATE TABLE users (
id SERIAL PRIMARY KEY,
first_name VARCHAR(130) NOT NULL,
last_name VARCHAR(130) NOT NULL,
email VARCHAR(130) NOT NULL UNIQUE,
role VARCHAR(20) NOT NULL,
pass_hash VARCHAR(200) NOT NULL,
created_at TIMESTAMP NOT NULL
);

