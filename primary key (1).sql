CREATE TABLE ridess (
    ride_id INT PRIMARY KEY,
    driver_id INT NOT NULL,
    rider_id INT NOT NULL,
    pickup_location VARCHAR(100) NOT NULL,
    dropoff_location VARCHAR(100) NOT NULL,
    ride_date DATETIME NOT NULL,
    fare DECIMAL(10, 2) NOT NULL CHECK (fare>600.00)
);

INSERT INTO ridess (ride_id, driver_id, rider_id, pickup_location, dropoff_location, ride_date, fare)
VALUES
(1, 101, 201, 'Chennai', 'Coimbatore', '2024-12-29 08:00:00', 500.00);

drop table ridess;