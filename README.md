# 'Φ' maths & statistics lab dashboard

This project is about the dashboard of the educational platform of ['Φ' maths & statistics lab](https://phi.edu.gr/).
The services provided by 'Φ' are
* Data analysis projects
* Courses for university students
* Lessons for secondary school students

The information is entered into the database as follows:
* Each time the business undertakes a project, an entry is made in the projects table as well as an entry in the customers table of the database.
* Each time a university student registers, a record is made in the students table as well as a record in the customer table of the database (university students are registered as both students and customers).
* Every time a student enrolls, an entry is made in the students table and an entry is made in the customers table with their guardian's details.
* Courses taught in the current academic year are listed in the courses table
* Lesson plans in the current academic year are listed in the plans table
* For each course taught each day, the duration, date, student id, and course id are entered in the records table
* The expenses of the business are entered in the payments table while the income is entered in the income table

The database contains the following tables:

### projects
* project_id: The unique id of the project (key)
* subject: The subject of the project
* customer_id: The customer id of the customers table 
* price: the price charged for the project 
* deadline: The deadline of the project 
* date: The date of taking over the project
### plans
* plan_id: The unique id of the plan (key)
* price: The plan price
* description: The plan description 
* charge_type: Billing type (monthly, hourly) 
* duration: The total weekly duration of the lessons of the plan
* courses: The courses included in the plan
* acad_year: The academic year of the plan
### courses
* course_id: The unique id of the course (key) 
* name: The name (title) of the course 
* grade: 1st, 2nd, etc 
* rank: Middle School, High School, Undergraduate, Postgraduate 
* duration: The weekly duration of the course (in hours) 
### payments
* amount: The monetary amount of the transaction
* cause: The reason for the transaction  
* category: The category of the payment (!) 
* date: The due date of the transaction 
* paydate: The date of the transaction 
* status: The status of the payment ('pending','paid')
### income
* amount: The monetary amount of the transaction
* customer_id: The customer id of the customers table
* cause: The reason for the transaction 
* date: The due date of the transaction  
* paydate: The date of the transaction 
### records
* date: the date of the course
* duration: the duration of the course 
* student_id: The student id of the students table 
* course_id: The course id of the courses table 
### students
* date: The enrolle date of the student
* student_id: The unique id of the student (key) 
* name: The name of the student 
* surname: The surname of the student 
* mobile: The mobile phone number of the student 
* email: The email of the student 
* grade: 1st, 2nd, etc 
* rank: Middle School, High School, Undergraduate, Postgraduate 
* school: The school the student attends 
* parent_id: The customer id of the customers table 
* plan_id: The plan id of the plans table 
* discount: the discount given to the student 
* class: The class in which the student is enrolled 
* del_date: The student's deletion date 
* acad_year: The academic year in which the student was enrolled 
### customers
* customer_id: The unique id of the customer (key)
* name: The name of the customer
* surname: The surname of the customer
* mobile: The mobile phone number of the customer
* phone: The phone number of the customer 
* email: The email of the customer  
* address: The home address of the customer 
* zip: The email of the customer 
* region: The region the customer lives
* city: The city the customer lives
* lat: The latitude of the customer's adress 
* lon: The longitude of the customer's address 
* acad_year: The academic year of the customer's registration 

