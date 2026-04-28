ALTER SEQUENCE bookings_seq RESTART WITH 9574;

CREATE OR REPLACE FUNCTION generate_booking_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.booking_id := 'BOOKINGID-' || LPAD(nextval('bookings_seq')::text, 4, '0');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;