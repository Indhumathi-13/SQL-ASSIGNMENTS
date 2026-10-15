-- Create the database
CREATE DATABASE elearning_db;

-- Select the database
USE elearning_db;

-- Create the learners table
CREATE TABLE learners (
    learner_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL
);

-- Create the courses table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);

-- Create the purchases table
CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY,
    learner_id INT NOT NULL,
    course_id INT NOT NULL,
    quantity INT NOT NULL,
    purchase_date DATE NOT NULL,

    FOREIGN KEY (learner_id)
        REFERENCES learners(learner_id),

    FOREIGN KEY (course_id)
        REFERENCES courses(course_id),

    CHECK (quantity > 0)
    );
    INSERT INTO learners (learner_id, full_name, country)
VALUES
(1, 'Arun Kumar', 'India'),
(2, 'Priya Sharma', 'UAE'),
(3, 'John Smith', 'USA'),
(4, 'Meena Raj', 'India'),
(5, 'David Lee', 'Singapore');

INSERT INTO courses (course_id, course_name, category, unit_price)
VALUES
(101, 'SQL for Beginners', 'Database', 1500.00),
(102, 'Power BI Masterclass', 'Data Analytics', 2500.00),
(103, 'Python Programming', 'Programming', 2000.00),
(104, 'Advanced Excel', 'Data Analytics', 1200.00),
(105, 'MySQL Advanced', 'Database', 1800.00);


INSERT INTO purchases
(purchase_id, learner_id, course_id, quantity, purchase_date)
VALUES
(1001, 1, 101, 1, '2026-01-10'),
(1002, 1, 102, 2, '2026-01-15'),
(1003, 2, 103, 1, '2026-02-01'),
(1004, 2, 101, 1, '2026-02-05'),
(1005, 3, 104, 3, '2026-02-10'),
(1006, 4, 102, 1, '2026-03-01'),
(1007, 4, 105, 2, '2026-03-05'),
(1008, 1, 103, 1, '2026-03-10');

SELECT * FROM learners;
SELECT * FROM courses;
SELECT * FROM purchases;

SELECT
    l.learner_id,
    l.full_name AS learner_name,
    c.course_name,
    c.category,
    p.quantity,
    c.unit_price,
    ROUND(p.quantity * c.unit_price, 2) AS total_amount,
    p.purchase_date
FROM learners l
INNER JOIN purchases p
    ON l.learner_id = p.learner_id
INNER JOIN courses c
    ON p.course_id = c.course_id
ORDER BY p.purchase_date;



SELECT
    l.learner_id,
    l.full_name AS learner_name,
    c.course_name,
    c.category,
    p.quantity,
    ROUND(p.quantity * c.unit_price, 2) AS total_amount,
    p.purchase_date
FROM learners l
LEFT JOIN purchases p
    ON l.learner_id = p.learner_id
LEFT JOIN courses c
    ON p.course_id = c.course_id
ORDER BY l.full_name;
SELECT
    l.learner_id AS learner_id,
    l.full_name AS learner_name,
    c.course_name AS course_name,
    c.category AS course_category,
    p.quantity AS quantity,
    FORMAT(p.quantity * c.unit_price, 2) AS total_amount,
    p.purchase_date AS purchase_date
FROM learners l
LEFT JOIN purchases p
    ON l.learner_id = p.learner_id
LEFT JOIN courses c
    ON p.course_id = c.course_id
ORDER BY l.full_name ASC;

SELECT
    c.course_id AS course_id,
    c.course_name AS course_name,
    c.category AS course_category,
    l.full_name AS learner_name,
    p.quantity AS quantity,
    FORMAT(p.quantity * c.unit_price, 2) AS total_amount,
    p.purchase_date AS purchase_date
FROM purchases p
RIGHT JOIN courses c
    ON p.course_id = c.course_id
LEFT JOIN learners l
    ON p.learner_id = l.learner_id
ORDER BY c.course_name ASC;




SELECT
    l.learner_id AS learner_id,
    l.full_name AS learner_name,
    l.country AS country,
    FORMAT(
        COALESCE(SUM(p.quantity * c.unit_price), 0),
        2
    ) AS total_spent
FROM learners l
LEFT JOIN purchases p
    ON l.learner_id = p.learner_id
LEFT JOIN courses c
    ON p.course_id = c.course_id
GROUP BY
    l.learner_id,
    l.full_name,
    l.country
ORDER BY
    SUM(COALESCE(p.quantity * c.unit_price, 0)) DESC;

SELECT
    c.course_name AS course_name,
    SUM(p.quantity) AS total_quantity_sold
FROM courses c
INNER JOIN purchases p
    ON c.course_id = p.course_id
GROUP BY
    c.course_id,
    c.course_name
ORDER BY
    total_quantity_sold DESC
LIMIT 3;

SELECT
    c.category AS course_category,
    FORMAT(
        SUM(p.quantity * c.unit_price),
        2
    ) AS total_revenue,
    COUNT(DISTINCT p.learner_id) AS unique_learners
FROM courses c
INNER JOIN purchases p
    ON c.course_id = p.course_id
GROUP BY c.category
ORDER BY
    SUM(p.quantity * c.unit_price) DESC;

SELECT
    l.learner_id AS learner_id,
    l.full_name AS learner_name,
    COUNT(DISTINCT c.category) AS category_count
FROM learners l
INNER JOIN purchases p
    ON l.learner_id = p.learner_id
Inner join courses c
    ON p.course_id = c.course_id
GROUP BY
    l.learner_id,
    l.full_name
HAVING COUNT(DISTINCT c.category) > 1
ORDER BY category_count DESC;

SELECT
    l.learner_id AS learner_id,
    l.full_name AS learner_name,
    COUNT(DISTINCT c.category) AS category_count
FROM learners l
INNER JOIN purchases p
    ON l.learner_id = p.learner_id
INNER JOIN courses c
    ON p.course_id = c.course_id
group by
    l.learner_id,
    l.full_name
HAVING COUNT(DISTINCT c.category) > 1
ORDER BY category_count DESC;

SELECT
    c.course_id AS course_id,
    c.course_name AS course_name,
    c.category AS course_category,
    FORMAT(c.unit_price, 2) AS unit_price
FROM courses c
LEFT JOIN purchases p
    ON c.course_id = p.course_id
WHERE p.purchase_id IS NULL
ORDER BY c.course_name ASC;
