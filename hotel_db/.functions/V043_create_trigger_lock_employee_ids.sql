CREATE OR REPLACE FUNCTION block_employee_id_updates()
RETURNS TRIGGER AS $$
BEGIN

    IF NEW.employee_id IS DISTINCT FROM OLD.employee_id THEN
        RAISE EXCEPTION 'gagi ka wag mo baguhin to';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_employee_id_update
BEFORE UPDATE ON employment_details
FOR EACH ROW
EXECUTE FUNCTION block_employee_id_updates();