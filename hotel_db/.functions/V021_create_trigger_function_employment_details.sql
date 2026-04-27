CREATE SEQUENCE employment_details_seq START 1;

CREATE OR REPLACE FUNCTION generate_employee_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.employee_id := 'EMP' || LPAD(nextval('employment_details_seq')::text, 2, '0');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER employment_details_id_trigger
BEFORE INSERT ON employment_details
FOR EACH ROW
EXECUTE FUNCTION generate_employee_id();