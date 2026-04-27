CREATE SEQUENCE rooms_seq START 1;

CREATE OR REPLACE FUNCTION generate_room_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.room_id := 'ROOMID-' || LPAD(nextval('rooms_seq')::text, 3, '0');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER rooms_id_trigger
BEFORE INSERT ON rooms
FOR EACH ROW
EXECUTE FUNCTION generate_room_id();