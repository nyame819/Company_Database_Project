# Company_Database_Project

Uses SQL to create a company database. Database structure sourced from Fundamentals of Database Systems, 7th Edition by Ramez Elmasri and Shamkant B. Navathe.

This database uses the following tables:

Employee - Stores employee information: Name, address, ssn, birthdate, salary, supervisor ssn, department ID they work in

Department - Stores information for all departments: Department name, ID, supervisor ssn

Dept_Locations - Stores information where each department is located: Department ID, location

Project - Stores project information: Project name, ID, location, department ID that works on the project

Dependents - Keeps track of each dependent for every employee: Employee ssn, dependent name, birthday, relationshop to employee

Works_On - Keeps track of which employees work on each project: Employee ssn, project ID, Number of hours worked

Explanation for each file:

schema.sql - Creates the database tables and defines the columns and keys for each table

insertData.sql - Populates the database with various information

queries.sql - Contains various sql queries that are executed on the database

views.sql - Creates views using the already established tables to get concise data.
