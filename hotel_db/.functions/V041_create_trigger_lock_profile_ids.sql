CREATE OR REPLACE FUNCTION block_profile_id_updates()
RETURNS TRIGGER AS $$
BEGIN

    IF NEW.profile_id IS DISTINCT FROM OLD.profile_id THEN
        RAISE EXCEPTION 'gagi ka wag mo baguhin to';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_profile_id_update
BEFORE UPDATE ON profiles
FOR EACH ROW
EXECUTE FUNCTION block_profile_id_updates();