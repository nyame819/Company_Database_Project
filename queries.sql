-- Execute SQL Queries on the Company database
USE CompanyProject

-- Get birthday and address for employees named John B Smith
SELECT Bdate, Address
FROM Employee
WHERE Fname = 'John' AND Minit = 'B' AND Lname = 'Smith';

-- Get names and addresses for employees in the research department
SELECT Fname, Lname, Address
FROM Employee, department
WHERE Employee.Dnumber = department.Dnumber AND Dname = 'Research';

-- Get project information for projects located in Stafford
SELECT Pnumber, Dnum, Lname, Address, Bdate
FROM Project, Employee, Department
WHERE Project.Plocation = 'Stafford' AND Employee.Ssn = Department.Mgr_Ssn AND Project.Dnum = Department.Dnumber;

------ Get employees names and their supervisors
SELECT E.Fname, E.Lname, S.Fname, S.Lname
FROM (Employee AS E join Employee AS S ON E.Super_Ssn = S.Ssn);

-- Get ssn for all employees
SELECT Fname, Lname, Ssn
FROM Employee;

-- Get ssn and department for all employees
SELECT Fname, Lname, Ssn, Dname
FROM Employee, Department;

-- Get employee information from department 5
SELECT *
FROM Employee
WHERE Dnumber = 5;

-- Get project information for the research department
SELECT *
FROM Employee, Department
WHERE Employee.Dnumber = Department.Dnumber AND Dname = 'Research';

-- Get salaries for all employees
SELECT Fname, Lname, salary
FROM Employee;

-- Get all unique salaries
SELECT DISTINCT salary
FROM Employee;

-- Get unique project number where the supervisor of the project has the last name Smith
(SELECT DISTINCT Pnumber
 FROM Project, Department, Employee
 WHERE Project.Dnum=Department.Dnumber AND Mgr_Ssn = Ssn AND Lname = 'Smith')
UNION
(SELECT DISTINCT Pnumber
 FROM Project, Works_On, Employee
 WHERE Pnumber = Pno AND E_ssn = Ssn AND Lname = 'Smith');
 
-- Get employees located in Houston, TX
SELECT Fname, Lname
FROM Employee
WHERE address LIKE '%Houston, TX%';

-- Get employees born in the 1950s
SELECT Fname, Lname
FROM Employee
WHERE Bdate LIKE '195%';
 
-- Increase the salaries for all employees that worked on ProductX
SELECT Fname, Lname, salary * 1.1 AS Increased_sal
FROM Employee, Works_On, Project
WHERE Ssn = E_ssn AND Pno = Pnumber AND Pname = 'ProductX';

-- Get all information for employees that have a salary between 30,000 and 40,000 and are in department --5
SELECT *
FROM Employee
WHERE (salary BETWEEN 30000 AND 40000) AND Dnumber = 5;

-- Get the department and supervisor name for 
SELECT D.Dname, E.Lname, E.Fname, P.Pname
FROM Department AS D, Employee AS E, Works_On AS W, Project AS P
WHERE D.Dnumber = E.Dnumber AND E.Ssn = W.E_Ssn AND W.Pno = P.Pnumber
ORDER BY D.Dname, E.Lname, E.Fname;

-- Get employees that don't have a supervisor
SELECT Fname, Lname
FROM Employee
WHERE Super_Ssn IS NULL;

-- Nested Query
-- Get project numbers that either have a supervisor or an employee with the last name Smith
SELECT DISTINCT Pnumber
FROM Project
WHERE Pnumber IN (SELECT Pnumber
				  FROM Project, Department, Employee
                  WHERE Project.Dnum = Department.Dnumber AND Mgr_Ssn = Ssn AND Lname = 'Smith')
	OR
	  Pnumber IN (SELECT Pno
				  FROM Employee, Works_On
                  WHERE E_Ssn = Ssn AND Lname = 'Smith');
           
-- Nested Query
-- Get employees that don't work in research and are not supervisors 
SELECT Lname, Fname
FROM Employee
WHERE NOT EXISTS (SELECT *
				  FROM Works_On AS W
                  WHERE W.Pno IN (SELECT Pnumber
								  FROM Project
                                  WHERE Dnum = 5)
				  AND
                  NOT EXISTS (SELECT *
                              FROM Works_On AS C
                              WHERE C.E_Ssn = Ssn
                              AND C.Pno = W.Pno));
                       
-- Get employees that have a larger salary than every employee in research
SELECT Lname, Fname
FROM Employee
WHERE Salary > ALL (SELECT Salary
					FROM Employee
					WHERE Dnumber = 5);
                    
-- Get all dependents that have the same first name as the employee
SELECT E.Fname, E.Lname
FROM Employee AS E, Dependents AS D
WHERE E.Ssn = D.Essn AND E.Fname = D.Dependent_Name AND E.Sex = D.Sex;

-- Get employees that have no dependents
SELECT Fname, Lname
FROM Employee
WHERE NOT EXISTS (SELECT *
				  FROM Dependents
                  WHERE Ssn = Essn);

-- Get employees that are supervisors and have dependents
SELECT DISTINCT E.Fname, E.Lname
FROM Employee AS E, Dependents AS A, Department AS D
WHERE E.Ssn = D.Mgr_Ssn AND E.Ssn = A.Essn;

-- Get unique ssn of all employees on Projects 1,2, and 3
SELECT DISTINCT Ssn
FROM Employee, Works_On
WHERE E_Ssn = Ssn AND Pno IN (1,2,3);

-- Get employee info that work in the research department
SELECT Fname, Lname, Address
FROM (Employee JOIN Department ON Employee.Dnumber = Department.Dnumber)
WHERE Dname = 'Research';

-- Get employee last names and last names of their supervisors
SELECT E.Lname AS Employee_Name, S.Lname AS Supervisor_Name
FROM (Employee AS E LEFT OUTER JOIN Employee AS S ON E.Super_Ssn =  S.Ssn);

-- Get project information on projects located in Stafford
SELECT Pnumber, Dnum, Lname, address, Bdate
FROM ((Project JOIN Department ON Dnum = Dnumber) JOIN employee ON Mgr_Ssn = Ssn)
WHERE Plocation = 'Stafford';

-- Get total salaries, max salary, min salary, and average salary
SELECT SUM(Salary), MAX(Salary), MIN(Salary), AVG(Salary)
FROM Employee;

-- Get total salaries, max salary, min salary, and average salary in the research department
SELECT SUM(salary), MAX(salary), MIN(salary), AVG(salary)
FROM Employee, Department
WHERE Employee.Dnumber = Department.Dnumber AND Dname = 'Research';

-- Count number of employees
SELECT Count(*)
FROM Employee;

-- Total employees in research department
SELECT Count(*)
FROM Employee, Department
WHERE Employee.Dnumber = Department.Dnumber AND Dname = 'Research';

-- Get employees that have more than two dependents
SELECT DISTINCT Fname, Lname
FROM Employee, Dependents
WHERE (SELECT COUNT(*)
	   FROM Dependents
       WHERE Ssn = Essn) >= 2;
       
-- Count the number of employees in each department and average their salaries
SELECT DISTINCT Employee.Dnumber, Count(*), AVG(Salary)
FROM Department, Employee
WHERE Employee.Dnumber = Department.Dnumber
GROUP BY Employee.Dnumber
ORDER BY Employee.Dnumber;

-- Count the amount of times each project was worked on
SELECT Pnumber, Pname, COUNT(*)
FROM Project JOIN Works_On ON Pnumber = Pno
GROUP BY Pnumber, Pname;

-- Get total number of employees that work on each project
SELECT Pnumber, Pname, COUNT(*)
FROM project, works_on
WHERE Pno = Pnumber
GROUP BY Pnumber, Pname
HAVING COUNT(*) > 2;

-- Count number of employees that worked on each project
SELECT Pnumber, Pname, COUNT(*)
FROM project, works_on, employee
WHERE Pno = Pnumber AND Ssn = E_Ssn AND Dnumber = 5
GROUP BY Pnumber, Pname;

-- Get departments that have more than two employees and count the number of those employees that
-- have a salary greater than $30,000
SELECT Dnumber, COUNT(*)
FROM employee
WHERE salary > 30000 AND Dnumber IN (SELECT Dnumber
								 FROM employee
								 GROUP BY Dnumber
								 HAVING COUNT(*) > 2)
GROUP BY Dnumber;