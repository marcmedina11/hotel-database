CREATE OR REPLACE FUNCTION block_room_id_updates()
RETURNS TRIGGER AS $$
BEGIN

    IF NEW.room_id IS DISTINCT FROM OLD.room_id THEN
        RAISE EXCEPTION 'gagi ka wag mo baguhin to';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_room_id_update
BEFORE UPDATE ON rooms
FOR EACH ROW
EXECUTE FUNCTION block_room_id_updates();