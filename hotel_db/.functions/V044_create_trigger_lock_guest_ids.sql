CREATE OR REPLACE FUNCTION block_guest_id_updates()
RETURNS TRIGGER AS $$
BEGIN

    IF NEW.guest_id IS DISTINCT FROM OLD.guest_id THEN
        RAISE EXCEPTION 'gagi ka wag mo baguhin to';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_guest_id_update
BEFORE UPDATE ON guests
FOR EACH ROW
EXECUTE FUNCTION block_guest_id_updates();