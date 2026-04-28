ALTER SEQUENCE rooms_seq RESTART WITH 9909;

CREATE OR REPLACE FUNCTION generate_room_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.room_id := 'ROOMID-' || LPAD(nextval('rooms_seq')::text, 4, '0');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;