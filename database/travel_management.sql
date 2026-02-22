-- Create the database
CREATE DATABASE IF NOT EXISTS travel_management;
USE travel_management;

-- =======================
-- USER TABLE
-- =======================
CREATE TABLE USER (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_no VARCHAR(20),
    address VARCHAR(255)
);

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role ENUM('admin', 'customer') DEFAULT 'customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- =======================
-- TYPE_OF_TRIP TABLE
-- =======================
CREATE TABLE TYPE_OF_TRIP (
    trip_id INT AUTO_INCREMENT PRIMARY KEY,
    type ENUM('business', 'solo', 'leisure') NOT NULL
);

-- =======================
-- LOCATION TABLE
-- =======================
CREATE TABLE LOCATION (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- =======================
-- RELATIONSHIP: USER REQUESTS_TRIP
-- =======================
CREATE TABLE REQUESTS_TRIP (
    user_id INT,
    trip_id INT,
    FOREIGN KEY (user_id) REFERENCES USER(user_id) ON DELETE CASCADE,
    FOREIGN KEY (trip_id) REFERENCES TYPE_OF_TRIP(trip_id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, trip_id)
);

-- =======================
-- RELATIONSHIP: TYPE_OF_TRIP HAS LOCATION
-- =======================
CREATE TABLE HAS (
    trip_id INT,
    location_id INT,
    FOREIGN KEY (trip_id) REFERENCES TYPE_OF_TRIP(trip_id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES LOCATION(location_id) ON DELETE CASCADE,
    PRIMARY KEY (trip_id, location_id)
);

-- =======================
-- ACCOMMODATION TABLE
-- =======================
CREATE TABLE ACCOMMODATION (
    accommodation_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(100),
    check_in_date DATE,
    check_out_date DATE,
    price_per_night DECIMAL(10,2),
    available_room INT
);

-- =======================
-- HOTEL_BOOKING RELATIONSHIP
-- =======================
CREATE TABLE HOTEL_BOOKING (
    location_id INT,
    accommodation_id INT,
    FOREIGN KEY (location_id) REFERENCES LOCATION(location_id) ON DELETE CASCADE,
    FOREIGN KEY (accommodation_id) REFERENCES ACCOMMODATION(accommodation_id) ON DELETE CASCADE,
    PRIMARY KEY (location_id, accommodation_id)
);

-- =======================
-- PAYMENT TABLE
-- =======================
CREATE TABLE PAYMENT (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    payment_method VARCHAR(50),
    amount DECIMAL(10,2),
    transaction_id VARCHAR(50),
    booking_id INT
);

-- =======================
-- BOOKING_PAYMENT RELATIONSHIP
-- =======================
CREATE TABLE BOOKING_PAYMENT (
    accommodation_id INT,
    payment_id INT,
    FOREIGN KEY (accommodation_id) REFERENCES ACCOMMODATION(accommodation_id) ON DELETE CASCADE,
    FOREIGN KEY (payment_id) REFERENCES PAYMENT(payment_id) ON DELETE CASCADE,
    PRIMARY KEY (accommodation_id, payment_id)
);

-- =======================
-- MODE_OF_TRANSPORT TABLE
-- =======================
CREATE TABLE MODE_OF_TRANSPORT (
    mode_id INT AUTO_INCREMENT PRIMARY KEY,
    self ENUM('flight', 'train') NOT NULL
);

-- =======================
-- FLIGHT TABLE
-- =======================
CREATE TABLE FLIGHT (
    flight_id INT AUTO_INCREMENT PRIMARY KEY,
    departure_airport VARCHAR(100),
    arrival_airport VARCHAR(100),
    departure_time DATETIME,
    arrival_time DATETIME,
    price DECIMAL(10,2),
    no_of_available_seats INT
);

-- =======================
-- TRAIN TABLE
-- =======================
CREATE TABLE TRAIN (
    train_id INT AUTO_INCREMENT PRIMARY KEY,
    arrival_destination VARCHAR(100),
    departure_time DATETIME,
    arrival_time DATETIME,
    price DECIMAL(10,2),
    available_seats INT
);

-- =======================
-- TRANSPORT RELATIONSHIP
-- =======================
CREATE TABLE TRANSPORT (
    location_id INT,
    mode_id INT,
    FOREIGN KEY (location_id) REFERENCES LOCATION(location_id) ON DELETE CASCADE,
    FOREIGN KEY (mode_id) REFERENCES MODE_OF_TRANSPORT(mode_id) ON DELETE CASCADE,
    PRIMARY KEY (location_id, mode_id)
);

-- =======================
-- SAMPLE DATA
-- =======================
INSERT INTO USER (name, username, email, phone_no, address)
VALUES 
('John Doe', 'johndoe', 'john@example.com', '9876543210', 'Pune, India');

INSERT INTO TYPE_OF_TRIP (type) VALUES ('business'), ('solo'), ('leisure');

INSERT INTO LOCATION (name) VALUES ('Mumbai'), ('Delhi'), ('Bangalore');

INSERT INTO ACCOMMODATION (name, location, check_in_date, check_out_date, price_per_night, available_room)
VALUES 
('Taj Hotel', 'Mumbai', '2025-11-01', '2025-11-05', 4500.00, 10),
('Leela Palace', 'Delhi', '2025-11-03', '2025-11-07', 5500.00, 5);

INSERT INTO FLIGHT (departure_airport, arrival_airport, departure_time, arrival_time, price, no_of_available_seats)
VALUES
("Mumbai", "Delhi", "2025-02-10 08:00:00", "2025-02-10 10:30:00", 5500, 120),
("Bangalore", "Goa", "2025-02-11 14:00:00", "2025-02-11 15:10:00", 3200, 80),
("Hyderabad", "Kolkata", "2025-02-12 18:30:00", "2025-02-12 21:40:00", 6800, 95);

INSERT INTO TRAIN (arrival_destination, departure_time, arrival_time, price, available_seats)
VALUES
("Delhi", "2025-02-10 07:10:00", "2025-02-10 14:00:00", 1200, 300),
("Mumbai", "2025-02-11 11:30:00", "2025-02-11 19:50:00", 1500, 180),
("Goa", "2025-02-12 16:20:00", "2025-02-12 23:40:00", 900, 220);

-- =======================
-- Dubai Hotels
-- =======================
	
INSERT INTO ACCOMMODATION 
(name, location, check_in_date, check_out_date, price_per_night, available_room)
VALUES
("Burj Al Arab", "Dubai", "2025-05-05", "2025-05-10", 25000, 5),
("Atlantis The Palm", "Dubai", "2025-05-03", "2025-05-06", 18000, 12),
("Rixos Premium Dubai", "Dubai", "2025-05-02", "2025-05-07", 15000, 20);

-- =======================
-- Paris hotels
-- =======================


INSERT INTO ACCOMMODATION 
(name, location, check_in_date, check_out_date, price_per_night, available_room)
VALUES
("Hotel Le Meurice", "Paris", "2025-06-01", "2025-06-05", 20000, 6),
("Shangri-La Hotel Paris", "Paris", "2025-06-02", "2025-06-06", 18000, 10),
("Le Bristol Paris", "Paris", "2025-06-03", "2025-06-07", 22000, 7);

-- =======================
-- tokyo hotels
-- =======================

INSERT INTO ACCOMMODATION 
(name, location, check_in_date, check_out_date, price_per_night, available_room)
VALUES
("Park Hyatt Tokyo", "Tokyo", "2025-07-01", "2025-07-04", 14000, 5),
("The Ritz-Carlton Tokyo", "Tokyo", "2025-07-02", "2025-07-08", 16000, 12),
("Grand Hyatt Tokyo", "Tokyo", "2025-07-03", "2025-07-09", 13000, 15);

-- ========================
-- Dubai flights
-- ========================
INSERT INTO FLIGHT 
(departure_airport, arrival_airport, departure_time, arrival_time, price, no_of_available_seats)
VALUES
("Mumbai", "Dubai", "2025-03-01 09:00:00", "2025-03-01 11:30:00", 15000, 40),
("Delhi", "Dubai", "2025-03-02 08:30:00", "2025-03-02 11:00:00", 14500, 50),
("Chennai", "Dubai", "2025-03-03 07:00:00", "2025-03-03 10:00:00", 14000, 35);

-- =========================
-- bali flights
-- =========================
INSERT INTO FLIGHT
(departure_airport, arrival_airport, departure_time, arrival_time, price, no_of_available_seats)
VALUES
("Mumbai", "Bali", "2025-03-05 02:00:00", "2025-03-05 12:30:00", 22000, 30),
("Delhi", "Bali", "2025-03-06 01:30:00", "2025-03-06 12:00:00", 21000, 25),
("Singapore", "Bali", "2025-03-02 15:00:00", "2025-03-02 19:00:00", 8000, 60);

-- =========================
-- tokyo flights
-- =========================
INSERT INTO FLIGHT
(departure_airport, arrival_airport, departure_time, arrival_time, price, no_of_available_seats)
VALUES
("Delhi", "Tokyo", "2025-03-10 23:30:00", "2025-03-11 14:30:00", 35000, 20),
("Mumbai", "Tokyo", "2025-03-09 22:00:00", "2025-03-10 13:00:00", 36000, 18),
("Singapore", "Tokyo", "2025-03-05 09:00:00", "2025-03-05 16:00:00", 20000, 40);

-- ==========================
-- maldives flights
-- ==========================
INSERT INTO FLIGHT
(departure_airport, arrival_airport, departure_time, arrival_time, price, no_of_available_seats)
VALUES
("Mumbai", "Maldives", "2025-03-04 06:00:00", "2025-03-04 08:00:00", 12000, 50),
("Delhi", "Maldives", "2025-03-07 07:30:00", "2025-03-07 10:00:00", 11000, 45),
("Bangalore", "Maldives", "2025-03-06 09:30:00", "2025-03-06 11:45:00", 10000, 35);

-- ==============
-- itinerary 
-- ==============
CREATE TABLE ITINERARY (
    itinerary_id INT AUTO_INCREMENT PRIMARY KEY,
    destination VARCHAR(100) NOT NULL,
    activity VARCHAR(255) NOT NULL
);
INSERT INTO ITINERARY (destination, activity) VALUES
('Dubai', 'Visit Burj Khalifa'),
('Dubai', 'Dubai Mall & Fountain Show'),
('Dubai', 'Desert Safari Adventure'),
('Dubai', 'Marina Dhow Cruise Dinner');

INSERT INTO ITINERARY (destination, activity) VALUES
('Bali', 'Ubud Rice Terraces'),
('Bali', 'Kuta Beach Relaxation'),
('Bali', 'Tanah Lot Temple'),
('Bali', 'Mount Batur Sunrise Trek');

INSERT INTO ITINERARY (destination, activity) VALUES
('Maldives', 'Private Beach Resort Relaxation'),
('Maldives', 'Snorkeling with Marine Life'),
('Maldives', 'Sunset Cruise'),
('Maldives', 'Overwater Villa Experience');

INSERT INTO ITINERARY (destination, activity) VALUES
('Paris', 'Eiffel Tower'),
('Paris', 'Louvre Museum'),
('Paris', 'Seine River Cruise'),
('Paris', 'Notre Dame Cathedral');

-- =============
-- more insertion

INSERT INTO accommodation (name, location, check_in_date, check_out_date, price_per_night, available_room)
VALUES
('Rixos Premium Dubai', 'Dubai', '2025-11-12', '2025-11-15', 15000.00, 10),
('Palm Island Resort', 'Dubai', '2025-11-13', '2025-11-18', 12500.00, 15),

('Bali Bliss Resort', 'Bali', '2025-11-12', '2025-11-16', 9000.00, 8),
('Ubud Jungle Retreat', 'Bali', '2025-11-13', '2025-11-19', 11000.00, 6),

('Maldives Coral Haven', 'Maldives', '2025-11-15', '2025-11-20', 20000.00, 12),
('Oceanic Pearl Resort', 'Maldives', '2025-11-14', '2025-11-19', 18500.00, 7),

('Tokyo Grand Hotel', 'Tokyo', '2025-11-10', '2025-11-14', 17000.00, 20),
('Shinjuku Sky Tower', 'Tokyo', '2025-11-11', '2025-11-15', 19000.00, 18),

('Eiffel Luxe', 'Paris', '2025-11-16', '2025-11-20', 22000.00, 9),
('Champs Elysees Suites', 'Paris', '2025-11-17', '2025-11-21', 21000.00, 10);



INSERT INTO flight (departure_airport, arrival_airport, departure_time, arrival_time, price, no_of_available_seats)
VALUES
('Mumbai', 'Dubai', '2025-11-12 08:00:00', '2025-11-12 10:30:00', 15000.00, 120),
('Delhi', 'Bali', '2025-11-13 06:00:00', '2025-11-13 12:00:00', 22000.00, 100),
('Mumbai', 'Tokyo', '2025-11-14 09:00:00', '2025-11-14 18:30:00', 32000.00, 80),
('Chennai', 'Maldives', '2025-11-15 07:00:00', '2025-11-15 10:30:00', 18000.00, 150),
('Delhi', 'Paris', '2025-11-16 04:00:00', '2025-11-16 11:00:00', 45000.00, 90);

INSERT INTO users (username, password, role)
VALUES ('admin', 'admin123', 'admin'),
       ('sanjit', 'sanjit123', 'customer');

-- ===============
-- bookings table

CREATE TABLE booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    accommodation_id INT,
    transport_type VARCHAR(50),
    transport_id INT,
    itinerary_id INT,
    payment_id INT,
    total_amount DECIMAL(10,2),
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (accommodation_id) REFERENCES accommodation(accommodation_id),
    FOREIGN KEY (payment_id) REFERENCES payment(payment_id),
    FOREIGN KEY (itinerary_id) REFERENCES itinerary(itinerary_id)
);
INSERT INTO users (username, password, role)
VALUES ('sanjit', '1234', 'customer');


SELECT * FROM booking;
SELECT * FROM payment;


SELECT * FROM booking;
SHOW TABLES;
DESCRIBE ACCOMMODATION;