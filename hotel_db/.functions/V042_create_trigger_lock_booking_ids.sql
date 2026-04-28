CREATE TRIGGER lock_booking_ids
BEFORE UPDATE ON bookings
FOR EACH ROW
EXECUTE FUNCTION block_id_updates();