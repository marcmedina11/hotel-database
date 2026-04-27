DROP TABLE IF EXISTS guests CASCADE;
CREATE TABLE guests (
	guest_id				VARCHAR(20)			PRIMARY KEY,
	profile_id				VARCHAR(20)			NOT NULL REFERENCES profiles(profile_id),
	guest_type				VARCHAR(50)			NOT NULL,
	is_member				BOOLEAN				NOT NULL
);