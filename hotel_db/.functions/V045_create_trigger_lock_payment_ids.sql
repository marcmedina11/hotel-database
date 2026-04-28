CREATE TRIGGER lock_payment_ids
BEFORE UPDATE ON payments
FOR EACH ROW
EXECUTE FUNCTION block_id_updates();