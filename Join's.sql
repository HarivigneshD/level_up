
-- Departments: master table
CREATE TABLE Departments (
  dept_id      INT PRIMARY KEY,
  dept_name    VARCHAR(100) NOT NULL
);

-- Employees belong to a department (some may not be assigned yet)
CREATE TABLE Employees (
  emp_id       INT PRIMARY KEY,
  emp_name     VARCHAR(100) NOT NULL,
  dept_id      INT,
  CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);


INSERT INTO Departments (dept_id, dept_name) VALUES
  (10, 'Cutting'),
  (20, 'Drilling'),
  (30, 'Painting'),
  (40, 'Assembly');

-- Employees
INSERT INTO Employees (emp_id, emp_name, dept_id) VALUES
  (101, 'Hari', 10),
  (102, 'Nisha', 10),
  (103, 'Arun', 20),
  (104, 'Meera', 30),
  (105, 'Sameer', NULL); 
  
  SELECT*FROM Employees;
  
  SELECT d.dept_name, e.emp_name from Departments as d CROSS join Employees as e on d.dept_id = e.dept_id;
  
  
