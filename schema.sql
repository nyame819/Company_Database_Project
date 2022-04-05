--CREATE DATABASE Company;
USE CompanyProject;


-- -----------------------------------------------------
-- Table Company.Employee
-- -----------------------------------------------------
--DROP TABLE IF EXISTS Employee ;

CREATE TABLE Employee (
	Fname VARCHAR(15) NOT NULL,
	Minit CHAR NOT NULL,
	Lname VARCHAR(15) NOT NULL,
	Ssn CHAR(9) NOT NULL,
	Bdate DATE NULL,
	Address VARCHAR(30) NULL,
	Sex CHAR NULL,
	Salary DECIMAL(10,2) NULL,
	Super_Ssn CHAR(9) NULL,
	Dnumber INT NOT NULL,
	PRIMARY KEY (Ssn),
	--INDEX fk_Employee_Department1_idx (Dno ASC) VISIBLE,
);


--------------------------------------------------------
-- Table Company.Department
-- -----------------------------------------------------
DROP TABLE IF EXISTS Department ;

CREATE TABLE Department (
	Dname VARCHAR(15) NOT NULL,
	Dnumber INT NOT NULL,
	Mgr_Ssn CHAR(9) NOT NULL,
	Mgr_Start_Date DATE NULL,
	PRIMARY KEY (Dnumber),
	--INDEX Mgr_Ssn_idx (Mgr_Ssn ASC) VISIBLE,
	CONSTRAINT Ssn
    FOREIGN KEY (Mgr_Ssn) REFERENCES Employee(Ssn)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

--ALTER TABLE Employee
--ADD CONSTRAINT Dnumber
--    FOREIGN KEY (Dnumber) REFERENCES Department (Dnumber)
--    ON DELETE NO ACTION
--    ON UPDATE NO ACTION

-- -----------------------------------------------------
-- Table Company.Dependent
-- -----------------------------------------------------
DROP TABLE IF EXISTS Dependents ;

CREATE TABLE Dependents (
  Essn CHAR(9) NOT NULL,
  Dependent_Name VARCHAR(15) NOT NULL,
  Sex CHAR NULL,
  Bdate DATE NULL,
  Relationship VARCHAR(8) NULL,
  PRIMARY KEY (Dependent_Name, Essn),
  --INDEX Essn_idx (Essn ASC) VISIBLE,
  CONSTRAINT Essn
    FOREIGN KEY (Essn)
    REFERENCES Employee (Ssn)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table Company.Project
-- -----------------------------------------------------
DROP TABLE IF EXISTS Project ;

CREATE TABLE Project (
  Pname VARCHAR(15) NOT NULL,
  Pnumber INT NOT NULL,
  Plocation VARCHAR(15) NULL,
  Dnum INT NOT NULL,
  PRIMARY KEY (Pnumber),
  --INDEX fk_Project_Department_idx (Dnum ASC) VISIBLE,
  CONSTRAINT fk_Project_Department
    FOREIGN KEY (Dnum)
    REFERENCES Department (Dnumber)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)


	-- -----------------------------------------------------
-- Table Company.Works_On
-- -----------------------------------------------------
DROP TABLE IF EXISTS Works_On ;

CREATE TABLE Works_On (
  E_ssn CHAR(9) NOT NULL,
  Pno INT NOT NULL,
  Hours DECIMAL(3,1) NULL,
  --INDEX fk_Works_On_idx (Pno ASC) VISIBLE,
  PRIMARY KEY (E_ssn, Pno),
  CONSTRAINT E_ssn
    FOREIGN KEY (E_ssn)
    REFERENCES Employee (Ssn)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT Pno
    FOREIGN KEY (Pno)
    REFERENCES Project (Pnumber)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table Company.Dept_Locations
-- -----------------------------------------------------
DROP TABLE IF EXISTS Dept_Locations ;

CREATE TABLE Dept_Locations (
  Dno INT NOT NULL,
  Dlocation VARCHAR(15) NOT NULL,
  PRIMARY KEY (Dlocation, Dno),
  --INDEX Dnumber_idx (Dnumber ASC) VISIBLE,
  CONSTRAINT Dno
    FOREIGN KEY (Dno)
    REFERENCES Department (Dnumber)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
