CREATE SEQUENCE guests_seq START 1;

CREATE OR REPLACE FUNCTION generate_guest_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.guest_id := 'GUEST-' || LPAD(nextval('guests_seq')::text, 3, '0');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER guests_id_trigger
BEFORE INSERT ON guests
FOR EACH ROW
EXECUTE FUNCTION generate_guest_id();