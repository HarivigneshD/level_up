DROP table if exists drivers;
-- Creating the drivers table
CREATE TABLE drivers (
    driver_id INT PRIMARY KEY,
    driver_name VARCHAR(100),
    license_number VARCHAR(50) UNIQUE
);

-- Creating the rides table with driver_id as a foreign key
DROP table if exists rides;
CREATE TABLE rides (
    ride_id INT PRIMARY KEY,
    driver_id INT,
    pickup_location VARCHAR(100),
    dropoff_location VARCHAR(100),
    ride_date DATETIME,
    fare DECIMAL(10, 2),
    FOREIGN key (driver_id) REFERENCES riders(driver_id));
    
    -- Inserting drivers
INSERT INTO drivers (driver_id, driver_name, license_number)
VALUES (101, 'John Doe', 'XYZ12345'), (102, 'Jane Smith', 'ABC67890');

-- Inserting rides associated with each driver
INSERT INTO rides (ride_id, driver_id, pickup_location, dropoff_location, ride_date, fare)
VALUES
(301, 101, 'Chennai', 'Coimbatore', '2024-12-01 08:00:00', 500.00),
(302, 101, 'Chennai', 'Madurai', '2024-12-01 09:30:00', 600.00),
(303, 102, 'Bangalore', 'Hyderabad', '2024-12-02 10:00:00', 700.00);