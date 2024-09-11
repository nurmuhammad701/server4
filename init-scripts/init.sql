CREATE EXTENSION postgres_fdw;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- Server1 uchun
CREATE SERVER server1_fdw FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host '89.236.218.41', port '5432', dbname 'server1_db');
CREATE USER MAPPING FOR postgres SERVER server1_fdw OPTIONS (user 'postgres', password 'your_password');
CREATE FOREIGN TABLE users_server1 (
    id INTEGER,
    username VARCHAR(50),
    email VARCHAR(100)
) SERVER server1_fdw OPTIONS (schema_name 'public', table_name 'users');

-- Server2 uchun
CREATE SERVER server2_fdw FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host '89.236.218.41', port '5432', dbname 'server2_db');
CREATE USER MAPPING FOR postgres SERVER server2_fdw OPTIONS (user 'postgres', password 'your_password');
CREATE FOREIGN TABLE users_server2 (
    id INTEGER,
    username VARCHAR(50),
    email VARCHAR(100)
) SERVER server2_fdw OPTIONS (schema_name 'public', table_name 'users');

-- Server3 uchun
CREATE SERVER server3_fdw FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host '89.236.218.41', port '5432', dbname 'server3_db');
CREATE USER MAPPING FOR postgres SERVER server3_fdw OPTIONS (user 'postgres', password 'your_password');
CREATE FOREIGN TABLE users_server3 (
    id INTEGER,
    username VARCHAR(50),
    email VARCHAR(100)
) SERVER server3_fdw OPTIONS (schema_name 'public', table_name 'users');