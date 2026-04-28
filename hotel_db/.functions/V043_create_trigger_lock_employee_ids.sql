CREATE TRIGGER lock_employee_ids
BEFORE UPDATE ON employment_details
FOR EACH ROW
EXECUTE FUNCTION block_id_updates();