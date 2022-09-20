-- create patients table
CREATE TABLE patients (
	id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  date_of_birth DATE
);

-- create medical_histories table
CREATE TABLE medical_histories (
	id SERIAL PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INTEGER REFERENCES patients(id),
  status VARCHAR(50)  
);

-- create treatments table
CREATE TABLE treatments (
	id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  type VARCHAR(50)
);

-- create join table between medical_histories and treatments
CREATE INDEX medical_histories_treatments (
	medical_history_id INTEGER REFERENCES medical_histories(id),
  treatment_id INTEGER REFERENCES treatments(id)
);

-- create invoices table
CREATE TABLE invoices (
	id SERIAL PRIMARY KEY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INTEGER REFERENCES medical_histories (id)
);

-- create invoice_items table
CREATE TABLE invoice_items (
	id SERIAL PRIMARY KEY,
  unit_price DECIMAL,
  quantity INTEGER,
  total_price DECIMAL,
  invoice_id INTEGER REFERENCES invoices(id),
  treatment_id INTEGER REFERENCES treatments(id)
);






