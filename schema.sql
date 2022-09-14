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