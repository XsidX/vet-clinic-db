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


-- insert into vets table
INSERT INTO vets (name, age, date_of_graduation)
VALUES
  ('William Tatcher', 45, 'Apr 23, 2000'),
  ('Maisy Smith', 26, 'Jan 17, 2019'),
  ('Stephanie Mendez', 64, 'May 4, 1981'),
  ('Jack Harkness', 38, 'Jun 8, 2008');

-- insert into specializations table
-- Vet William Tatcher is specialized in Pokemon.
-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
-- Vet Jack Harkness is specialized in Digimon.

INSERT INTO specializations (vet_id, species_id)
VALUES
  (1, 1),
  (3, 1),
  (3, 2),
  (4, 2);

-- insert into visits table

-- Agumon visited William Tatcher on May 24th, 2020.
-- Agumon visited Stephanie Mendez on Jul 22th, 2020.
-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
-- Pikachu visited Maisy Smith on Jan 5th, 2020.
-- Pikachu visited Maisy Smith on Mar 8th, 2020.
-- Pikachu visited Maisy Smith on May 14th, 2020.
-- Devimon visited Stephanie Mendez on May 4th, 2021.
-- Charmander visited Jack Harkness on Feb 24th, 2021.
-- Plantmon visited Maisy Smith on Dec 21st, 2019.
-- Plantmon visited William Tatcher on Aug 10th, 2020.
-- Plantmon visited Maisy Smith on Apr 7th, 2021.
-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
-- Angemon visited Jack Harkness on Oct 3rd, 2020.
-- Angemon visited Jack Harkness on Nov 4th, 2020.
-- Boarmon visited Maisy Smith on Jan 24th, 2019.
-- Boarmon visited Maisy Smith on May 15th, 2019.
-- Boarmon visited Maisy Smith on Feb 27th, 2020.
-- Boarmon visited Maisy Smith on Aug 3rd, 2020.
-- Blossom visited Stephanie Mendez on May 24th, 2020.
-- Blossom visited William Tatcher on Jan 11th, 2021.

INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES
  (1, 1, 'May 24, 2020'),
  (1, 3, 'Jul 22, 2020'),
  (2, 4, 'Feb 2, 2021'),
  (3, 2, 'Jan 5, 2020'),
  (3, 2, 'Mar 8, 2020'),
  (3, 2, 'May 14, 2020'),
  (4, 3, 'May 4, 2021'),
  (5, 4, 'Feb 24, 2021'),
  (6, 2, 'Dec 21, 2019'),
  (6, 1, 'Aug 10, 2020'),
  (6, 2, 'Apr 7, 2021'),
  (7, 3, 'Sep 29, 2019'),
  (8, 4, 'Oct 3, 2020'),
  (8, 4, 'Nov 4, 2020'),
  (9, 2, 'Jan 24, 2019'),
  (9, 2, 'May 15, 2019'),
  (9, 2, 'Feb 27, 2020'),
  (9, 2, 'Aug 3, 2020'),
  (10, 3, 'May 24, 2020'),
  (10, 1, 'Jan 11, 2021');












