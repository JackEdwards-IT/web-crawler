CREATE TABLE users (
    id serial PRIMARY KEY,
    first_name varchar(130) NOT NULL,
    last_name varchar(130) NOT NULL,
    email varchar(130) NOT NULL UNIQUE,
    role VARCHAR(20) NOT NULL,
    pass_hash varchar(200) NOT NULL,
    created_at timestamp NOT NULL
);

CREATE TABLE ibanrates (
    id serial PRIMARY KEY,
    code varchar(3) NOT NULL UNIQUE,
    rate numeric NOT NULL,
    last_updated timestamp NOT NULL
);

CREATE TABLE ibanHistory (
    id serial PRIMARY KEY,
    code varchar(3) NOT NULL,
    rate numeric NOT NULL,
    last_updated timestamp NOT NULL
);

CREATE TABLE ebaylinks (
    id serial PRIMARY KEY,
    user_id int,
    link varchar(1000) NOT NULL,
    link_description varchar(1000) NOT NULL,
    last_crawled timestamp NOT NULL,
    link_valid boolean NOT NULL,
    initial_price numeric NOT NULL,
    current_price numeric,
    crawl_interval int NOT NULL,
    image varchar,
    endtime varchar,
    CONSTRAINT fk_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE ebaylinkhistory (
    id serial PRIMARY KEY,
    link_id int,
    time_crawled timestamp NOT NULL,
    price numeric NOT NULL,
    CONSTRAINT fk_id FOREIGN KEY (link_id) REFERENCES ebaylinks (id) ON DELETE CASCADE
);

CREATE TABLE ebayEmail (
    id serial PRIMARY KEY,
    link_id int,
    price_increase boolean NOT NULL,
    notification_amount numeric NOT NULL,
    CONSTRAINT fk_id FOREIGN KEY (link_id) REFERENCES ebaylinks (id) ON DELETE CASCADE
);

CREATE TABLE demo_table (
    id serial PRIMARY KEY,
    name varchar(130) NOT NULL,
    role VARCHAR(20) NOT NULL
);

INSERT INTO demo_table
    VALUES (1, 'Jack Edwards', 'Frontend Dev'), (2, 'Jack Edwards', 'Backend Dev'), (3, 'Jack Edwards', 'Database Dev');

