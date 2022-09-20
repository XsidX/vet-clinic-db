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

-----------------------------------------------------------------------------------------------------
  -- add indexes for lookup on tables

  -- add index on medical_histories table for lookup on patient_id
CREATE INDEX medical_histories_patient_id_idx 
ON medical_histories(patient_id);

-- add index on medical_histories_treatments join table for lookup on medical_history_id
CREATE INDEX 
ON medical_histories_treatments (medical_history_id)

-- add index on medical_histories_treatments join table for lookup on treatment_id
CREATE INDEX 
ON medical_histories_treatments (treatment_id)

-- add index on invoices table for lookup on medical_history_id
CREATE INDEX invoices_medical_history_id_idx 
ON invoices(medical_history_id);

-- add index on invoice_items table for lookup on invoice_id
CREATE INDEX invoices_items_invoice_id_idx 
ON invoice_items(invoice_id);

-- add index on invoice_items table for lookup on treatment_id
CREATE INDEX invoices_items_treatment_id_idx 
ON invoice_items(treatment_id);




