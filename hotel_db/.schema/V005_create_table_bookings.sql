DROP TABLE IF EXISTS bookings CASCADE;
CREATE TABLE bookings (
    booking_id 				VARCHAR(20) 		PRIMARY KEY,
    number_of_guests 		INTEGER				NOT NULL,
    guest_id 				VARCHAR(20) 		NOT NULL REFERENCES guests(guest_id),
    room_id 				VARCHAR(20) 		NOT NULL REFERENCES rooms(room_id),
    status 					BOOKING_STATUS 		NOT NULL,
    employee_id 			VARCHAR(20) 				 REFERENCES employment_details(employee_id),
    check_in_date 			DATE 				NOT NULL,
    check_out_date 			DATE
);