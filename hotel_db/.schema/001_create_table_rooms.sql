CREATE TABLE rooms (
    room_id character varying(20) PRIMARY KEY,
    room_number integer NOT NULL,
    room_size character varying(50) NOT NULL,
    room_capacity character varying(10) NOT NULL,
    price_per_night numeric(10,2) NOT NULL,
    status availability_status NOT NULL,
	room_description character varying(50) NOT NULL
);