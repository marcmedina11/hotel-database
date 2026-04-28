ALTER TABLE guests
ALTER COLUMN guest_type TYPE guest_enum
USING guest_type::guest_enum;
