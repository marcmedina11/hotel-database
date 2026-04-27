CREATE SEQUENCE profiles_seq START 40;

CREATE OR REPLACE FUNCTION generate_profile_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.profile_id := 'P' || LPAD(nextval('profiles_seq')::text, 1, '0');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER profiles_id_trigger
BEFORE INSERT ON profiles
FOR EACH ROW
EXECUTE FUNCTION generate_profile_id();