/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
	('Agumon', TO_DATE('03/02/2020', 'MM/DD/YYYY'), 0, true, 10.23 ),
	('Gabumon', TO_DATE('11/15/2020', 'MM/DD/YYYY'), 2, true, 8),
	('Pikachu', TO_DATE('01/07/2021', 'MM/DD/YYYY'), 1, false, 15.04),
	('Devimon', TO_DATE('05/12/2017', 'MM/DD/YYYY'), 5, true, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
	('Charmander', 'Feb 8, 2020', 0, false, 11 ),
  ('Plantmon', 'Nov 15, 2021', 2, true, 5.7 ),
  ('Squirtle', 'Apr 2, 1993', 3, false, 12.13 ),
  ('Angemon', 'Jun 12, 2005', 1, true, 45 ),
  ('Boarmon', 'Jun 7, 2005', 7, true, 20.4 ),
  ('Blossom', 'Oct 13, 1998', 3, true, 17 ),
  ('Ditto', 'May 14, 2022', 4, true, 22);


-- insert into owners table

INSERT INTO owners (full_name, age)
VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

-- insert into species table

INSERT INTO species (name)
VALUES
  ('Pokemon'),
  ('Digimon');

-- update animals table so it includes the species_id value
UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = 1
WHERE name NOT LIKE '%mon';

-- update animals so it includes the owner_id value
-- Sam Smith owns Agumon.
-- Jennifer Orwell owns Gabumon and Pikachu.
-- Bob owns Devimon and Plantmon.
-- Melody Pond owns Charmander, Squirtle, and Blossom.
-- Dean Winchester owns Angemon and Boarmon.

UPDATE animals
SET owner_id = 1
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = 2
WHERE name = 'Gabumon' OR name = 'Pikachu';

UPDATE animals
SET owner_id = 3
WHERE name = 'Devimon' OR name = 'Plantmon';

UPDATE animals
SET owner_id = 4
WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

UPDATE animals
SET owner_id = 5
WHERE name = 'Angemon' OR name = 'Boarmon';












