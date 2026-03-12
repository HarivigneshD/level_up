-- Run this block to drop in dependency-safe order
DROP TABLE IF EXISTS ProductionLogs;
DROP TABLE IF EXISTS WorkOrders;
DROP TABLE IF EXISTS Machine_Status;
DROP TABLE IF EXISTS Machines;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;

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

-- Machines belong to a department
CREATE TABLE Machines (
  machine_id    INT PRIMARY KEY,
  machine_name  VARCHAR(100) NOT NULL,
  dept_id       INT,
  CONSTRAINT fk_mach_dept FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

-- Machine status log (may contain machine_ids not yet registered => to show RIGHT/FULL joins)
CREATE TABLE Machine_Status (
  status_id     INT PRIMARY KEY,
  machine_id    INT,
  status        VARCHAR(50) NOT NULL,   -- e.g., Running, Idle, Maintenance, Offline
  status_time   TIMESTAMP NOT NULL,
  CONSTRAINT fk_status_machine FOREIGN KEY (machine_id) REFERENCES Machines(machine_id)
);

-- Work orders assigned to machines (some orders assigned to non-existing machine for join practice)
CREATE TABLE WorkOrders (
  wo_id         INT PRIMARY KEY,
  wo_number     VARCHAR(50) NOT NULL,
  machine_id    INT,
  assigned_to   INT,      -- employee id
  due_date      DATE,
  CONSTRAINT fk_wo_machine FOREIGN KEY (machine_id) REFERENCES Machines(machine_id),
  CONSTRAINT fk_wo_emp FOREIGN KEY (assigned_to) REFERENCES Employees(emp_id)
);

-- Production logs (many-to-one with work orders)
CREATE TABLE ProductionLogs (
  log_id        INT PRIMARY KEY,
  wo_id         INT,
  produced_qty  INT NOT NULL,
  log_time      TIMESTAMP NOT NULL,
  CONSTRAINT fk_log_wo FOREIGN KEY (wo_id) REFERENCES WorkOrders(wo_id)
);

-- Departments
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
  (105, 'Sameer', NULL);     -- no department yet

-- Machines
INSERT INTO Machines (machine_id, machine_name, dept_id) VALUES
  (1, 'Cutting Machine A', 10),
  (2, 'Drilling Machine B', 20),
  (3, 'Painting Booth C', 30);

-- Machine Status
-- Note: includes one status for a non-existing machine_id=4 to practice RIGHT/FULL JOIN
INSERT INTO Machine_Status (status_id, machine_id, status, status_time) VALUES
  (1001, 1, 'Running',      '2026-03-12 09:00:00'),
  (1002, 1, 'Idle',         '2026-03-12 10:00:00'),
  (1003, 3, 'Maintenance',  '2026-03-12 09:30:00'),
  (1004, 4, 'Offline',      '2026-03-12 08:45:00');  -- machine_id 4 does not exist in Machines

-- Work Orders
-- Include a work order assigned to a non-existing machine (machine_id=5) for LEFT/RIGHT/FULL edge cases
INSERT INTO WorkOrders (wo_id, wo_number, machine_id, assigned_to, due_date) VALUES
  (5001, 'WO-1001', 1, 101, '2026-03-15'),
  (5002, 'WO-1002', 1, 102, '2026-03-16'),
  (5003, 'WO-1003', 2, 103, '2026-03-17'),
  (5004, 'WO-1004', 3, 104, '2026-03-18'),
  (5005, 'WO-9999', 5, 105, '2026-03-20'); -- machine 5 not present

-- Production Logs (many-to-one with WorkOrders)
INSERT INTO ProductionLogs (log_id, wo_id, produced_qty, log_time) VALUES
  (9001, 5001, 120, '2026-03-12 09:10:00'),
  (9002, 5001,  80, '2026-03-12 10:05:00'),
  (9003, 5002, 150, '2026-03-12 09:40:00'),
  (9004, 5004,  60, '2026-03-12 10:20:00');
  
SELECT d.dept_name, e.emp_name, m.machine_id from Departments as d, Machines as m right join Employees as e on d.dept_id = e.dept_id 
order by m.machine_id;
