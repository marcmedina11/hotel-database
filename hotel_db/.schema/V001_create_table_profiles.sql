DROP TABLE IF EXISTS profiles CASCADE;
CREATE TABLE profiles (
    profile_id				VARCHAR(20) 		PRIMARY KEY,
    last_name				VARCHAR(100) 		NOT NULL,
    first_name				VARCHAR(100) 		NOT NULL,
    date_of_birth			DATE 				NOT NULL,
    gender 					GENDER_ENUM 		NOT NULL,
    marital_status 			MARITAL_ENUM 		NOT NULL,
    contact_number 			VARCHAR(20) 		NOT NULL,
    profile_type 			VARCHAR(50) 		NOT NULL
);