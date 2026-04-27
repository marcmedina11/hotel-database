DROP TABLE IF EXISTS payments CASCADE;
CREATE TABLE payments (
    payment_id 				VARCHAR(20) 		PRIMARY KEY,
    booking_id 				VARCHAR(20) 		NOT NULL REFERENCES bookings(booking_id),
    payment_date 			DATE 				NOT NULL,
    payment_type 			PAYMENT_TYPE		NOT NULL,
    payment_method 			PAYMENT_METHOD 		NOT NULL,
    payment_amount 			NUMERIC(10,2) 		NOT NULL,
    total_discount 			NUMERIC(10,2) 		NOT NULL,
    status 					PAYMENT_STATUS 		NOT NULL
);