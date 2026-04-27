CREATE TABLE payments (
    payment_id character varying(20) PRIMARY KEY,
    booking_id character varying(20) FOREIGN KEY,
    payment_date date NOT NULL,
    payment_type payment_type NOT NULL,
    payment_method payment_method NOT NULL,
    payment_amount numeric(10,2) NOT NULL,
    total_discount numeric(10,2) NOT NULL,
    status payment_status NOT NULL
);