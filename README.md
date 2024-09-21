# Φ Maths & Statistics Lab Database

This project is a relational database designed for the educational platform of ['Φ' Maths & Statistics Lab](https://phi.edu.gr/). The database captures various aspects of the business operations, including data analysis projects, university courses, and secondary school lessons. This provides an overview of the database schema, data flow, and instructions for setting up and using the database.

## Table of Contents
1. [Introduction](#introduction)
2. [Database Schema](#database-schema)
3. [Table Descriptions](#table-descriptions)
4. [Data Flow](#data-flow)
5. [Setup Instructions](#setup-instructions)
6. [Usage](#usage)
7. [Queries and Reports](#queries-and-reports)
8. [License](#license)

## Introduction

The 'Φ' Maths & Statistics Lab offers three main services:
1. Data analysis projects
2. Courses for university students
3. Lessons for secondary school students

The database structure is designed to efficiently manage information related to projects, students, customers, courses, lesson plans, payments, and income.

## Database Schema

The database consists of the following tables (see [schema](schema.png)):
- `projects`
- `learning_plans`
- `courses`
- `payments`
- `income`
- `records`
- `students`
- `customers`

## Table Descriptions

### projects

| Column Name     | Data Type | Description |
|-----------------|-----------|-------------|
| project_id      | SERIAL    | The unique ID of the project (Primary Key) |
| subject         | VARCHAR   | The subject of the project |
| customer_id     | INT       | The customer ID from the customers table (Foreign Key) |
| price           | DECIMAL   | The price charged for the project |
| deadline        | DATE      | The deadline of the project |
| submission_date | DATE      | The date of taking over the project |

### learning_plans

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| plan_pkey   | SERIAL    | Learning plan primary key |
| plan_id     | INT       | The ID of the learning plan (Unique) |
| price       | DECIMAL   | The price of the learning plan |
| description | VARCHAR   | The description of the learning plan |
| charge_type | VARCHAR   | Billing type (monthly, hourly) |
| duration    | INT       | The total weekly duration of the lessons in the learning plan |
| courses     | VARCHAR   | The courses included in the learning plan |
| acad_year   | VARCHAR   | The academic year of the learning plan |

### courses

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| course_id   | SERIAL    | The unique ID of the course (Primary Key) |
| course_name | VARCHAR   | The name (title) of the course |
| grade       | VARCHAR   | 1st, 2nd, etc. |
| rank        | VARCHAR   | Middle School, High School, Undergraduate, Postgraduate |

### payments

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| payment_pkey| SERIAL    | Payment primary key |
| amount      | DECIMAL   | The monetary amount of the transaction |
| cause       | VARCHAR   | The reason for the transaction |
| category    | VARCHAR   | The category of the payment |
| issue_date  | DATE      | The issue date of the transaction |
| paydate     | DATE      | The date of the transaction |
| status      | VARCHAR   | The status of the payment ('pending','paid') |

### income

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| income_pkey | SERIAL    | Income primary key |
| amount      | DECIMAL   | The monetary amount of the transaction |
| customer_id | INT       | The customer ID from the customers table (Foreign Key) |
| cause       | VARCHAR   | The reason for the transaction |
| charge_date | DATE      | The due date of the transaction |
| paydate     | DATE      | The date of the transaction |

### records

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| record_pkey | SERIAL    | Record primary key |
| record_date | DATE      | The date of the course |
| duration    | INT       | The duration of the course |
| student_id  | INT       | The student ID from the students table (Foreign Key) |
| course_id   | INT       | The course ID from the courses table (Foreign Key) |

### students

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| student_pkey| SERIAL    | Student primary key |
| signup_date | DATE      | The enrollment date of the student |
| student_id  | INT       | The unique ID of the student (Primary Key) |
| student_name| VARCHAR   | The name of the student |
| surname     | VARCHAR   | The surname of the student |
| mobile      | VARCHAR   | The mobile phone number of the student |
| email       | VARCHAR   | The email of the student |
| grade       | VARCHAR   | 1st, 2nd, etc. |
| rank        | VARCHAR   | Middle School, High School, Undergraduate, Postgraduate |
| school      | VARCHAR   | The school the student attends |
| parent_id   | INT       | The customer ID from the customers table (Foreign Key) |
| plan_id     | INT       | The plan ID from the learning_plans table (Foreign Key) |
| discount    | DECIMAL   | The discount given to the student |
| cohort      | VARCHAR   | The class in which the student is enrolled |
| del_date    | DATE      | The student's deletion date |
| acad_year   | VARCHAR   | The academic year in which the student was enrolled |

### customers

| Column Name | Data Type | Description |
|---------------|-----------|-------------|
| customer_id   | SERIAL    | The unique ID of the customer (Primary Key) |
| customer_name | VARCHAR   | The name of the customer |
| surname       | VARCHAR   | The surname of the customer |
| mobile        | VARCHAR   | The mobile phone number of the customer |
| phone         | VARCHAR   | The phone number of the customer |
| email         | VARCHAR   | The email of the customer |
| address       | VARCHAR   | The home address of the customer |
| zip           | VARCHAR   | The ZIP code of the customer |
| region        | VARCHAR   | The region the customer lives in |
| city          | VARCHAR   | The city the customer lives in |
| lat           | DECIMAL   | The latitude of the customer's address |
| lon           | DECIMAL   | The longitude of the customer's address |
| active        | BOOLEAN   | Whether a customer is active or not |

## Data Flow

- When the business undertakes a project, entries are made in both the `projects` and `customers` tables.
- When a university student registers, the same entries are made in both the `students` and `customers` tables.
- When a secondary school student enrolls, entries are made in both the `students` table and the `customers` table with their guardian's details.
- Courses for every academic year are listed in the `courses` table.
- Learning plans for every academic year are listed in the `learning_plans` table.
- Lesson details are entered in the `records` table.
- Business expenses are recorded in the `payments` table, while income is recorded in the `income` table.

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/SQL_project_phi_database.git
   ```
2. Navigate to the project directory:
   ```bash
   cd SQL_project_phi_database
   ```
3. Set up the database:
   - Create a new PostgreSQL database:
     ```sql
     CREATE DATABASE phi_maths_stats_lab;
     ```
   - Connect to the database:
     ```bash
     psql -d phi_maths_stats_lab
     ```
   - Run the provided SQL script to create the tables and insert initial data:
     ```sql
     \i schema.sql
     ```
4. Configure the database connection in your application.

## Usage

- Insert, update, and query data as required to manage projects, students, customers, courses, lesson plans, payments, and income.

## Queries and Reports

You can run various SQL queries to generate reports, such as:
- Balance of every customer for the selected academic year ([open query](https://raw.githubusercontent.com/themispap/SQL_project_phi_database/main/queries/balance.sql))

  | customer name | customer surname | credit | debit | balance |
  |---------------|------------------|--------|-------|---------|
  | ...           | ...              | ...    | ...   | ...     |
  | ...           | ...              | ...    | ...   | ...     |
  
- Monthly revenue ([open query](https://raw.githubusercontent.com/themispap/SQL_project_phi_database/raw/main/queries/income.sql)) and cost ([open query](https://raw.githubusercontent.com/themispap/SQL_project_phi_database/raw/main/queries/cost.sql)) for the selected academic year
  
   | month | income / cost |
   |-------|---------------|
   | ...   | ...           |
   | ...   | ...           |
  
- List of students enrolled in a specific course.
- Details of all projects undertaken within a specific timeframe.

Example queries are provided in the `queries` folder.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.