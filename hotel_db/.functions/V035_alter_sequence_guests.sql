ALTER SEQUENCE guests_seq RESTART WITH 9166;

CREATE OR REPLACE FUNCTION generate_guest_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.guest_id := 'GUEST-' || LPAD(nextval('guests_seq')::text, 4, '0');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;