/*Queries that provide answers to the questions from all projects.*/

SELECT name FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE EXTRACT(year FROM date_of_birth) BETWEEN 2016 AND 2019;
SELECT name FROM animals WHERE neutered AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


-- update species column in a transaction
BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species is null;

COMMIT;

-- delete all records using a transaction, then rollback

BEGIN;
DELETE FROM animals
ROLLBACK;


-- delete-where-born-after-jan1st2022 using a transaction
BEGIN;

DELETE FROM animals
WHERE date_of_birth > 'Jan 1, 2022';
-- add savepoint save_1
SAVEPOINT save_1;

-- update weight to -ve weight
UPDATE animals
SET weight_kg = weight_kg * -1
-- rollback to savepoint save_1
ROLLBACK TO SAVEPOINT save_1;
-- update weight where -ve
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg is < 0;
-- commit transactions
COMMIT;

-- animal count
SELECT COUNT(*) AS animal_count FROM animals

-- never escaped count
SELECT COUNT(*) AS never_escaped FROM animals WHERE escape_attempts < 1

-- average animal weight
SELECT AVG(weight_kg) AS avg_animal_weight FROM animals

-- neutered vs neutered, whose escaped more
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

-- species min and max weight
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

-- species average escape attempts
SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals GROUP BY species