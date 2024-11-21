CREATE USER smartbrain WITH PASSWORD 'smart-brain';

CREATE DATABASE smartbrain;

GRANT ALL PRIVILEGES ON DATABASE smartbrain TO smartbrain;

CREATE TABLE users (
  id serial PRIMARY KEY,
  name VARCHAR(100),
  email text UNIQUE NOT NULL,
  entries BIGINT DEFAULT 0,
  joined TIMESTAMP NOT NULL
);

CREATE TABLE login (
  id serial PRIMARY KEY,
  hash VARCHAR(100),
  email text UNIQUE NOT NULL
);
