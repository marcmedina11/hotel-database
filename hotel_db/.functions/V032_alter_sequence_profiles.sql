ALTER SEQUENCE profiles_seq RESTART WITH 40;

CREATE OR REPLACE FUNCTION generate_profile_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.profile_id := 'P' || LPAD(nextval('profiles_seq')::text, 3, '0');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;