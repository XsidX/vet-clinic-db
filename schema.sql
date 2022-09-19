/* Database schema to keep the structure of entire database. */

-- create animals table
CREATE TABLE animals (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50),
	date_of_birth DATE,
	escape_attempts INTEGER,
	neutered BOOLEAN,
	weight_kg DECIMAL
);

-- add species column on animals table
ALTER TABLE animals
ADD species VARCHAR(50)

-- remove species column from animals table
ALTER TABLE animals
DROP COLUMN species

-- add species_id column on animals table as foreign key
ALTER TABLE animals
ADD species_id INTEGER REFERENCES species(id)

-- add owner_id column on animals table as foreign key
ALTER TABLE animals
ADD owner_id INTEGER REFERENCES owners(id)

-- create owners table
CREATE TABLE owners (
	id SERIAL PRIMARY KEY,
  full_name VARCHAR(50),
  age INTEGER
);

-- create species table
CREATE TABLE species (
	id SERIAL PRIMARY KEY,
  name VARCHAR(50)
);

-- create vets table
CREATE TABLE vets (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50),
	age INTEGER,
	date_of_graduation DATE
);

-- create specializations table
CREATE TABLE specializations (
	vet_id INTEGER REFERENCES vets(id),
	species_id INTEGER REFERENCES species(id)
);

-- create visits table
CREATE TABLE visits (
	vet_id INTEGER REFERENCES vets(id),
	animal_id INTEGER REFERENCES animals(id),
	date_of_visit DATE
);

-- add email column on owners table
ALTER TABLE owners
ADD COLUMN email VARCHAR(120);
