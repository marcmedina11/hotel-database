CREATE SEQUENCE payments_seq START 9819;

CREATE OR REPLACE FUNCTION generate_payments_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.payment_id := 'PAYMENTID-' || LPAD(nextval('payments_seq')::text, 4, '0');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER payments_id_trigger
BEFORE INSERT ON payments
FOR EACH ROW
EXECUTE FUNCTION generate_payments_id();