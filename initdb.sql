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
INSERT INTO allpets (serial, pet_name, gender, pet_type, pet_status, background_story, medical_history)
VALUES
    ('123ABC', 'Fluffy', 'male', 'cat', 'not adopted', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', '{"checkups": ["checkup1", "checkup2"]}'),
    ('456DEF', 'Buddy', 'female', 'dog', 'adopted', 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '{"checkups": ["checkup3"]}'),
    ('789GHI', 'Max', 'male', 'cat', 'not adopted', 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', '{"checkups": ["checkup4"]}'),
    ('ABC123', 'Snowball', 'female', 'cat', 'not adopted', 'Aliquip ex ea commodo consequat.', '{"checkups": ["checkup5"]}'),
    ('DEF456', 'Rocky', 'male', 'dog', 'not adopted', 'Sunt in culpa qui officia deserunt mollit anim id est laborum.', '{"checkups": ["checkup6"]}'),
    ('GHI789', 'Luna', 'female', 'cat', 'adopted', 'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.', '{"checkups": ["checkup7"]}');

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
    (1, '2023-01-15 08:00:00', 'Routine checkup for cat'),
    (2, '2023-02-20 10:30:00', 'Follow-up checkup for dog'),
    (3, '2023-03-25 11:45:00', 'Initial health check for cat'),
    (4, '2023-04-30 14:00:00', 'Vaccination for cat'),
    (5, '2023-05-10 09:30:00', 'Deworming for dog');

-- Client table
CREATE TABLE allclients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(100) NOT NULL,
    pet_id INT,
    pet_type VARCHAR(20),
    gender VARCHAR(10),
    checked_in_timestamp TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pet_id) REFERENCES allpets(id)
);

-- Insert dummy records into the Client table
INSERT INTO allclients (client_name, pet_id, pet_type, gender, checked_in_timestamp)
VALUES
    ('John Doe', 1, 'cat', 'male', '2023-01-01 09:00:00'),
    ('Jane Smith', 2, 'dog', 'female', '2023-02-05 11:30:00'),
    ('Alice Johnson', NULL, NULL, NULL, '2023-03-10 15:45:00'),
    ('Bob Anderson', 4, 'cat', 'male', '2023-04-15 08:00:00'),
    ('Emily Clark', 5, 'dog', 'female', '2023-05-20 10:00:00');

-- Blog table
CREATE TABLE allblogs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    body TEXT NOT NULL,
    short_description VARCHAR(200),
    author VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert dummy records into the Blog table
INSERT INTO allblogs (title, body, short_description, author)
VALUES
    ('First Blog Post', 'This is the content of the first blog post.', 'First post.', 'John Doe'),
    ('Second Blog Post', 'This is the content of the second blog post.', 'Second post.', 'Jane Smith'),
    ('Third Blog Post', 'This is the content of the third blog post.', 'Third post.', 'Alice Johnson'),
    ('Fourth Blog Post', 'This is the content of the fourth blog post.', 'Fourth post.', 'Bob Anderson'),
    ('Fifth Blog Post', 'This is the content of the fifth blog post.', 'Fifth post.', 'Emily Clark');

-- Shelter Overview table
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
