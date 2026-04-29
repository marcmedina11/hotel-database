CREATE OR REPLACE FUNCTION block_payment_id_updates()
RETURNS TRIGGER AS $$
BEGIN

    IF NEW.payment_id IS DISTINCT FROM OLD.payment_id THEN
        RAISE EXCEPTION 'gagi ka wag mo baguhin to';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_payment_id_update
BEFORE UPDATE ON payments
FOR EACH ROW
EXECUTE FUNCTION block_payment_id_updates();