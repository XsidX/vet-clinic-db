/*Queries that provide answers to the questions from all projects.*/

SELECT name FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE EXTRACT(year FROM date_of_birth) BETWEEN 2016 AND 2019;
SELECT name FROM animals WHERE neutered AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species is null;

COMMIT;

BEGIN;
DELETE FROM animals
ROLLBACK;


BEGIN;

DELETE FROM animals
WHERE date_of_birth > 'Jan 1, 2022';
SAVEPOINT save_1;

UPDATE animals
SET weight_kg = weight_kg * -1
ROLLBACK TO SAVEPOINT save_1;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg is < 0;

COMMIT;


SELECT COUNT(*) AS animal_count FROM animals
SELECT COUNT(*) AS never_escaped FROM animals WHERE escape_attempts < 1
SELECT AVG(weight_kg) AS avg_animal_weight FROM animals
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals GROUP BY species