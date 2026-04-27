CREATE SEQUENCE payments_seq START 1;

CREATE OR REPLACE FUNCTION generate_payment_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.payment_id := 'PAYMENTID-' || LPAD(nextval('payments_seq')::text, 3, '0');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER payments_id_trigger
BEFORE INSERT ON payments
FOR EACH ROW
EXECUTE FUNCTION generate_payment_id();