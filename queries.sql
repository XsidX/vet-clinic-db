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
SET weight_kg = weight_kg * -1;
-- rollback to savepoint save_1
ROLLBACK TO SAVEPOINT save_1;
-- update weight where -ve
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
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


-- query multiple tables

-- animals that belong to Melody Pond
SELECT full_name, name
FROM animals
JOIN owners ON owners.id = animals.owner_id
WHERE owners.full_name = 'Melody Pond'

-- animals that are pokemon
SELECT animals.name
FROM animals
JOIN species ON species.id = animals.species_id
WHERE species.name = 'Pokemon'

-- all owners with their animals including those without animals
SELECT owners.full_name, animals.name
FROM animals
RIGHT JOIN owners ON owners.id = animals.owner_id

-- animal count per species
SELECT species.name, COUNT(animals) AS animal_count
FROM animals
JOIN species ON species.id = animals.species_id
GROUP BY species.name

-- all digimon owned by Jennifer Orwell
SELECT animals.name
FROM animals
JOIN owners ON owners.id = animals.owner_id
JOIN species ON species.id = animals.species_id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon'

-- all animals owned by Dean Winchester that haven't tried to escape
SELECT animals.name
FROM animals
JOIN owners ON owners.id = animals.owner_id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts < 1

-- owns the most animals
SELECT owners.full_name, COUNT(animals) AS num_of_animals_owned
FROM animals
JOIN owners ON owners.id = animals.owner_id
GROUP BY owners.id
ORDER BY num_of_animals_owned DESC
LIMIT 1

------------------------------------------------------------------------------------------------------------------------------
-- many-to-many relationships

-- last seen by vet William Tatcher
SELECT animals.name, MAX(visits.date_of_visit) AS last_visit_date
FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'William Tatcher'
GROUP BY animals.name
ORDER BY last_visit_date DESC
LIMIT 1;

-- number of animals seen by Stephanie Mendez
SELECT COUNT(animals) AS animal_count
FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez'
GROUP BY vets.name;

-- list of all vets with or without their specialities
SELECT vets.name, species.name
FROM vets
LEFT JOIN specializations ON specializations.vet_id = vets.id
LEFT JOIN species ON species.id = specializations.species_id;

-- animals that visited Stephanie Mendez between April 1st and August 30th, 2020
SELECT animals.name, visits.date_of_visit
FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez'
AND (visits.date_of_visit > 'April 1, 2020' AND visits.date_of_visit < 'August 30, 2020');

-- animal with most visits to vets
SELECT animals.name, COUNT(visits) AS num_of_visits
FROM animals
JOIN visits ON visits.animal_id = animals.id
GROUP BY animals.id
ORDER BY num_of_visits DESC
LIMIT 1;

-- Who was Maisy Smith's first visit
SELECT animals.name
FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visit ASC
LIMIT 1;


-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name,
animals.date_of_birth,
animals.escape_attempts,
animals.neutered,
animals.weight_kg,
owners.full_name AS owner_name,
vets.name AS vet_name, species.name AS species_name, visits.date_of_visit
FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
JOIN owners ON owners.id = animals.owner_id
JOIN specializations ON specializations.vet_id = vets.id
JOIN species ON species.id = specializations.species_id
ORDER BY visits.date_of_visit DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS no_of_visits_with_non_specialized_vet
FROM visits
JOIN vets ON vets.id = visits.vet_id
JOIN animals ON animals.id = visits.animal_id
JOIN species ON species.id = animals.species_id
LEFT JOIN specializations ON specializations.vet_id = vets.id
WHERE NOT EXISTS (
    SELECT *
    FROM specializations
    WHERE specializations.vet_id = vets.id
    AND specializations.species_id = animals.species_id
)
OR specializations.species_id IS NULL;

-- Maisy Smith should consider specializing in ? species
SELECT species.name AS speciality_to_consider
FROM visits
JOIN vets ON vets.id = visits.vet_id
JOIN animals ON animals.id = visits.animal_id
JOIN species ON species.id = animals.species_id
LEFT JOIN specializations ON specializations.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(species.name) DESC
LIMIT 1;


------------------------------------------------------------------------------------------------------------------------------
  -- performance audit
------------------------------------------------------------------------------------------------------------------------------

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE animal_id = 4
-- the above query returns an execution time of 2757.049 ms
-- CREATE INDEX visits_animal_id_idx ON visits (animal_id);
-- after creating the index, the query execution time is 534.803 ms

----------------------------------------------------------------------------------------------------------------------------------


EXPLAIN ANALYZE SELECT * FROM visits WHERE vet_id = 2;
-- the above query returns an execution time of 3656.370 ms
-- CREATE INDEX visits_vet_id_idx ON visits (vet_id);
-- after creating the index, the query execution time is 2181.498 ms

----------------------------------------------------------------------------------------------------------------------------------

EXPLAIN ANALYZE SELECT * FROM owners WHERE email = 'owner_18327@mail.com';
-- the above query returns an execution time of 2024.621 ms
-- CREATE INDEX owners_email_idx ON owners (email);
-- after creating the index, the query execution time is 0.432 ms








