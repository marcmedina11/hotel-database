CREATE OR REPLACE FUNCTION block_booking_id_updates()
RETURNS TRIGGER AS $$
BEGIN

    IF NEW.booking_id IS DISTINCT FROM OLD.booking_id THEN
        RAISE EXCEPTION 'gagi ka wag mo baguhin to';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_booking_id_update
BEFORE UPDATE ON bookings
FOR EACH ROW
EXECUTE FUNCTION block_booking_id_updates();