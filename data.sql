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

