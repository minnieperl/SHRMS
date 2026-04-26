-- ============================================
-- Smart HRMS - Full Schema + Seed Data
-- ============================================

CREATE DATABASE IF NOT EXISTS smart_HRMS;
USE smart_HRMS;

CREATE TABLE IF NOT EXISTS role (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50) UNIQUE NOT NULL
);

INSERT IGNORE INTO role(role_name) VALUES ('EMPLOYEE'),('MANAGER'),('HR'),('ADMIN');

CREATE TABLE IF NOT EXISTS department (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50) UNIQUE NOT NULL
);

INSERT IGNORE INTO department(department_name) VALUES
('Engineering'),('Human Resources'),('Finance'),('Marketing'),('Operations'),('Sales');

CREATE TABLE IF NOT EXISTS employee (
    employee_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    employee_code VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    role_id INT,
    department_id INT,
    manager_id BIGINT,
    joining_date DATE,
    base_salary DECIMAL(10,2),
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    photo_path VARCHAR(255),
    password VARCHAR(255),
    FOREIGN KEY(role_id) REFERENCES role(role_id),
    FOREIGN KEY(department_id) REFERENCES department(department_id),
    FOREIGN KEY(manager_id) REFERENCES employee(employee_id)
);

-- Default ADMIN: admin@hrms.com / admin123
INSERT IGNORE INTO employee
    (employee_code, first_name, last_name, email, phone, role_id, department_id, joining_date, base_salary, status, password)
VALUES
    ('EMP0001','Admin','User','admin@hrms.com','9876543210',
     (SELECT role_id FROM role WHERE role_name='ADMIN'),
     (SELECT department_id FROM department WHERE department_name='Human Resources'),
     CURDATE(), 100000.00, 'ACTIVE',
     '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhy');

CREATE TABLE IF NOT EXISTS attendance (
    attendance_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    employee_id BIGINT NOT NULL,
    attendance_date DATE NOT NULL,
    check_in_time DATETIME,
    check_out_time DATETIME,
    photo_path VARCHAR(255),
    status VARCHAR(20),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    UNIQUE (employee_id, attendance_date)
);

CREATE TABLE IF NOT EXISTS leave_request (
    leave_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    employee_id BIGINT NOT NULL,
    leave_type VARCHAR(20),
    start_date DATE,
    end_date DATE,
    reason VARCHAR(255),
    status VARCHAR(20),
    approved_by BIGINT,
    FOREIGN KEY(employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY(approved_by) REFERENCES employee(employee_id)
);

CREATE TABLE IF NOT EXISTS task (
    task_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    description TEXT,
    assigned_to BIGINT,
    assigned_by BIGINT,
    priority VARCHAR(20),
    deadline DATE,
    status VARCHAR(20),
    FOREIGN KEY(assigned_to) REFERENCES employee(employee_id),
    FOREIGN KEY(assigned_by) REFERENCES employee(employee_id)
);

CREATE TABLE IF NOT EXISTS meeting (
    meeting_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    scheduled_at DATETIME,
    created_by BIGINT,
    FOREIGN KEY(created_by) REFERENCES employee(employee_id)
);

CREATE TABLE IF NOT EXISTS meeting_attendee (
    meeting_id BIGINT,
    employee_id BIGINT,
    PRIMARY KEY (meeting_id, employee_id),
    FOREIGN KEY (meeting_id) REFERENCES meeting(meeting_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE IF NOT EXISTS mom (
    mom_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    meeting_id BIGINT,
    notes TEXT,
    FOREIGN KEY (meeting_id) REFERENCES meeting(meeting_id)
);

CREATE TABLE IF NOT EXISTS performance (
    performance_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    employee_id BIGINT,
    rating INT,
    attendance_score INT,
    task_score INT,
    remarks VARCHAR(255),
    period VARCHAR(20),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE IF NOT EXISTS payroll (
    payroll_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    employee_id BIGINT,
    salary_month VARCHAR(20),
    base_salary DECIMAL(10,2),
    deductions DECIMAL(10,2),
    bonus DECIMAL(10,2),
    net_salary DECIMAL(10,2),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    UNIQUE (employee_id, salary_month)
);

CREATE TABLE IF NOT EXISTS holiday (
    holiday_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    holiday_date DATE UNIQUE,
    holiday_name VARCHAR(100),
    holiday_type VARCHAR(20)
);

-- Sample holidays
INSERT IGNORE INTO holiday (holiday_date, holiday_name, holiday_type) VALUES
('2025-01-26', 'Republic Day', 'NATIONAL'),
('2025-03-14', 'Holi', 'NATIONAL'),
('2025-04-14', 'Dr. Ambedkar Jayanti', 'NATIONAL'),
('2025-08-15', 'Independence Day', 'NATIONAL'),
('2025-10-02', 'Gandhi Jayanti', 'NATIONAL'),
('2025-11-01', 'Diwali', 'NATIONAL'),
('2025-12-25', 'Christmas', 'NATIONAL');
