DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Employees;

CREATE TABLE Products (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE Employees (
    emp_id INTEGER PRIMARY KEY AUTOINCREMENT,
    emp_name VARCHAR(100),
    department VARCHAR(50)
);

CREATE TABLE Sales (
    sale_id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_id INT,
    emp_id INT,
    quantity INT,
    sale_date DATE,
    CONSTRAINT fk_sale_product FOREIGN KEY (product_id) REFERENCES Products(product_id),
    CONSTRAINT fk_sale_emp FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);

INSERT INTO Products (product_name, category, price) VALUES
('Wood Chair',      'Furniture', 1500.00),
('Steel Table',     'Furniture', 3500.00),
('LED Panel Light', 'Electrical', 800.00),
('Cable Tray',      'Electrical', 500.00); 

INSERT INTO Employees (emp_name, department) VALUES
('Hari',   'Production'),
('Nisha',  'Production'),
('Arun',   'Quality'),
('Meera',  'Logistics');

INSERT INTO Sales (product_id, emp_id, quantity, sale_date) VALUES
(1, 1, 10, '2026-03-10'),
(1, 2,  5, '2026-03-11'),
(2, 1,  3, '2026-03-11'),
(3, 3,  8, '2026-03-10'),
(3, 3, 12, '2026-03-11'),
(4, 4, 15, '2026-03-11');

SELECT p.product_name, p.category, COUNT(price) as prices, s.sale_date FROM Products as p, Sales as s 
group by sale_date;

