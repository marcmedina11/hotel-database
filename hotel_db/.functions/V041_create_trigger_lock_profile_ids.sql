CREATE TRIGGER lock_profile_ids
BEFORE UPDATE ON profiles
FOR EACH ROW
EXECUTE FUNCTION block_id_updates();