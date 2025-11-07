create database contact_managment_system;
use contact_managment_system;
CREATE TABLE contact (
    contact_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    gender CHAR(1),
    age INT CHECK (age >= 0),
    phone_no VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100),
    city VARCHAR(50)
);

-- Insert sample data into Contact
INSERT INTO contact (name, gender, age, phone_no, email, city) VALUES
('Ravi Kumar', 'M', 28, '9876543210', 'ravi.kumar@email.com', 'Delhi'),
('Sneha Patel', 'F', 25, '9876501234', 'sneha.patel@email.com', 'Mumbai'),
('Amit Singh', 'M', 35, '9785612309', 'amit.singh@email.com', 'Chennai'),
('Neha Verma', 'F', 30, '9876549988', 'neha.verma@email.com', 'Kolkata');

SELECT * FROM contact;

-- Create Group Table
CREATE TABLE contact_group (
    group_id INT PRIMARY KEY AUTO_INCREMENT,
    group_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(100)
);

-- Insert sample data into Group Table
INSERT INTO contact_group (group_name, description) VALUES
('Family', 'Family members and relatives'),
('Friends', 'Close and personal friends'),
('Work', 'Office and professional contacts');

SELECT * FROM contact_group;

-- Create Mapping Table
CREATE TABLE contact_group_mapping (
    mapping_id INT PRIMARY KEY AUTO_INCREMENT,
    contact_id INT,
    group_id INT,
    FOREIGN KEY (contact_id) REFERENCES contact(contact_id),
    FOREIGN KEY (group_id) REFERENCES contact_group(group_id)
);

-- Create Communication Log Table
CREATE TABLE communication_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    contact_id INT,
    communication_type VARCHAR(20),
    communication_date DATE,
    notes VARCHAR(255),
    FOREIGN KEY (contact_id) REFERENCES contact(contact_id)
);

-- Create Reminder Table
CREATE TABLE reminder (
    reminder_id INT PRIMARY KEY AUTO_INCREMENT,
    contact_id INT,
    reminder_date DATE,
    purpose VARCHAR(255),
    status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (contact_id) REFERENCES contact(contact_id)
);

-- Trigger: Log reminder completion automatically
DELIMITER $$
CREATE TRIGGER log_after_reminder_completion
AFTER UPDATE ON reminder
FOR EACH ROW
BEGIN
    IF NEW.status = 'Completed' AND OLD.status <> 'Completed' THEN
        INSERT INTO communication_log (contact_id, communication_type, communication_date, notes)
        VALUES (NEW.contact_id, 'Follow-up', CURDATE(), CONCAT('Reminder completed: ', NEW.purpose));
    END IF;
END$$
DELIMITER ;

-- Insert sample data into Mapping Table
INSERT INTO contact_group_mapping (contact_id, group_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 2);

SELECT * FROM contact_group_mapping;

-- Insert sample reminders
INSERT INTO reminder (contact_id, reminder_date, purpose, status) VALUES
(1, '2025-11-10', 'Call regarding meeting', 'Pending'),
(2, '2025-11-12', 'Wish HAPPY BIRTHDAY', 'Pending'),
(3, '2025-11-12', 'Revision of SURPRISE TEST', 'Pending');

SELECT * FROM reminder;

-- Update reminder to trigger the communication log
UPDATE reminder
SET status = 'Completed'
WHERE reminder_id = 1;

-- View the communication log after trigger
SELECT * FROM communication_log;

-- View updated reminders
SELECT * FROM reminder;
