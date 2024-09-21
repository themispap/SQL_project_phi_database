-- Creating the 'projects' table
CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    subject VARCHAR(255),
    customer_id INT REFERENCES customers(customer_id),
    price DECIMAL(10, 2),
    deadline DATE,
    submission_date DATE
);

-- Creating the 'learning_plans' table
CREATE TABLE learning_plans (
    plan_pkey SERIAL PRIMARY KEY,
    plan_id INT UNIQUE,
    price DECIMAL(10, 2),
    description VARCHAR(255),
    charge_type VARCHAR(50),
    duration INT,
    courses VARCHAR(255),
    acad_year VARCHAR(50)
);

-- Creating the 'courses' table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(255),
    grade VARCHAR(50),
    rank VARCHAR(50)
);

-- Creating the 'payments' table
CREATE TABLE payments (
    payment_pkey SERIAL PRIMARY KEY,
    amount DECIMAL(10, 2),
    cause VARCHAR(255),
    category VARCHAR(50),
    issue_date DATE,
    paydate DATE,
    status VARCHAR(50)
);

-- Creating the 'income' table
CREATE TABLE income (
    income_pkey SERIAL PRIMARY KEY,
    amount DECIMAL(10, 2),
    customer_id INT REFERENCES customers(customer_id),
    cause VARCHAR(255),
    charge_date DATE,
    paydate DATE
);

-- Creating the 'records' table
CREATE TABLE records (
    record_pkey SERIAL PRIMARY KEY,
    record_date DATE,
    duration INT,
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id)
);

-- Creating the 'students' table
CREATE TABLE students (
    student_pkey SERIAL PRIMARY KEY,
    signup_date DATE,
    student_id INT UNIQUE,
    student_name VARCHAR(255),
    surname VARCHAR(255),
    mobile VARCHAR(50),
    email VARCHAR(255),
    grade VARCHAR(50),
    rank VARCHAR(50),
    school VARCHAR(255),
    parent_id INT REFERENCES customers(customer_id),
    plan_id INT REFERENCES learning_plans(plan_id),
    discount DECIMAL(10, 2),
    cohort VARCHAR(50),
    del_date DATE,
    acad_year VARCHAR(50)
);

-- Creating the 'customers' table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(255),
    surname VARCHAR(255),
    mobile VARCHAR(50),
    phone VARCHAR(50),
    email VARCHAR(255),
    address VARCHAR(255),
    zip VARCHAR(20),
    region VARCHAR(100),
    city VARCHAR(100),
    lat DECIMAL(9, 6),
    lon DECIMAL(9, 6),
    active BOOLEAN
);
