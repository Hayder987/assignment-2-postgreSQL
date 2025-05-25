-- Active: 1748099194238@@127.0.0.1@5432@conservation_db@public


-- create new conservation_db database
CREATE DATABASE conservation_db;

-- Create rangers Table 
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(80) NOT NULL
);


-- create species table
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(100) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) CHECK (conservation_status IN ('Endangered', 'Vulnerable', 'Historic'))
);


-- create sightings table
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT REFERENCES species(species_id) ON DELETE CASCADE, 
    ranger_id INT REFERENCES rangers(ranger_id) ON DELETE CASCADE, 
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(150) NOT NULL,
    notes TEXT
);


-- insert data on table rangers
INSERT INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range'),
('Derek Fox', 'Coastal Plains'),
('Ella Stone', 'Desert Edge'),
('Frank River', 'Wetland Marshes'),
('Grace Bloom', 'Forest Zone');


-- insert data on TAble species
INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Dodo', 'Raphus cucullatus', '1598-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Indian Pangolin', 'Manis crassicaudata', '1822-01-01', 'Vulnerable'),
('Passenger Pigeon', 'Ectopistes migratorius', '1800-01-01', 'Endangered'),
('Golden Langur', 'Trachypithecus geei', '1956-03-15', 'Endangered');


-- insert data on Table sightings
INSERT INTO sightings (species_id, ranger_id, sighting_time, location, notes) VALUES
(1, 1, '2024-05-10 07:45:00', 'Peak Ridge', 'Camera trap image captured'),
(4, 2, '2024-05-12 16:20:00', 'Bankwood Area', 'Juvenile seen near riverbank'),
(2, 3, '2024-05-15 09:10:00', 'Bamboo Grove East', 'Feeding observed in dense cover'),
(1, 2, '2024-05-18 18:30:00', 'Snowfall Pass', NULL),
(5, 4, '2024-05-20 06:30:00', 'Rocky Trail', 'Seen burrowing near rocks'),
(7, 6, '2024-05-21 19:15:00', 'River Cliff', 'Heard calls, no visuals'),
(6, 5, '2024-05-23 11:00:00', 'Pine Meadow', 'Bones discovered, possible old sighting');


-- display all table data
SELECT * FROM rangers;
SELECT * FROM species;
SELECT * FROM sightings;

-- drop table
-- DROP TABLE sightings;
-- DROP TABLE species;
-- DROP TABLE rangers

-- -------------PostgreSQL Problems & Sample Outputs------------------------>

-- problem-1: Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'
INSERT INTO rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');


-- problem-2: Count unique species ever sighted.
SELECT COUNT(*) AS unique_species_count
FROM (
  SELECT species_id
  FROM sightings
  GROUP BY species_id
) AS grouped_species;



-- problem-3:Find all sightings where the location includes "Pass".  using like;
SELECT * FROM sightings
 WHERE location ILIKE '%Pass%';


-- problem-4: List each ranger's name and their total number of sightings

 SELECT rangers.name, COUNT(sightings.sighting_id) AS total_sightings FROM rangers
  LEFT JOIN sightings ON rangers.ranger_id = sightings.ranger_id
  GROUP BY rangers.name;


-- problem-5: List species that have never been sighted.
SELECT common_name FROM species 
 WHERE species_id NOT IN (
    SELECT species_id FROM sightings
 );


-- problem-6: Show the most recent 2 sightings.
SELECT common_name, sighting_time, name AS ranger_name FROM sightings
 JOIN species ON sightings.species_id = species.species_id
 JOIN rangers ON sightings.ranger_id = rangers.ranger_id
 ORDER BY sighting_time DESC LIMIT 2;


-- problem-7: Update all species discovered before year 1800 to have status 'Historic'.
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01' ;

-- problem-8:Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.
SELECT
  sighting_id,
  CASE
    WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sighting_time) >= 12 AND EXTRACT(HOUR FROM sighting_time) < 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM sightings;


-- problem-9: Delete rangers who have never sighted any species
DELETE FROM rangers
WHERE ranger_id NOT IN (
    SELECT ranger_id FROM sightings
    WHERE ranger_id IS NOT NULL
);
