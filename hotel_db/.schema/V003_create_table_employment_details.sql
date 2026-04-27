DROP TABLE IF EXISTS employment_details CASCADE;
CREATE TABLE employment_details (
    employee_id 			VARCHAR(20) 		PRIMARY KEY,
    profile_id 				VARCHAR(20) 		NOT NULL REFERENCES profiles(profile_id),
    hire_date 				DATE 				NOT NULL,
    job_title 				VARCHAR(50) 		NOT NULL,
    position_level 			VARCHAR(20) 		NOT NULL,
    emp_type 				EMPLOYMENT_TYPE 	NOT NULL,
    status 					EMPLOYMENT_STATUS 	NOT NULL,
    shift 					WORK_SHIFT 			NOT NULL,
    is_active 				BOOLEAN 			NOT NULL
);