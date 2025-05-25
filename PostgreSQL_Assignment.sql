-- Active: 1747460106983@@localhost@5432@conservation_db
CREATE DATABASE conservation_db;

CREATE TABLE rangers (
  ranger_id SERIAL PRIMARY KEY,
  "name" TEXT NOT NULL,
  region TEXT 
);


CREATE TABLE species (
  species_id SERIAL PRIMARY KEY,
  common_name TEXT NOT NULL,
  scientific_name TEXT NOT NULL,
  discovery_date DATE NOT NULL,
  conservation_status TEXT CHECK (
    conservation_status IN ('Threatened', 'Vulnerable', 'Endangered')
  )
);

CREATE TABLE sightings (
  sighting_id SERIAL PRIMARY KEY,
  ranger_id INT NOT NULL REFERENCES rangers(ranger_id) ON DELETE CASCADE,
  species_id INT NOT NULL REFERENCES species(species_id) ON DELETE CASCADE,
  sighting_time TIMESTAMP NOT NULL,
  location TEXT NOT NULL,
  notes TEXT
);

INSERT INTO rangers ("name", region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range'),
('David Stone', 'Eastern Plains'),
('Eva Brown', 'Savannah Reserve'),
('Frank Moore', 'Desert Outpost'),
('Grace Lee', 'Wetland Sanctuary'),
('Hank Miller', 'Rainforest Edge'),
('Ivy Turner', 'Highland Ridge'),
('Jake Wilson', 'Coastal Zone');


INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
('Golden Langur', 'Trachypithecus geei', '1956-01-01', 'Threatened'),
('Ganges River Dolphin', 'Platanista gangetica', '1801-01-01', 'Endangered'),
('Slender Loris', 'Loris tardigradus', '1758-01-01', 'Threatened'),
('Indian Pangolin', 'Manis crassicaudata', '1822-01-01', 'Vulnerable'),
('Himalayan Monal', 'Lophophorus impejanus', '1856-01-01', 'Threatened'),
('Fishing Cat', 'Prionailurus viverrinus', '1821-01-01', 'Vulnerable'),
('Indian Wolf', 'Canis lupus pallipes', '1832-01-01', 'Endangered'),
('Nilgiri Tahr', 'Nilgiritragus hylocrius', '1838-01-01', 'Endangered'),
('Great Indian Bustard', 'Ardeotis nigriceps', '1861-01-01', 'Endangered'),
('Indian Star Tortoise', 'Geochelone elegans', '1831-01-01', 'Vulnerable'),
('Malabar Civet', 'Viverra civettina', '1864-01-01', 'Endangered'),
('Indian Spotted Eagle', 'Clanga hastata', '1829-01-01', 'Threatened'),
('Forest Owlet', 'Heteroglaux blewitti', '1873-01-01', 'Endangered'),
('Rusty-Spotted Cat', 'Prionailurus rubiginosus', '1831-01-01', 'Vulnerable'),
('Indian Skimmer', 'Rynchops albicollis', '1831-01-01', 'Endangered'),
('Lion-tailed Macaque', 'Macaca silenus', '1758-01-01', 'Endangered');


INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL),
(4, 4, 'Riverbend Clearing', '2024-05-20 06:50:00', 'Herd of elephants crossing'),
(5, 5, 'Golden Tree Hill', '2024-05-22 08:15:00', 'Family group seen foraging'),
(6, 10, 'Dune Spring', '2024-05-24 17:40:00', 'Lone dolphin surfaced briefly'),
(12, 9, 'Misty Wetlands', '2024-05-25 05:55:00', 'Heard distinct call at dawn'),
(8, 7, 'Thornbrush Sector', '2024-05-26 19:05:00', 'Observed digging behavior'),
(9, 9, 'Echo Ridge', '2024-05-27 07:10:00', NULL),
(10, 10, 'Coral Creek', '2024-05-28 14:30:00', 'Tracks along muddy bank'),
(11, 3, 'Shadow Cliff', '2024-05-29 06:30:00', 'Pair sighted at a distance'),
(12, 4, 'Goat Rock Valley', '2024-05-30 09:45:00', 'Adult grazing near the stream'),
(7, 5, 'Open Dunes', '2024-06-01 17:20:00', 'Flying overhead during patrol'),
(3, 5, 'Star Patch', '2024-06-03 11:10:00', 'Found near a watering hole'),
(15, 7, 'Jungle Hollow', '2024-06-04 13:05:00', 'Fast-moving, hard to capture'),
(4, 7, 'Eagle Nest Hill', '2024-06-06 07:50:00', 'Call heard, nest possibly nearby'),
(15, 9, 'Old Forest Road', '2024-06-08 16:15:00', 'Briefly spotted near trees'),
(11, 1, 'Rocky Ravine', '2024-06-09 12:40:00', 'Two juveniles crossing trail'),
(9, 1, 'Lakeside Edge', '2024-06-11 08:00:00', 'Observed near shoreline'),
(2, 3, 'Mangrove Bend', '2024-06-12 18:25:00', 'Faint sounds reported by local guide');




SELECT * FROM rangers;
SELECT * FROM species;
SELECT * FROM sightings;

-- Problem - 1
INSERT INTO rangers ("name", region) 
VALUES ('Derek Fox', 'Coastal Plains');

-- Problem - 2
SELECT COUNT(*) AS unique_species_count
FROM (
  SELECT species_id
  FROM sightings
  GROUP BY species_id
);


-- Problem - 3
SELECT * FROM sightings
WHERE location LIKE '%Pass%';

-- Problem - 4


