ALTER SEQUENCE employment_details_seq RESTART WITH 15;

CREATE OR REPLACE FUNCTION generate_employee_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.employee_id := 'EMP' || LPAD(nextval('employment_details_seq')::text, 3, '0');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;