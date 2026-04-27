CREATE SEQUENCE bookings_seq START 1;

CREATE OR REPLACE FUNCTION generate_booking_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.booking_id := 'BOOKINGID-' || LPAD(nextval('bookings_seq')::text, 4, '0');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER bookings_id_trigger
BEFORE INSERT ON bookings
FOR EACH ROW
EXECUTE FUNCTION generate_booking_id();