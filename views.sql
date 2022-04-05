Use CompanyProject
GO

-- Create a view with employee and project information
CREATE VIEW [works_on1] AS
    SELECT 
        Employee.Fname AS Fname,
        Employee.lname AS Lname,
        Project.Pname AS Pname,
        Works_On.Hours AS Hours
    FROM
        ((Employee
        JOIN Project on Employee.Dnumber = Project.Dnum)
        JOIN Works_On on Works_On.E_ssn = Employee.Ssn)
    WHERE
        ((employee.Ssn = works_on.E_ssn)
            AND (works_on.Pno = project.Pnumber)); 
GO

-- Create a view with department information
CREATE VIEW dept_info AS
    SELECT 
        department.Dname AS Dept_Name,
        COUNT(0) AS No_of_Emps,
        SUM(employee.Salary) AS Total_Sal
    FROM (department JOIN employee on Department.Dnumber = Employee.Dnumber)
    WHERE
        (department.Dnumber = employee.Dnumber)
    GROUP BY department.Dname;    
GO

-- Execute a query on a view
SELECT Fname, Lname
FROM works_on1
WHERE Pname = 'ProductX';

-- Update Works_On1 view
UPDATE works_on1
SET Pname = 'ProductY'
WHERE Fname = 'John' AND Lname = 'Smith';

SELECT *
FROM works_on1


DROP VIEW works_on1;
DROP VIEW dept_info;