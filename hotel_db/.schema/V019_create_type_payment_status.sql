CREATE TYPE payment_status AS ENUM (
	'Paid', 
	'Refunded', 
	'Pending', 
	'Partially_paid'
);