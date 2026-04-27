DROP TABLE IF EXISTS rooms CASCADE;
CREATE TABLE rooms (
    room_id 				VARCHAR(20) 		PRIMARY KEY,
    room_number 			INTEGER 			NOT NULL,
    room_size 				VARCHAR(50) 		NOT NULL,
    room_capacity 			VARCHAR(10) 		NOT NULL,
    price_per_night 		NUMERIC(10,2) 		NOT NULL,
    status 					AVAILABILITY_STATUS NOT NULL,
	room_description 		VARCHAR(50) 		NOT NULL
);