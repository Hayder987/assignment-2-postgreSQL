-- Active: 1747477117878@@127.0.0.1@5432@conservation_db@public

-- create new conservation_db database
CREATE DATABASE conservation_db;

-- Create rangers Table 
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(80) NOT NULL
);
