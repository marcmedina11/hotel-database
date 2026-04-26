CREATE TYPE payment_type AS ENUM (
	'Partial', 
	'Full payment', 
	'Settlement')
;
CREATE TYPE payment_method AS ENUM (
	'Cash', 
	'Online', 
	'Credit_card')
;
CREATE TYPE payment_status AS ENUM (
	'Paid', 
	'Refunded', 
	'Pending', 
	'Partially_paid')
;
CREATE TABLE payments (
    payment_id character varying(20) NOT NULL,
    booking_id character varying(20) NOT NULL,
    payment_date date NOT NULL,
    payment_type payment_type NOT NULL,
    payment_method payment_method NOT NULL,
    payment_amount numeric(10,2) NOT NULL,
    total_discount numeric(10,2) NOT NULL,
    status payment_status NOT NULL)
;
CREATE SEQUENCE room_seq START 1;
CREATE OR REPLACE FUNCTION set_room_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.room_id := 'ROOMID-' || LPAD(nextval('room_seq')::text, 4, '0');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trg_room_id
BEFORE INSERT ON rooms
FOR EACH ROW
EXECUTE FUNCTION set_room_id()
;
CREATE TYPE availability_status AS ENUM ('available', 'occupied')
;
CREATE TABLE rooms (
    room_id character varying(20) NOT NULL,
    room_number integer NOT NULL,
    room_size character varying(50) NOT NULL,
    room_capacity character varying(10) NOT NULL,
    price_per_night numeric(10,2) NOT NULL,
    status availability_status NOT NULL)
;
ALTER TABLE rooms
ALTER COLUMN room_id DROP NOT NULL
;
ALTER TABLE rooms
ALTER COLUMN room_id SET NOT NULL
;
ALTER TABLE rooms
ADD COLUMN room_description character varying(50) NOT NULL
;
CREATE TYPE gender_enum AS ENUM (
	'male', 
	'female')
;
CREATE TYPE marital_enum AS ENUM (
	'married', 
	'single')
;
CREATE TABLE profiles (
    profile_id character varying(20) NOT NULL,
    last_name character varying(100) NOT NULL,
    first_name character varying(100) NOT NULL,
    date_of_birth date NOT NULL,
    gender gender_enum NOT NULL,
    marital_status marital_enum NOT NULL,
    contact_number character varying(20) NOT NULL,
    profile_type character varying(50) NOT NULL)
;
CREATE TYPE work_shift AS ENUM (
	'Night', 
	'Mid', 
	'Day')
;
CREATE TYPE employment_type AS ENUM (
	'Full-time', 
	'Part-time', 
	'Contractual',
	'Permanent')
;
ALTER TYPE employment_type RENAME VALUE 'contractualpermanent' TO 'Contractual';
ALTER TYPE employment_type ADD VALUE 'Permanent';

CREATE TYPE employment_status AS ENUM (
	'Regular', 
	'Separated', 
	'Probation')
;
CREATE TABLE employment_details (
    employee_id character varying(20) NOT NULL,
    profile_id character varying(20) NOT NULL,
    hire_date date NOT NULL,
    job_title character varying(50) NOT NULL,
    position_level character varying(20) NOT NULL,
    emp_type employment_type NOT NULL,
    status employment_status NOT NULL,
    shift work_shift NOT NULL,
    is_active boolean NOT NULL)
;
CREATE TYPE booking_status AS ENUM (
	'confirmed', 
	'checked_in', 
	'no_show', 
	'cancelled')
;

CREATE TABLE bookings (
    booking_id character varying(20) NOT NULL,
    number_of_guests integer NOT NULL,
    guest_id character varying(20) NOT NULL,
    room_id character varying(20),
    status booking_status NOT NULL,
    employee_id character varying(20) NOT NULL,
    check_in_date date NOT NULL,
    check_out_date date)
;

INSERT INTO bookings (booking_id, number_of_guests, guest_id, room_id, status, employee_id, check_in_date, check_out_date) 
VALUES 
('BOOKINGID-3451', 1, 'GUEST-8161', 'ROOMID-3648', 'checked_in', 'EMP001', '2026-02-19', '2026-02-21'),
('BOOKINGID-8663', 3, 'GUEST-9165', 'ROOMID-1561', 'confirmed', 'EMP003', '2026-02-19', '2026-02-21'),
('BOOKINGID-1507', 4, 'GUEST-5252', 'ROOMID-9414', 'checked_in', 'EMP004', '2026-03-26', '2026-02-08'),
('BOOKINGID-9157', 1, 'GUEST-4701', 'ROOMID-5494', 'checked_in', 'EMP005', '2026-03-26', '2026-03-28'),
('BOOKINGID-6278', 1, 'GUEST-1240', 'ROOMID-4712', 'checked_in', 'EMP006', '2026-03-26', '2026-03-28'),
('BOOKINGID-5678', 1, 'GUEST-1134', 'ROOMID-4934', 'confirmed', 'EMP005', '2026-03-10', '2026-03-12'),
('BOOKINGID-1993', 1, 'GUEST-1286', 'ROOMID-5494', 'confirmed', 'EMP003', '2026-03-10', '2026-03-12'),
('BOOKINGID-5836', 3, 'GUEST-4441', 'ROOMID-5596', 'checked_in', 'EMP003', '2026-03-21', '2026-03-23'),
('BOOKINGID-5363', 2, 'GUEST-1851', 'ROOMID-2269', 'confirmed', 'EMP003', '2026-02-25', '2026-02-27'),
('BOOKINGID-8072', 5, 'GUEST-1790', 'ROOMID-4687', 'confirmed', 'EMP005', '2026-03-24', '2026-03-26'),
('BOOKINGID-4598', 1, 'GUEST-3953', 'ROOMID-5494', 'confirmed', 'EMP005', '2026-02-06', '2026-02-08'),
('BOOKINGID-3391', 3, 'GUEST-5337', 'ROOMID-9671', 'checked_in', 'EMP005', '2026-02-19', '2026-02-21'),
('BOOKINGID-9573', 2, 'GUEST-3245', 'ROOMID-9261', 'confirmed', 'EMP003', '2026-02-19', '2026-02-21'),
('BOOKINGID-6279', 2, 'GUEST-1403', 'ROOMID-4119', 'confirmed', 'EMP003', '2026-02-23', '2026-02-25'),
('BOOKINGID-2896', 3, 'GUEST-6504', 'ROOMID-4818', 'confirmed', 'EMP001', '2026-02-24', '2026-02-26'),
('BOOKINGID-9548', 3, 'GUEST-6665', 'ROOMID-2269', 'confirmed', 'EMP003', '2026-02-17', '2026-02-19'),
('BOOKINGID-2718', 1, 'GUEST-9061', 'ROOMID-9261', 'checked_in', 'EMP003', '2026-03-07', '2026-03-08'),
('BOOKINGID-6948', 2, 'GUEST-2189', 'ROOMID-9261', 'checked_in', 'EMP003', '2026-03-17', '2026-03-18'),
('BOOKINGID-4633', 2, 'GUEST-6527', 'ROOMID-1750', 'checked_in', 'EMP001', '2026-03-15', '2026-03-19'),
('BOOKINGID-1361', 1, 'GUEST-6617', 'ROOMID-9261', 'checked_in', 'EMP005', '2026-03-14', '2026-03-16'),
('BOOKINGID-6476', 3, 'GUEST-6421', 'ROOMID-3138', 'confirmed', 'EMP005', '2026-03-17', '2026-03-19'),
('BOOKINGID-6291', 1, 'GUEST-6230', 'ROOMID-5494', 'confirmed', 'EMP001', '2026-02-22', '2026-02-24'),
('BOOKINGID-8024', 2, 'GUEST-2157', 'ROOMID-9261', 'confirmed', 'EMP001', '2026-03-06', '2026-03-08'),
('BOOKINGID-4563', 2, 'GUEST-2913', 'ROOMID-4119', 'confirmed', 'EMP001', '2026-03-17', '2026-03-19');

INSERT INTO profiles (profile_id, last_name, first_name, date_of_birth, gender, marital_status, contact_number, profile_type)
VALUES 
('P001', 'Cruz', 'Juan', '1990-02-05', 'Male', 'married', '9463356694', 'member_guest'),
('P002', 'Santos', 'Maria', '1995-06-09', 'Male', 'married', '9850037269', 'guest'),
('P003', 'Reyes', 'Jose', '1991-04-06', 'Male', 'single', '9419901876', 'guest'),
('P004', 'Villanueva', 'Ana', '1992-07-05', 'Female', 'single', '9487379577', 'guest'),
('P005', 'Mendoza', 'Carlo', '1992-07-06', 'Male', 'single', '9923246233', 'guest'),
('P006', 'Dela Cruz', 'Sofia', '1998-04-23', 'Male', 'married', '9707710020', 'guest'),
('P007', 'Navarro', 'Miguel', '1992-09-30', 'Male', 'single', '9920813453', 'guest'),
('P008', 'Flores', 'Isabel', '1992-02-11', 'Male', 'single', '9475918908', 'member_guest'),
('P009', 'Ramos', 'Danie', '1992-02-05', 'Male', 'married', '9940092566', 'guest'),
('P010', 'Bautista', 'Camille', '1990-02-05', 'Male', 'married', '9553768583', 'guest'),
('P011', 'Torres', 'Adrian', '1990-02-05', 'Female', 'married', '9738200603', 'guest'),
('P012', 'Garcia', 'Patric', '1974-05-08', 'Male', 'single', '9547846113', 'member_guest'),
('P013', 'Hernandez', 'Luis', '1985-09-11', 'Female', 'single', '9257772480', 'member_guest'),
('P014', 'Morales', 'Andrea', '1990-02-05', 'Female', 'single', '9648976217', 'guest'),
('P015', 'Castillo', 'Gabriel', '1990-02-05', 'Female', 'married', '9309701238', 'guest'),
('P016', 'Aquino', 'Claris', '1990-02-05', 'Female', 'single', '9236632807', 'guest'),
('P017', 'Salazar', 'Marco', '1990-02-05', 'Male', 'single', '9727654418', 'guest'),
('P018', 'Domingu', 'Kristin', '1994-07-09', 'Male', 'married', '9658227319', 'guest'),
('P019', 'Ortega', 'Rafael', '1990-02-05', 'Female', 'single', '9798864591', 'guest'),
('P020', 'Vergara', 'Elaine', '1984-03-02', 'Male', 'single', '9530924960', 'guest'),
('P021', 'Lozano', 'Victor', '1990-02-05', 'Male', 'single', '9942680574', 'guest'),
('P022', 'Santiago', 'Angela', '1990-02-05', 'Male', 'single', '9156636578', 'guest'),
('P023', 'Cabrera', 'Enrique', '1999-08-26', 'Female', 'married', '9462691941', 'guest'),
('P024', 'Valdez', 'Monica', '1980-02-04', 'Male', 'single', '9685608119', 'guest'),
('P025', 'Buenavista', 'Lorenzo', '1980-02-05', 'Female', 'single', '9685608119', 'employee'),
('P026', 'Mitzel', 'Abby', '1980-02-06', 'Female', 'single', '9685608119', 'employee'),
('P027', 'Gomen', 'Frado', '1980-02-07', 'Female', 'single', '9685608119', 'employee'),
('P028', 'Valdez', 'Gabriel', '1980-02-08', 'Male', 'married', '9685608119', 'employee'),
('P029', 'Santos', 'Warren', '1980-02-09', 'Male', 'single', '9685608119', 'employee'),
('P030', 'Aquino', 'Bren', '1980-02-10', 'Male', 'single', '9685608119', 'employee'),
('P031', 'Concho', 'Mary Jane', '1980-02-11', 'Female', 'single', '9685608119', 'employee'),
('P032', 'Lozarta', 'Franz', '1980-02-12', 'Male', 'single', '9685608119', 'employee'),
('P033', 'Hsia', 'Sebastian', '1980-02-13', 'Male', 'married', '9685608119', 'employee'),
('P034', 'Valdez', 'Andrea', '1980-02-14', 'Female', 'married', '9685608119', 'employee'),
('P035', 'Almoroto', 'Paul', '1980-02-15', 'Male', 'married', '9685608119', 'employee'),
('P036', 'Medina', 'Marco', '1980-02-16', 'Male', 'married', '9685608119', 'employee'),
('P037', 'Diamante', 'Nasser', '1980-02-17', 'Female', 'single', '9685608119', 'employee'),
('P038', 'Amapter', 'Jhobert', '1980-02-18', 'Female', 'married', '9685608119', 'employee'),
('P039', 'Bona', 'Mariz', '1980-02-19', 'Female', 'single', '9685608119', 'employee')
;
--
-- TOC entry 5036 (class 0 OID 18826)
-- Dependencies: 221
-- Data for Name: employment_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO employment_details (employee_id, profile_id, hire_date, job_title, position_level, emp_type, status, shift, is_active)
VALUES 
('EMP001', 'P025', '2020-02-05', 'Receptionist', 'Associate', 'Permanent', 'regular', 'Night', true),
('EMP002', 'P026', '2021-03-05', 'General Manager', 'Manager', 'Permanent', 'regular', 'Night', true),
('EMP003', 'P027', '2026-04-04', 'Receptionist', 'Associate', 'Permanent', 'regular', 'Night', true),
('EMP004', 'P028', '2023-02-03', 'Receptionist', 'Associate', 'Permanent', 'regular', 'Day', true),
('EMP005', 'P029', '2022-02-04', 'Receptionist', 'Associate', 'Permanent', 'regular', 'Day', true),
('EMP006', 'P030', '2022-02-05', 'Receptionist', 'Associate', 'Permanent', 'regular', 'Mid', true),
('EMP007', 'P031', '2021-05-22', 'Admin Assistant', 'Associate', 'Permanent', 'regular', 'Day', true),
('EMP008', 'P032', '2021-05-23', 'House Keeper', 'Associate', 'Permanent', 'regular', 'Night', true),
('EMP009', 'P033', '2021-03-19', 'House Keeper', 'Associate', 'Permanent', 'regular', 'Night', true),
('EMP010', 'P034', '2021-03-20', 'House Keeper', 'Associate', 'Permanent', 'regular', 'Day', true),
('EMP011', 'P035', '2021-03-21', 'Admin Assistant', 'Associate', 'Permanent', 'regular', 'Day', true),
('EMP012', 'P036', '2021-03-22', 'House Keeper', 'Associate', 'Permanent', 'regular', 'Night', true),
('EMP013', 'P037', '2021-03-23', 'House Keeper', 'Associate', 'Permanent', 'regular', 'Day', true),
('EMP014', 'P038', '2021-03-24', 'House Keeper', 'Associate', 'Permanent', 'regular', 'Night', true),
('EMP015', 'P039', '2021-03-25', 'House Keeper', 'Associate', 'Permanent', 'regular', 'Mid', true);

INSERT INTO guests (guest_id, profile_id, guest_type, is_member) 
VALUES 
('GUEST-8161', 'P001', 'check-in proxy', false),
('GUEST-9165', 'P002', 'reservation holder', false),
('GUEST-5252', 'P003', 'reservation holder', false),
('GUEST-4701', 'P004', 'reservation holder', false),
('GUEST-1240', 'P005', 'reservation holder', true),
('GUEST-1134', 'P006', 'reservation holder', false),
('GUEST-1286', 'P007', 'reservation holder', false),
('GUEST-4441', 'P008', 'check-in proxy', false),
('GUEST-1851', 'P009', 'check-in proxy', false),
('GUEST-1790', 'P010', 'reservation holder', true),
('GUEST-3953', 'P011', 'reservation holder', false),
('GUEST-5337', 'P012', 'reservation holder', false),
('GUEST-3245', 'P013', 'check-in proxy', false),
('GUEST-1403', 'P014', 'reservation holder', false),
('GUEST-6504', 'P015', 'reservation holder', true),
('GUEST-6665', 'P016', 'reservation holder', false),
('GUEST-9061', 'P017', 'reservation holder', true),
('GUEST-2189', 'P018', 'reservation holder', false),
('GUEST-6527', 'P019', 'check-in proxy', false),
('GUEST-6617', 'P020', 'check-in proxy', false),
('GUEST-6421', 'P021', 'check-in proxy', false),
('GUEST-6230', 'P022', 'check-in proxy', false),
('GUEST-2157', 'P023', 'check-in proxy', false),
('GUEST-2913', 'P024', 'reservation holder', false);

INSERT INTO payments (payment_id, booking_id, payment_date, payment_type, payment_method, payment_amount, total_discount, status)
VALUES 
('PAYMENTID-8745', 'BOOKINGID-3451', '2026-02-19', 'Full payment', 'Cash', 5000.00, 0.00, 'Paid'),
('PAYMENTID-1125', 'BOOKINGID-8663', '2026-02-19', 'Full payment', 'Online', 6200.00, 0.00, 'Paid'),
('PAYMENTID-1869', 'BOOKINGID-1507', '2026-03-26', 'Full payment', 'Cash', 3800.00, 0.00, 'Paid'),
('PAYMENTID-1778', 'BOOKINGID-9157', '2026-03-26', 'Full payment', 'Cash', 2500.00, 0.00, 'Paid'),
('PAYMENTID-7109', 'BOOKINGID-6278', '2026-03-26', 'Full payment', 'Online', 2500.00, 0.00, 'Paid'),
('PAYMENTID-8197', 'BOOKINGID-5678', '2026-03-10', 'Full payment', 'Cash', 5000.00, 0.00, 'Paid'),
('PAYMENTID-7582', 'BOOKINGID-1993', '2026-03-10', 'Full payment', 'Cash', 5000.00, 0.00, 'Paid'),
('PAYMENTID-1780', 'BOOKINGID-5836', '2026-03-21', 'Full payment', 'Online', 6200.00, 0.00, 'Paid'),
('PAYMENTID-4980', 'BOOKINGID-5363', '2026-02-25', 'Full payment', 'Online', 6200.00, 0.00, 'Paid'),
('PAYMENTID-4706', 'BOOKINGID-8072', '2026-03-24', 'Full payment', 'Cash', 7600.00, 0.00, 'Paid'),
('PAYMENTID-4759', 'BOOKINGID-4598', '2026-02-06', 'Full payment', 'Credit_card', 5000.00, 0.00, 'Paid'),
('PAYMENTID-4095', 'BOOKINGID-3391', '2026-02-19', 'Full payment', 'Credit_card', 6200.00, 0.00, 'Paid'),
('PAYMENTID-3850', 'BOOKINGID-9573', '2026-02-19', 'Full payment', 'Credit_card', 5600.00, 0.00, 'Paid'),
('PAYMENTID-2236', 'BOOKINGID-6279', '2026-02-23', 'Full payment', 'Cash', 5600.00, 0.00, 'Paid'),
('PAYMENTID-9802', 'BOOKINGID-2896', '2026-02-24', 'Full payment', 'Cash', 6800.00, 0.00, 'Paid'),
('PAYMENTID-7378', 'BOOKINGID-9548', '2026-02-17', 'Full payment', 'Online', 6200.00, 0.00, 'Paid'),
('PAYMENTID-2940', 'BOOKINGID-2718', '2026-03-07', 'Full payment', 'Cash', 2500.00, 0.00, 'Paid'),
('PAYMENTID-2858', 'BOOKINGID-6948', '2026-03-17', 'Full payment', 'Credit_card', 2500.00, 0.00, 'Paid'),
('PAYMENTID-2136', 'BOOKINGID-4633', '2026-03-15', 'Full payment', 'Cash', 11200.00, 0.00, 'Paid'),
('PAYMENTID-1240', 'BOOKINGID-1361', '2026-03-14', 'Full payment', 'Credit_card', 5000.00, 0.00, 'Paid'),
('PAYMENTID-8838', 'BOOKINGID-6476', '2026-03-17', 'Full payment', 'Cash', 6800.00, 0.00, 'Paid'),
('PAYMENTID-3995', 'BOOKINGID-6291', '2026-02-22', 'Full payment', 'Cash', 5000.00, 0.00, 'Paid'),
('PAYMENTID-5498', 'BOOKINGID-8024', '2026-03-06', 'Full payment', 'Online', 5600.00, 0.00, 'Paid'),
('PAYMENTID-4687', 'BOOKINGID-4563', '2026-03-17', 'Full payment', 'Cash', 5600.00, 0.00, 'Paid');

INSERT INTO rooms (room_id, room_number, room_size, room_capacity, price_per_night, status)
VALUES 
('ROOMID-3648', 101, 'single', '1', 2500.00, 'occupied'),
('ROOMID-2705', 102, 'single', '1', 2500.00, 'available'),
('ROOMID-8283', 103, 'single', '1', 2500.00, 'available'),
('ROOMID-5601', 104, 'single', '1', 2500.00, 'occupied'),
('ROOMID-4712', 105, 'single', '1', 2500.00, 'occupied'),
('ROOMID-1750', 106, 'double', '2', 2800.00, 'occupied'),
('ROOMID-9641', 107, 'double', '2', 2800.00, 'available'),
('ROOMID-9261', 108, 'double', '2', 2800.00, 'occupied'),
('ROOMID-4119', 109, 'double', '2', 2800.00, 'occupied'),
('ROOMID-8178', 110, 'double', '2', 2800.00, 'occupied'),
('ROOMID-9908', 111, 'family', '4-6', 3800.00, 'available'),
('ROOMID-5041', 112, 'family', '4-6', 3800.00, 'occupied'),
('ROOMID-4257', 113, 'family', '4-6', 3800.00, 'occupied'),
('ROOMID-4687', 114, 'family', '4-6', 3800.00, 'occupied'),
('ROOMID-6307', 115, 'family', '4-6', 3800.00, 'occupied'),
('ROOMID-9671', 116, 'deluxe', '2-3', 3100.00, 'occupied'),
('ROOMID-1561', 117, 'deluxe', '2-3', 3100.00, 'occupied'),
('ROOMID-5055', 118, 'deluxe', '2-3', 3100.00, 'available'),
('ROOMID-5596', 119, 'deluxe', '2-3', 3100.00, 'occupied'),
('ROOMID-2269', 120, 'deluxe', '2-3', 3100.00, 'occupied'),
('ROOMID-3138', 121, 'suite', '2-4', 3400.00, 'occupied'),
('ROOMID-2678', 122, 'suite', '2-4', 3400.00, 'occupied'),
('ROOMID-9714', 123, 'suite', '2-4', 3400.00, 'occupied'),
('ROOMID-9024', 124, 'suite', '2-4', 3400.00, 'available'),
('ROOMID-9897', 125, 'suite', '2-4', 3400.00, 'available'),
('ROOMID-6006', 126, 'single', '1', 2500.00, 'available'),
('ROOMID-4934', 127, 'single', '1', 2500.00, 'available'),
('ROOMID-5494', 128, 'single', '1', 2500.00, 'available'),
('ROOMID-9414', 129, 'suite', '2-4', 3400.00, 'available'),
('ROOMID-4818', 130, 'suite', '2-4', 3400.00, 'occupied'),
('ROOMID-2430', 131, 'suite', '2-4', 3400.00, 'occupied'),
('ROOMID-9008', 132, 'deluxe', '2-3', 3100.00, 'available'),
('ROOMID-8965', 133, 'deluxe', '2-3', 3100.00, 'occupied'),
('ROOMID-8839', 134, 'deluxe', '2-3', 3100.00, 'available'),
('ROOMID-5451', 135, 'family', '4-6', 3800.00, 'available');

UPDATE rooms
SET room_description = 'river_view'
WHERE room_size = 'family';

UPDATE rooms
SET room_description = 'sunset_view'
WHERE room_size = 'deluxe';

UPDATE rooms
SET room_description = 'sea_view'
WHERE room_size = 'suite';

UPDATE rooms
SET room_description = 'standard_view'
WHERE room_size = 'double';

UPDATE rooms
SET room_description = 'standard_view'
WHERE room_size = 'single';

DELETE FROM bookings
USING employment_details b
WHERE a.ctid < b.ctid
  AND a.job_title = b.job_title;

DELETE FROM bookings
WHERE ctid = '(0,1)';

WITH duplicates AS (
    SELECT ctid,
           ROW_NUMBER() OVER (
               PARTITION BY room_id
               ORDER BY room_id
           ) AS row_num
    FROM rooms
)
DELETE FROM rooms
WHERE ctid IN (
    SELECT ctid
    FROM duplicates
    WHERE row_num > 1
);

UPDATE rooms
SET room_capacity = '1'
WHERE room_id = 'ROOMID-6006';

WITH duplicates AS (
    SELECT ctid,
           ROW_NUMBER() OVER (
               PARTITION BY payment_id
               ORDER BY payment_id
           ) AS row_num
    FROM payments
)
DELETE FROM payments
WHERE ctid IN (
    SELECT ctid
    FROM duplicates
    WHERE row_num > 1
);

WITH duplicates AS (
    SELECT ctid,
           ROW_NUMBER() OVER (
               PARTITION BY guest_id
               ORDER BY guest_id
           ) AS row_num
    FROM guests
)
DELETE FROM guests
WHERE ctid IN (
    SELECT ctid
    FROM duplicates
    WHERE row_num > 1
);

ALTER TABLE employment_details
ADD CONSTRAINT bookings_pkey PRIMARY KEY (employee_id);

ALTER TABLE guests
ADD CONSTRAINT guests_pkey PRIMARY KEY (guest_id);

ALTER TABLE payments
ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);

ALTER TABLE profiles
ADD CONSTRAINT profiles_pkey PRIMARY KEY (profile_id);

ALTER TABLE rooms
ADD CONSTRAINT rooms_pkey PRIMARY KEY (room_id);

ALTER TABLE employment_details DROP CONSTRAINT bookings_pkey;

ALTER TABLE employment_details
ADD CONSTRAINT employment_details_pkey PRIMARY KEY (employee_id);

--- TEST GIT PUSH

INSERT INTO rooms (room_number, room_size, room_capacity, price_per_night, status)
VALUES 
(101, 'test', '1', 2500.00, 'occupied');