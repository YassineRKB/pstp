-- Drop and create the database, and grant privileges
DROP DATABASE IF EXISTS db_dev;
CREATE DATABASE IF NOT EXISTS db_dev;
CREATE USER IF NOT EXISTS 'dev_usr'@'localhost' IDENTIFIED BY 'dev_pwd';
GRANT ALL PRIVILEGES ON `db_dev`.* TO 'dev_usr'@'localhost';
GRANT SELECT ON `performance_schema`.* TO 'dev_usr'@'localhost';
FLUSH PRIVILEGES;

-- Use the created database
USE db_dev;

-- Create tables for the models

-- Pet table
CREATE TABLE allpets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    serial VARCHAR(100) UNIQUE NOT NULL,
    pet_name VARCHAR(100) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    pet_type VARCHAR(20) NOT NULL,
    pet_status VARCHAR(20),
    background_story TEXT,
    medical_history JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert dummy records into the Pet table
INSERT INTO allpets (serial, pet_name, gender, pet_type, pet_status, background_story, medical_history, created_at)
VALUES
    ('123ABC', 'Fluffy', 'male', 'cat', 'not adopted', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', '{"checkups": ["checkup1", "checkup2"]}', CURRENT_TIMESTAMP),
    ('456DEF', 'Buddy', 'female', 'dog', 'adopted', 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '{"checkups": ["checkup3"]}', CURRENT_TIMESTAMP),
    ('789GHI', 'Max', 'male', 'cat', 'not adopted', 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', '{"checkups": ["checkup4"]}', CURRENT_TIMESTAMP),
    ('ABC123', 'Snowball', 'female', 'cat', 'not adopted', 'Aliquip ex ea commodo consequat.', '{"checkups": ["checkup5"]}', CURRENT_TIMESTAMP),
    ('DEF456', 'Rocky', 'male', 'dog', 'not adopted', 'Sunt in culpa qui officia deserunt mollit anim id est laborum.', '{"checkups": ["checkup6"]}', CURRENT_TIMESTAMP),
    ('GHI789', 'Luna', 'female', 'cat', 'adopted', 'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.', '{"checkups": ["checkup7"]}', CURRENT_TIMESTAMP);

-- Medical History table
CREATE TABLE medic_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pet_id INT NOT NULL,
    checkup_timestamp TIMESTAMP NOT NULL,
    checkup_summary TEXT,
    FOREIGN KEY (pet_id) REFERENCES allpets(id)
);

-- Insert dummy records into the Medical History table
INSERT INTO medic_history (pet_id, checkup_timestamp, checkup_summary)
VALUES
    (1, '2023-01-15 08:00:00', 'Routine checkup for male cat Fluffy'),
    (2, '2023-02-20 10:30:00', 'Follow-up checkup for female dog Buddy'),
    (3, '2023-03-25 11:45:00', 'Initial health check for male cat Max'),
    (5, '2023-04-30 14:00:00', 'Vaccination for male dog Rocky'),
    (2, '2023-05-10 09:30:00', 'Deworming for female dog Buddy');

-- Client table
CREATE TABLE allclients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(100) NOT NULL,
    client_email VARCHAR(100) NOT NULL,
    client_phone VARCHAR(20) NOT NULL,
    pet_serial VARCHAR(100),  -- Added the pet_serial column
    pet_id INT,  -- Adjusted for association with pets
    pet_type VARCHAR(20),
    gender VARCHAR(10),
    checked_in_timestamp TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pet_id) REFERENCES allpets(id)
);

-- Insert dummy records into the Client table
INSERT INTO allclients (client_name, client_email, client_phone, pet_id, pet_type, gender, checked_in_timestamp)
VALUES
    ('John Doe', 'john@example.com', '+123456789', 1, 'cat', 'male', '2023-01-01 09:00:00'),
    ('Jane Smith', 'jane@example.com', '+987654321', 2, 'dog', 'female', '2023-02-05 11:30:00'),
    ('Alice Johnson', 'alice@example.com', '+1122334455', NULL, NULL, NULL, '2023-03-10 15:45:00'),
    ('Bob Anderson', 'bob@example.com', '+9988776655', 4, 'cat', 'male', '2023-04-15 08:00:00'),
    ('Emily Clark', 'emily@example.com', '+5544332211', 5, 'dog', 'female', '2023-05-20 10:00:00');

-- Blog table (unchanged)
CREATE TABLE allblogs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    body TEXT NOT NULL,
    short_description VARCHAR(200),
    author VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert dummy records into the Blog table (unchanged)
INSERT INTO allblogs (title, body, short_description, author)
VALUES
    ('First Blog Post', 'This is the content of the first blog post.', 'First post.', 'John Doe'),
    ('Second Blog Post', 'This is the content of the second blog post.', 'Second post.', 'Jane Smith'),
    ('Third Blog Post', 'This is the content of the third blog post.', 'Third post.', 'Alice Johnson'),
    ('Fourth Blog Post', 'This is the content of the fourth blog post.', 'Fourth post.', 'Bob Anderson'),
    ('Fifth Blog Post', 'This is the content of the fifth blog post.', 'Fifth post.', 'Emily Clark');

-- Shelter Overview table (unchanged)
CREATE TABLE shelter_overview (
    id INT AUTO_INCREMENT PRIMARY KEY,
    total_regi_pets INT DEFAULT 0,
    total_food INT DEFAULT 0,
    total_checkup INT DEFAULT 0,
    total_clients INT DEFAULT 0,
    total_users INT DEFAULT 0,
    total_blogs INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
