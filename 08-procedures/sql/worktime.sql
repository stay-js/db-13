DROP DATABASE IF EXISTS `worktime`;
CREATE DATABASE `worktime`;

USE `worktime`;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,

    boss_id INT NULL,

    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    tax_number VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,

    street VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    country VARCHAR(50) NOT NULL,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_employees_boss_id (boss_id),
    CONSTRAINT fk_employees_boss
        FOREIGN KEY (boss_id)
        REFERENCES employees(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE timesheets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    work_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    break_minutes INT DEFAULT 0,
    approved BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_timesheets_employee_date (employee_id, work_date),

    CONSTRAINT fk_timesheets_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO employees
(boss_id, first_name, last_name, birth_date, tax_number, email, street, city, postal_code, country)
VALUES
(NULL, 'Kovács', 'Júlia', '1980-02-14', '99999999-9-99', 'kovacs.julia@ceg.hu', 'Vezér utca 1', 'Budapest', '1011', 'Hungary');

INSERT INTO employees
(boss_id, first_name, last_name, birth_date, tax_number, email, street, city, postal_code, country)
VALUES
(1, 'Kiss',  'Ádám',   '1990-03-12', '12345678-1-12', 'kiss.adam@ceg.hu',        'Fő utca 12',        'Budapest', '1111', 'Hungary'),
(1, 'Nagy',  'Eszter', '1988-07-05', '23456789-2-23', 'nagy.eszter@ceg.hu',      'Petőfi tér 4',      'Szeged',   '6720', 'Hungary'),
(1, 'Tóth',  'Bence',  '1995-01-21', '34567890-3-34', 'toth.bence@ceg.hu',       'Kossuth Lajos u. 8','Debrecen', '4024', 'Hungary'),
(1, 'Szabó', 'Lilla',  '1992-11-02', '45678901-4-45', 'szabo.lilla@ceg.hu',      'Arany János u. 15', 'Pécs',     '7621', 'Hungary'),
(1, 'Varga', 'Miklós', '1985-05-18', '56789012-5-56', 'varga.miklos@ceg.hu',     'Bartók Béla út 22', 'Győr',     '9021', 'Hungary');


INSERT INTO timesheets
(employee_id, work_date, start_time, end_time, break_minutes, approved)
SELECT
    e.id,
    DATE_ADD('2024-01-02', INTERVAL d.day DAY) AS work_date,
    '08:00:00',
    '16:30:00',
    CASE WHEN d.day % 3 = 0 THEN 45 ELSE 30 END,
    CASE WHEN d.day % 5 = 0 THEN TRUE ELSE FALSE END
FROM employees e
JOIN (
    SELECT 0 AS day UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
    UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12 UNION ALL SELECT 13 UNION ALL SELECT 14
    UNION ALL SELECT 15 UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18 UNION ALL SELECT 19
    UNION ALL SELECT 20 UNION ALL SELECT 21 UNION ALL SELECT 22 UNION ALL SELECT 23 UNION ALL SELECT 24
    UNION ALL SELECT 25 UNION ALL SELECT 26 UNION ALL SELECT 27 UNION ALL SELECT 28 UNION ALL SELECT 29
    UNION ALL SELECT 30 UNION ALL SELECT 31 UNION ALL SELECT 32 UNION ALL SELECT 33 UNION ALL SELECT 34
    UNION ALL SELECT 35 UNION ALL SELECT 36 UNION ALL SELECT 37 UNION ALL SELECT 38 UNION ALL SELECT 39
) d;
