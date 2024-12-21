drop table Airline CASCADE CONSTRAINTS;
drop table Catering CASCADE CONSTRAINTS;
drop table Flight_Info CASCADE CONSTRAINTS;
drop table Flight_Status CASCADE CONSTRAINTS;
drop table Aircraft CASCADE CONSTRAINTS;
drop table Airport CASCADE CONSTRAINTS;
drop table Passenger CASCADE CONSTRAINTS; 
drop table Ticket CASCADE CONSTRAINTS;
drop table Employee CASCADE CONSTRAINTS;
drop table Pilot CASCADE CONSTRAINTS;
drop table Crew CASCADE CONSTRAINTS;
drop table Contains CASCADE CONSTRAINTS;
drop table Passenger_Phone CASCADE CONSTRAINTS;


CREATE TABLE Airline (
    airline_id VARCHAR2(20) PRIMARY KEY,
    airline_name VARCHAR2(100),
    phone_number VARCHAR2(18),
    email VARCHAR2(100)  
);

CREATE TABLE Flight_Info (
    flight_id VARCHAR2(20) PRIMARY KEY,
    flight_type VARCHAR2(20) CHECK (Flight_Type IN ('Domestic', 'International')),
    passenger_capacity NUMBER(5),
    departure_terminal VARCHAR2(20),
    arrival_terminal VARCHAR2(20),
    departure_airport VARCHAR2(50),
    arrival_airport VARCHAR2(50),
    baggage_allowance VARCHAR2(10), 
    airline_id VARCHAR2(20),
    FOREIGN KEY (airline_id) REFERENCES Airline(airline_id)
);

CREATE TABLE Flight_Status (
    flight_id VARCHAR2(20),
    scheduled_departure_time TIMESTAMP,
    scheduled_arrival_time TIMESTAMP,
    actual_departure_time TIMESTAMP,
    actual_arrival_time TIMESTAMP,
    delay AS (actual_departure_time - scheduled_departure_time), 
    reason_of_delay VARCHAR2(50),
    duration AS (actual_arrival_time - actual_departure_time),
    PRIMARY KEY (flight_id),
    FOREIGN KEY (flight_id) REFERENCES Flight_Info(flight_id) 
);

CREATE TABLE Passenger (
    passenger_id VARCHAR2(20) PRIMARY KEY,
    passenger_name VARCHAR2(100),
    street VARCHAR2(100),
    country VARCHAR2(100),
    city VARCHAR2(100),
    road_no VARCHAR2(100),
    dob DATE,
    flight_id VARCHAR2(20),   
    membership VARCHAR2(50),
    visa VARCHAR2(50),
    passport_no VARCHAR2(50),
    FOREIGN KEY (flight_id) REFERENCES Flight_Info(flight_id) on delete cascade
);

-- Multivalued attribute for phone numbers
CREATE TABLE Passenger_Phone (
    passenger_id VARCHAR2(20),
    phone_number VARCHAR2(20),
    PRIMARY KEY (passenger_id, phone_number),
    FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id)
);


CREATE TABLE Catering (
    catering_id VARCHAR2(20) PRIMARY KEY,
    meal_name VARCHAR2(20),
    meal_type VARCHAR2(50),
    flight_id VARCHAR2(20),
    FOREIGN KEY (flight_id) REFERENCES Flight_Info(flight_id) 
);

CREATE TABLE Aircraft (
    aircraft_id VARCHAR2(20) PRIMARY KEY,
    serial_no VARCHAR2(20), 
    flight_hours NUMBER(10),
    seating_capacity NUMBER(5),
    airline_id VARCHAR2(20),
    FOREIGN KEY (airline_id) REFERENCES Airline(airline_id) 
);

CREATE TABLE Airport (
    airport_id VARCHAR2(20) PRIMARY KEY,
    airport_name VARCHAR2(100),
    location VARCHAR2(100)
    
     
);

--Many to Many relation between Airport and Airline
CREATE TABLE Contains (
    airport_id VARCHAR2(20),
    airline_id VARCHAR2(20),
    PRIMARY KEY (airport_id, airline_id),
    FOREIGN KEY (airport_id) REFERENCES Airport(airport_id),
    FOREIGN KEY (airline_id) REFERENCES Airline(airline_id)
);


CREATE TABLE Employee (
    employee_id VARCHAR2(20) PRIMARY KEY,
    employee_name VARCHAR2(100),
    hire_date DATE,
    contract VARCHAR2(50),
    employee_type VARCHAR2(50),
    flight_id VARCHAR2(20), 
    FOREIGN KEY (flight_id) REFERENCES Flight_Info(flight_id)
);

--pilot
CREATE TABLE Pilot (
    employee_id VARCHAR2(20) PRIMARY KEY,
    license_no VARCHAR2(20),
    salary_per_flight NUMBER(10),
	FOREIGN KEY (employee_ID) REFERENCES Employee(employee_ID) 
);
--crew
CREATE TABLE Crew (
    employee_id VARCHAR2(20) PRIMARY KEY,
    role VARCHAR2(50),
    salary_per_month NUMBER(10, 2),
	FOREIGN KEY (employee_ID) REFERENCES Employee(employee_ID)
);

CREATE TABLE Ticket (
    ticket_no VARCHAR2(20) PRIMARY KEY,
    class VARCHAR2(10),
    price NUMBER(10, 2),
    seat_no VARCHAR2(10),
    passenger_id VARCHAR2(20),
    FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id) on delete cascade
);


INSERT INTO Airline 
VALUES ('A001', 'American Airlines', '+1-800-123-4567', 'contact@americanairlines.com');

INSERT INTO Airline 
VALUES ('A002', 'United Airlines', '+1-800-789-1234', 'support@united.com');

INSERT INTO Airline 
VALUES ('A003', 'British Airways', '+44-800-555-1234', 'info@britishairways.com');

INSERT INTO Airline 
VALUES ('A004', 'Air Canada', '+1-888-123-4567', 'service@aircanada.ca');

INSERT INTO Airline 
VALUES ('A005', 'Qantas', '+61-800-123-4567', 'help@qantas.com.au');

INSERT INTO Airline 
VALUES ('A006', 'Delta Airlines', '+1-800-456-7890', 'support@delta.com');

INSERT INTO Airline 
VALUES ('A007', 'Virgin Atlantic', '+44-800-789-4567', 'info@virginatlantic.com');

INSERT INTO Airline 
VALUES ('A008', 'Southwest Airlines', '+1-800-987-6543', 'contact@southwest.com');

INSERT INTO Airline 
VALUES ('A009', 'WestJet', '+1-888-654-9876', 'info@westjet.com');

INSERT INTO Airline 
VALUES ('A010', 'Emirates', '+971-800-123-4567', 'support@emirates.com');

INSERT INTO Airline 
VALUES ('A011', 'JetBlue', '+1-800-321-6543', 'help@jetblue.com');

INSERT INTO Airline 
VALUES ('A012', 'Lufthansa', '+49-800-123-4567', 'service@lufthansa.com');

INSERT INTO Airline 
VALUES ('A013', 'Spirit Airlines', '+1-800-987-3210', 'support@spirit.com');

INSERT INTO Airline 
VALUES ('A014', 'Frontier Airlines', '+1-800-654-9870', 'support@flyfrontier.com');

INSERT INTO Airline 
VALUES ('A015', 'Hawaiian Airlines', '+1-800-123-4568', 'contact@hawaiianair.com');

INSERT INTO Airline 
VALUES ('A016', 'Alaska Airlines', '+1-800-654-3210', 'support@alaskaair.com');

INSERT INTO Airline 
VALUES ('A017', 'Singapore Airlines', '+65-6222-1234', 'info@singaporeair.com');

INSERT INTO Airline 
VALUES ('A018', 'Qatar Airways', '+974-800-1234', 'support@qatarairways.com');

INSERT INTO Airline 
VALUES ('A019', 'Turkish Airlines', '+90-800-123-4567', 'support@turkishairlines.com');

INSERT INTO Airline 
VALUES ('A020', 'Etihad Airways', '+971-800-789-1234', 'contact@etihad.com');

INSERT INTO Airline 
VALUES ('A021', 'KLM Royal Dutch Airlines', '+31-800-123-4567', 'info@klm.com');

INSERT INTO Airline 
VALUES ('A022', 'Cathay Pacific', '+852-800-123-6543', 'support@cathaypacific.com');

INSERT INTO Airline 
VALUES ('A023', 'Japan Airlines', '+81-800-123-9876', 'contact@jal.com');

INSERT INTO Airline 
VALUES ('A024', 'Avianca', '+57-800-456-1234', 'service@avianca.com');

INSERT INTO Airline 
VALUES ('A025', 'Air France', '+33-800-789-4567', 'support@airfrance.com');


INSERT INTO Flight_Info
VALUES ('F001', 'Domestic', 180, 'T1', 'T3', 'JFK', 'LAX', '20 KGs', 'A001');

INSERT INTO Flight_Info
VALUES ('F002', 'International', 240, 'T2', 'T5', 'ORD', 'LHR', '30 KGs', 'A001');

INSERT INTO Flight_Info 
VALUES ('F003', 'Domestic', 150, 'T1', 'T2', 'LAX', 'SFO', '15 KGs', 'A003');

INSERT INTO Flight_Info 
VALUES ('F004', 'International', 220, 'T3', 'T4', 'YYZ', 'CDG', '30 KGs', 'A004');

INSERT INTO Flight_Info 
VALUES ('F005', 'Domestic', 180, 'T1', 'T2', 'SYD', 'MEL', '20 KGs', 'A005');

INSERT INTO Flight_Info 
VALUES ('F006', 'Domestic', 160, 'T2', 'T3', 'ATL', 'MIA', '20 KGs', 'A006');

INSERT INTO Flight_Info 
VALUES ('F007', 'International', 200, 'T3', 'T1', 'JFK', 'LGW', '30 KGs', 'A007');

INSERT INTO Flight_Info 
VALUES ('F008', 'Domestic', 190, 'T1', 'T4', 'SFO', 'LAS', '20 KGs', 'A007');

INSERT INTO Flight_Info 
VALUES ('F009', 'International', 210, 'T2', 'T3', 'YYC', 'LAX', '25 KGs', 'A009');

INSERT INTO Flight_Info 
VALUES ('F010', 'International', 230, 'T3', 'T5', 'DXB', 'JFK', '30 KGs', 'A010');

INSERT INTO Flight_Info 
VALUES ('F011', 'Domestic', 170, 'T1', 'T2', 'BOS', 'ORD', '20 KGs', 'A011');

INSERT INTO Flight_Info 
VALUES ('F012', 'International', 240, 'T2', 'T3', 'FRA', 'YUL', '30 KGs', 'A012');

INSERT INTO Flight_Info 
VALUES ('F013', 'Domestic', 160, 'T1', 'T3', 'MCO', 'ATL', '20 KGs', 'A013');

INSERT INTO Flight_Info 
VALUES ('F014', 'Domestic', 180, 'T2', 'T3', 'PHX', 'DEN', '20 KGs', 'A014');

INSERT INTO Flight_Info 
VALUES ('F015', 'Domestic', 190, 'T1', 'T2', 'HNL', 'LAX', '20 KGs', 'A015');

INSERT INTO Flight_Info 
VALUES ('F016', 'International', 200, 'T3', 'T4', 'SEA', 'NRT', '30 KGs', 'A016');

INSERT INTO Flight_Info 
VALUES ('F017', 'International', 220, 'T1', 'T5', 'SIN', 'HKG', '30 KGs', 'A017');

INSERT INTO Flight_Info 
VALUES ('F018', 'International', 240, 'T2', 'T3', 'DOH', 'CDG', '30 KGs', 'A018');

INSERT INTO Flight_Info 
VALUES ('F019', 'International', 230, 'T3', 'T4', 'IST', 'LAX', '30 KGs', 'A019');

INSERT INTO Flight_Info 
VALUES ('F020', 'International', 250, 'T1', 'T5', 'AUH', 'JFK', '30 KGs', 'A020');

INSERT INTO Flight_Info 
VALUES ('F021', 'International', 220, 'T2', 'T3', 'AMS', 'SFO', '30 KGs', 'A021');

INSERT INTO Flight_Info 
VALUES ('F022', 'International', 240, 'T3', 'T4', 'HKG', 'NRT', '30 KGs', 'A022');

INSERT INTO Flight_Info 
VALUES ('F023', 'International', 250, 'T1', 'T5', 'TYO', 'SIN', '30 KGs', 'A023');

select * from flight_info;



-- Insert all flight data without delay and duration columns
INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F001', TO_DATE('2023-09-21 08:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-09-21 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-21 08:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-21 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Bad weather');

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F002', TO_DATE('2023-09-22 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-22 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-22 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-22 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL);

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F003', TO_DATE('2023-09-23 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-23 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-23 13:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-23 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Late passenger boarding');

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F004', TO_DATE('2023-09-24 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-24 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-24 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-24 14:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Maintenance delay');

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F005', TO_DATE('2023-09-25 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-25 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-25 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-25 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), NULL);

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F006', TO_DATE('2023-09-26 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-26 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-26 16:20:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-26 19:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Security check');

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F007', TO_DATE('2023-09-27 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-27 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-27 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Late boarding');

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F008', TO_DATE('2023-09-28 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-28 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-28 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-28 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), NULL);

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F009', TO_DATE('2023-09-29 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-29 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-29 13:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-29 16:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'Refueling delay');

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F010', TO_DATE('2023-09-30 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-30 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-30 08:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-30 11:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Technical issues');

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F011', TO_DATE('2023-10-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-01 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-01 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL);

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F012', TO_DATE('2023-10-02 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-02 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-02 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-02 18:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'Late crew arrival');

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F013', TO_DATE('2023-10-03 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-03 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-03 07:10:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-03 11:10:00', 'YYYY-MM-DD HH24:MI:SS'), 'Runway clearance');

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F014', TO_DATE('2023-10-04 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-04 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-04 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-04 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), NULL);

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F015', TO_DATE('2023-10-05 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-05 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-05 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Air traffic control delay');

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F016', TO_DATE('2023-10-06 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-06 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-06 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-06 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), NULL);

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F017', TO_DATE('2023-10-07 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-07 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-07 11:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-07 16:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Technical delay');

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F018', TO_DATE('2023-10-08 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-08 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-08 14:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-08 17:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Passenger disturbance');

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F019', TO_DATE('2023-10-09 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-09 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-09 18:20:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-09 21:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Security clearance delay');

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F020', TO_DATE('2023-10-10 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-10 19:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-10 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-10 19:30:00', 'YYYY-MM-DD HH24:MI:SS'), NULL);

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F021', TO_DATE('2023-10-11 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-11 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-11 14:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-11 22:10:00', 'YYYY-MM-DD HH24:MI:SS'), 'Technical delay');

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F022', TO_DATE('2023-10-12 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-12 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-12 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-12 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL);

INSERT INTO Flight_Status (flight_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, reason_of_delay)
VALUES ('F023', TO_DATE('2023-10-13 16:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-13 20:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-13 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-13 20:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Late crew arrival');


select * from flight_status;


INSERT INTO Passenger 
VALUES ('P001', 'John Doe', '123 Main St', 'USA', 'New York', 'NY 10001', TO_DATE('1985-07-14', 'YYYY-MM-DD'), 'F001', 'Gold', 'B1', 'US123456');

INSERT INTO Passenger 
VALUES ('P002', 'Jane Smith', '456 Elm St', 'USA', 'Chicago', 'IL 60616', TO_DATE('1990-03-25', 'YYYY-MM-DD'), 'F002', 'Silver', 'B2', 'US654321');

INSERT INTO Passenger 
VALUES ('P003', 'Michael Johnson', '789 Oak St', 'UK', 'London', 'EC1A 1BB', TO_DATE('1980-11-05', 'YYYY-MM-DD'), 'F003', 'Platinum', 'B1', 'UK987654');

INSERT INTO Passenger 
VALUES ('P004', 'Emily Davis', '234 Maple Ave', 'Canada', 'Toronto', 'ON M4W 1A9', TO_DATE('1995-06-15', 'YYYY-MM-DD'), 'F004', 'Gold', 'C1', 'CA987123');

INSERT INTO Passenger 
VALUES ('P005', 'Robert Wilson', '567 Pine St', 'Australia', 'Sydney', 'NSW 2000', TO_DATE('1987-12-05', 'YYYY-MM-DD'), 'F005', 'Platinum', 'B1', 'AU456789');

INSERT INTO Passenger 
VALUES ('P006', 'Sophia Brown', '890 Cedar St', 'USA', 'Los Angeles', 'CA 90001', TO_DATE('1992-09-20', 'YYYY-MM-DD'), 'F006', 'Silver', 'B2', 'US852963');

INSERT INTO Passenger 
VALUES ('P007', 'James Taylor', '345 Birch St', 'UK', 'Manchester', 'M1 2AQ', TO_DATE('1988-04-30', 'YYYY-MM-DD'), 'F007', 'Gold', 'B1', 'UK852741');

INSERT INTO Passenger 
VALUES ('P008', 'Olivia Martin', '678 Willow St', 'USA', 'Houston', 'TX 77002', TO_DATE('1991-11-10', 'YYYY-MM-DD'), 'F008', 'Silver', 'B2', 'US159753');

INSERT INTO Passenger 
VALUES ('P009', 'Liam Harris', '135 Oak St', 'Canada', 'Vancouver', 'BC V5K 0A1', TO_DATE('1994-08-25', 'YYYY-MM-DD'), 'F009', 'Gold', 'C1', 'CA321654');

INSERT INTO Passenger 
VALUES ('P010', 'Ava Lee', '246 Fir St', 'Australia', 'Melbourne', 'VIC 3000', TO_DATE('1993-03-14', 'YYYY-MM-DD'), 'F010', 'Platinum', 'B1', 'AU753159');

INSERT INTO Passenger 
VALUES ('P011', 'William Garcia', '357 Aspen St', 'USA', 'San Francisco', 'CA 94102', TO_DATE('1989-07-22', 'YYYY-MM-DD'), 'F011', 'Silver', 'B2', 'US456123');

INSERT INTO Passenger 
VALUES ('P012', 'Isabella Clark', '468 Cypress St', 'UK', 'Birmingham', 'B1 1AA', TO_DATE('1996-05-18', 'YYYY-MM-DD'), 'F012', 'Gold', 'B1', 'UK369852');

INSERT INTO Passenger 
VALUES ('P013', 'Noah Adams', '579 Redwood St', 'USA', 'Atlanta', 'GA 30303', TO_DATE('1986-02-28', 'YYYY-MM-DD'), 'F013', 'Silver', 'B2', 'US258963');

INSERT INTO Passenger 
VALUES ('P014', 'Mia Rodriguez', '680 Sequoia St', 'Canada', 'Calgary', 'AB T2P 2C4', TO_DATE('1997-01-09', 'YYYY-MM-DD'), 'F014', 'Gold', 'C1', 'CA147258');

INSERT INTO Passenger 
VALUES ('P015', 'Ethan Walker', '791 Sycamore St', 'Australia', 'Perth', 'WA 6000', TO_DATE('1985-11-16', 'YYYY-MM-DD'), 'F015', 'Platinum', 'B1', 'AU963852');

INSERT INTO Passenger 
VALUES ('P016', 'Charlotte Hall', '902 Hickory St', 'USA', 'Phoenix', 'AZ 85004', TO_DATE('1992-07-08', 'YYYY-MM-DD'), 'F016', 'Silver', 'B2', 'US369741');

INSERT INTO Passenger 
VALUES ('P017', 'Mason Scott', '123 Palm St', 'UK', 'Glasgow', 'G1 2AA', TO_DATE('1987-05-06', 'YYYY-MM-DD'), 'F017', 'Gold', 'B1', 'UK741852');

INSERT INTO Passenger 
VALUES ('P018', 'Amelia Young', '234 Spruce St', 'Canada', 'Ottawa', 'ON K1A 0B1', TO_DATE('1993-09-17', 'YYYY-MM-DD'), 'F018', 'Silver', 'C1', 'CA963741');

INSERT INTO Passenger 
VALUES ('P019', 'Alexander Lewis', '345 Maple St', 'Australia', 'Adelaide', 'SA 5000', TO_DATE('1989-10-12', 'YYYY-MM-DD'), 'F019', 'Platinum', 'B1', 'AU147369');

INSERT INTO Passenger 
VALUES ('P020', 'Harper King', '456 Elmwood St', 'USA', 'Dallas', 'TX 75201', TO_DATE('1991-12-30', 'YYYY-MM-DD'), 'F020', 'Silver', 'B2', 'US789654');

INSERT INTO Passenger 
VALUES ('P021', 'Sophie Turner', '345 River St', 'USA', 'Seattle', 'WA 98101', TO_DATE('1988-09-15', 'YYYY-MM-DD'), 'F001', 'Gold', 'B1', 'US123457');

INSERT INTO Passenger 
VALUES ('P022', 'Lucas White', '567 Lake St', 'Canada', 'Ottawa', 'ON K1P 1J7', TO_DATE('1992-12-05', 'YYYY-MM-DD'), 'F002', 'Silver', 'C1', 'CA987124');

INSERT INTO Passenger 
VALUES ('P023', 'Avery Brown', '789 Ocean Ave', 'Australia', 'Brisbane', 'QLD 4000', TO_DATE('1990-01-22', 'YYYY-MM-DD'), 'F003', 'Platinum', 'B1', 'AU456790');

INSERT INTO Passenger 
VALUES ('P024', 'Grace Miller', '901 Shore St', 'UK', 'Bristol', 'BS1 6QT', TO_DATE('1985-08-17', 'YYYY-MM-DD'), 'F004', 'Gold', 'B1', 'UK987655');

INSERT INTO Passenger 
VALUES ('P025', 'Jackson Davis', '135 Sky St', 'USA', 'Phoenix', 'AZ 85001', TO_DATE('1984-04-10', 'YYYY-MM-DD'), 'F005', 'Platinum', 'B1', 'US123458');

INSERT INTO Passenger 
VALUES ('P026', 'Chloe Wilson', '246 Cloud St', 'Canada', 'Montreal', 'QC H2Y 2C1', TO_DATE('1995-02-14', 'YYYY-MM-DD'), 'F006', 'Gold', 'C1', 'CA147259');

INSERT INTO Passenger 
VALUES ('P027', 'Ethan Robinson', '357 Star St', 'UK', 'Edinburgh', 'EH1 3QR', TO_DATE('1989-03-30', 'YYYY-MM-DD'), 'F007', 'Silver', 'B2', 'UK852742');

INSERT INTO Passenger 
VALUES ('P028', 'Zoe Martinez', '468 Sun St', 'Australia', 'Melbourne', 'VIC 3001', TO_DATE('1993-06-12', 'YYYY-MM-DD'), 'F008', 'Platinum', 'B1', 'AU753160');

INSERT INTO Passenger 
VALUES ('P029', 'Liam Anderson', '579 Moon St', 'USA', 'Atlanta', 'GA 30302', TO_DATE('1986-05-01', 'YYYY-MM-DD'), 'F009', 'Silver', 'B2', 'US258964');

INSERT INTO Passenger 
VALUES ('P030', 'Ella Thomas', '680 Star Ave', 'Canada', 'Vancouver', 'BC V5K 1A1', TO_DATE('1994-11-03', 'YYYY-MM-DD'), 'F010', 'Gold', 'C1', 'CA321655');

INSERT INTO Passenger 
VALUES ('P031', 'Aiden Martinez', '791 Night St', 'Australia', 'Sydney', 'NSW 2001', TO_DATE('1987-02-20', 'YYYY-MM-DD'), 'F011', 'Platinum', 'B1', 'AU963853');

INSERT INTO Passenger 
VALUES ('P032', 'Emily Harris', '902 Day St', 'USA', 'Dallas', 'TX 75202', TO_DATE('1991-07-09', 'YYYY-MM-DD'), 'F012', 'Silver', 'B2', 'US456124');

INSERT INTO Passenger 
VALUES ('P033', 'James Thompson', '123 Hill St', 'UK', 'London', 'EC1Y 2AA', TO_DATE('1990-10-25', 'YYYY-MM-DD'), 'F013', 'Gold', 'B1', 'UK369853');

INSERT INTO Passenger 
VALUES ('P034', 'Isabella Taylor', '234 Valley Rd', 'Canada', 'Calgary', 'AB T2P 3B4', TO_DATE('1986-01-14', 'YYYY-MM-DD'), 'F014', 'Gold', 'C1', 'CA147260');

INSERT INTO Passenger 
VALUES ('P035', 'Oliver White', '345 Forest St', 'Australia', 'Brisbane', 'QLD 4002', TO_DATE('1988-12-11', 'YYYY-MM-DD'), 'F015', 'Platinum', 'B1', 'AU963854');

INSERT INTO Passenger 
VALUES ('P036', 'Mia Johnson', '456 Desert Rd', 'USA', 'Los Angeles', 'CA 90002', TO_DATE('1992-08-16', 'YYYY-MM-DD'), 'F016', 'Silver', 'B2', 'US369742');

INSERT INTO Passenger 
VALUES ('P037', 'Sophia Jackson', '567 Garden St', 'UK', 'Manchester', 'M1 2AB', TO_DATE('1991-09-22', 'YYYY-MM-DD'), 'F017', 'Gold', 'B1', 'UK741853');

INSERT INTO Passenger 
VALUES ('P038', 'Benjamin Brown', '678 Farm St', 'Canada', 'Toronto', 'ON M4W 2A2', TO_DATE('1989-03-01', 'YYYY-MM-DD'), 'F018', 'Silver', 'C1', 'CA963742');

INSERT INTO Passenger 
VALUES ('P039', 'Lily Lewis', '789 Park Ave', 'Australia', 'Adelaide', 'SA 5001', TO_DATE('1990-04-05', 'YYYY-MM-DD'), 'F019', 'Platinum', 'B1', 'AU147370');

INSERT INTO Passenger 
VALUES ('P040', 'Avery Hall', '890 Trail St', 'USA', 'San Francisco', 'CA 94103', TO_DATE('1987-07-14', 'YYYY-MM-DD'), 'F020', 'Silver', 'B2', 'US789655');

INSERT INTO Passenger 
VALUES ('P041', 'Zara Thompson', '123 Ocean Blvd', 'USA', 'Miami', 'FL 33139', TO_DATE('1984-01-22', 'YYYY-MM-DD'), 'F021', 'Gold', 'B1', 'US123459');

INSERT INTO Passenger 
VALUES ('P042', 'Samuel Green', '456 River Rd', 'Canada', 'Toronto', 'ON M5G 2C4', TO_DATE('1989-07-11', 'YYYY-MM-DD'), 'F022', 'Silver', 'C1', 'CA987125');

INSERT INTO Passenger 
VALUES ('P043', 'Lily Brown', '789 Sunset St', 'UK', 'London', 'EC1Y 3AA', TO_DATE('1995-03-30', 'YYYY-MM-DD'), 'F023', 'Platinum', 'B1', 'UK369854');

INSERT INTO Passenger 
VALUES ('P044', 'Jackson Smith', '234 Hill St', 'Australia', 'Sydney', 'NSW 2002', TO_DATE('1991-06-18', 'YYYY-MM-DD'), 'F021', 'Gold', 'B1', 'AU963855');

INSERT INTO Passenger 
VALUES ('P045', 'Sophie Patel', '678 Mountain Dr', 'USA', 'Seattle', 'WA 98102', TO_DATE('1988-08-15', 'YYYY-MM-DD'), 'F022', 'Silver', 'B2', 'US123460');

INSERT INTO Passenger 
VALUES ('P046', 'Oliver Harris', '890 Forest Ln', 'Canada', 'Calgary', 'AB T2P 3B5', TO_DATE('1992-05-25', 'YYYY-MM-DD'), 'F023', 'Platinum', 'C1', 'CA147261');

select * from passenger;



INSERT INTO Passenger_Phone 
VALUES ('P001', '+1-555-123-4567');

INSERT INTO Passenger_Phone 
VALUES ('P001', '+1-555-987-6543');

INSERT INTO Passenger_Phone 
VALUES ('P002', '+1-555-456-7890');

INSERT INTO Passenger_Phone 
VALUES ('P003', '+44-20-1234-5678');

INSERT INTO Passenger_Phone 
VALUES ('P004', '+1-416-555-1234');

INSERT INTO Passenger_Phone 
VALUES ('P005', '+61-2-555-6789');

INSERT INTO Passenger_Phone 
VALUES ('P006', '+1-213-555-7890');

INSERT INTO Passenger_Phone 
VALUES ('P007', '+44-161-555-4321');

INSERT INTO Passenger_Phone 
VALUES ('P008', '+1-713-555-6789');

INSERT INTO Passenger_Phone 
VALUES ('P009', '+1-604-555-9876');

INSERT INTO Passenger_Phone 
VALUES ('P010', '+61-3-555-8765');

INSERT INTO Passenger_Phone 
VALUES ('P011', '+1-415-555-1234');

INSERT INTO Passenger_Phone 
VALUES ('P012', '+44-121-555-6543');

INSERT INTO Passenger_Phone 
VALUES ('P013', '+1-404-555-4321');

INSERT INTO Passenger_Phone 
VALUES ('P014', '+1-403-555-8765');

INSERT INTO Passenger_Phone 
VALUES ('P015', '+61-8-555-2345');

INSERT INTO Passenger_Phone 
VALUES ('P016', '+1-602-555-6789');

INSERT INTO Passenger_Phone 
VALUES ('P017', '+44-141-555-1234');

INSERT INTO Passenger_Phone 
VALUES ('P018', '+1-613-555-9876');

INSERT INTO Passenger_Phone 
VALUES ('P019', '+61-8-555-5432');

INSERT INTO Passenger_Phone 
VALUES ('P020', '+1-214-555-6789');

INSERT INTO Passenger_Phone 
VALUES ('P021', '+1-206-555-0001');

INSERT INTO Passenger_Phone 
VALUES ('P021', '+1-206-555-0002');

INSERT INTO Passenger_Phone 
VALUES ('P022', '+1-613-555-0003');

INSERT INTO Passenger_Phone 
VALUES ('P023', '+61-7-555-0004');

INSERT INTO Passenger_Phone 
VALUES ('P024', '+44-117-555-0005');

INSERT INTO Passenger_Phone 
VALUES ('P025', '+1-602-555-0006');

INSERT INTO Passenger_Phone 
VALUES ('P026', '+1-514-555-0007');

INSERT INTO Passenger_Phone 
VALUES ('P027', '+44-131-555-0008');

INSERT INTO Passenger_Phone 
VALUES ('P028', '+61-3-555-0009');

INSERT INTO Passenger_Phone 
VALUES ('P029', '+1-404-555-0010');

INSERT INTO Passenger_Phone 
VALUES ('P030', '+1-604-555-0011');

INSERT INTO Passenger_Phone 
VALUES ('P031', '+61-7-555-0012');

INSERT INTO Passenger_Phone 
VALUES ('P032', '+1-214-555-0013');

INSERT INTO Passenger_Phone 
VALUES ('P033', '+44-20-555-0014');

INSERT INTO Passenger_Phone 
VALUES ('P034', '+1-403-555-0015');

INSERT INTO Passenger_Phone 
VALUES ('P035', '+61-7-555-0016');

INSERT INTO Passenger_Phone 
VALUES ('P036', '+1-213-555-0017');

INSERT INTO Passenger_Phone 
VALUES ('P037', '+44-161-555-0018');

INSERT INTO Passenger_Phone 
VALUES ('P038', '+1-416-555-0019');

INSERT INTO Passenger_Phone 
VALUES ('P039', '+61-8-555-0020');

INSERT INTO Passenger_Phone 
VALUES ('P040', '+1-415-555-0021');

INSERT INTO Passenger_Phone 
VALUES ('P041', '+1-305-555-0001');

INSERT INTO Passenger_Phone 
VALUES ('P041', '+1-305-555-0002');

INSERT INTO Passenger_Phone 
VALUES ('P042', '+1-416-555-0003');

INSERT INTO Passenger_Phone 
VALUES ('P043', '+44-20-555-0004');

INSERT INTO Passenger_Phone 
VALUES ('P044', '+61-2-555-0005');

INSERT INTO Passenger_Phone 
VALUES ('P045', '+1-206-555-0006');

INSERT INTO Passenger_Phone 
VALUES ('P046', '+1-403-555-0007');


select*from passenger_phone;




INSERT INTO Catering 
VALUES ('C001', 'Chicken Sandwich', 'Non-Vegetarian', 'F001');

INSERT INTO Catering 
VALUES ('C002', 'Vegetable Salad', 'Vegetarian', 'F002');

INSERT INTO Catering 
VALUES ('C003', 'Fish Curry', 'Non-Vegetarian', 'F003');

INSERT INTO Catering 
VALUES ('C004', 'Paneer Wrap', 'Vegetarian', 'F004');

INSERT INTO Catering 
VALUES ('C005', 'Beef Stew', 'Non-Vegetarian', 'F005');

INSERT INTO Catering 
VALUES ('C006', 'Fruit Salad', 'Vegetarian', 'F006');

INSERT INTO Catering 
VALUES ('C007', 'Chicken Biryani', 'Non-Vegetarian', 'F007');

INSERT INTO Catering 
VALUES ('C008', 'Pasta Salad', 'Vegetarian', 'F008');

INSERT INTO Catering 
VALUES ('C009', 'Lamb Curry', 'Non-Vegetarian', 'F009');

INSERT INTO Catering 
VALUES ('C010', 'Veggie Sandwich', 'Vegetarian', 'F010');

INSERT INTO Catering 
VALUES ('C011', 'Steak', 'Non-Vegetarian', 'F011');

INSERT INTO Catering 
VALUES ('C012', 'Caesar Salad', 'Vegetarian', 'F012');

INSERT INTO Catering 
VALUES ('C013', 'Chicken Alfredo', 'Non-Vegetarian', 'F013');

INSERT INTO Catering 
VALUES ('C014', 'Vegetable Curry', 'Vegetarian', 'F014');

INSERT INTO Catering 
VALUES ('C015', 'Shrimp Scampi', 'Non-Vegetarian', 'F015');

INSERT INTO Catering 
VALUES ('C016', 'Grilled Vegetables', 'Vegetarian', 'F016');

INSERT INTO Catering 
VALUES ('C017', 'Salmon Steak', 'Non-Vegetarian', 'F017');

INSERT INTO Catering 
VALUES ('C018', 'Quinoa Salad', 'Vegetarian', 'F018');

INSERT INTO Catering 
VALUES ('C019', 'Duck Confit', 'Non-Vegetarian', 'F019');

INSERT INTO Catering 
VALUES ('C020', 'Falafel Wrap', 'Vegetarian', 'F020');

INSERT INTO Catering 
VALUES ('C021', 'Chicken Caesar Wrap', 'Non-Vegetarian', 'F021');

INSERT INTO Catering 
VALUES ('C022', 'Mushroom Risotto', 'Vegetarian', 'F022');

INSERT INTO Catering 
VALUES ('C023', 'Grilled Salmon', 'Non-Vegetarian', 'F023');

select*from catering;


select* from airline;

INSERT INTO Employee 
VALUES ('E001', 'John Doe', TO_DATE('2020-01-15', 'YYYY-MM-DD'), 'Full-Time', 'Pilot', 'F001');

INSERT INTO Employee 
VALUES ('E002', 'Jane Smith', TO_DATE('2019-03-10', 'YYYY-MM-DD'), 'Full-Time', 'Pilot', 'F002');

INSERT INTO Employee 
VALUES ('E003', 'Michael Johnson', TO_DATE('2018-06-21', 'YYYY-MM-DD'), 'Part-Time', 'Pilot', 'F003');

INSERT INTO Employee 
VALUES ('E004', 'Emily Davis', TO_DATE('2021-02-28', 'YYYY-MM-DD'), 'Full-Time', 'Pilot', 'F004');

INSERT INTO Employee 
VALUES ('E005', 'Robert Brown', TO_DATE('2020-11-30', 'YYYY-MM-DD'), 'Full-Time', 'Pilot', 'F005');

INSERT INTO Employee 
VALUES ('E006', 'Sarah Wilson', TO_DATE('2022-01-10', 'YYYY-MM-DD'), 'Part-Time', 'Pilot', 'F006');

INSERT INTO Employee 
VALUES ('E007', 'James Taylor', TO_DATE('2020-09-25', 'YYYY-MM-DD'), 'Full-Time', 'Pilot', 'F007');

INSERT INTO Employee 
VALUES ('E008', 'Olivia Miller', TO_DATE('2019-12-05', 'YYYY-MM-DD'), 'Full-Time', 'Pilot', 'F008');

INSERT INTO Employee 
VALUES ('E009', 'William Lee', TO_DATE('2020-08-18', 'YYYY-MM-DD'), 'Part-Time', 'Pilot', 'F009');

INSERT INTO Employee 
VALUES ('E010', 'Sophia Harris', TO_DATE('2021-05-23', 'YYYY-MM-DD'), 'Full-Time', 'Pilot', 'F010');

INSERT INTO Employee 
VALUES ('E011', 'Benjamin Clark', TO_DATE('2018-07-15', 'YYYY-MM-DD'), 'Full-Time', 'Pilot', 'F011');

INSERT INTO Employee 
VALUES ('E012', 'Charlotte Lewis', TO_DATE('2020-10-01', 'YYYY-MM-DD'), 'Part-Time', 'Pilot', 'F012');

INSERT INTO Employee 
VALUES ('E013', 'Matthew Young', TO_DATE('2021-04-15', 'YYYY-MM-DD'), 'Full-Time', 'Pilot', 'F013');

INSERT INTO Employee 
VALUES ('E014', 'Amelia King', TO_DATE('2022-02-20', 'YYYY-MM-DD'), 'Full-Time', 'Pilot', 'F014');

INSERT INTO Employee 
VALUES ('E015', 'Christopher Scott', TO_DATE('2019-09-12', 'YYYY-MM-DD'), 'Part-Time', 'Pilot', 'F015');

INSERT INTO Employee 
VALUES ('E016', 'Isabella Adams', TO_DATE('2018-05-10', 'YYYY-MM-DD'), 'Full-Time', 'Pilot', 'F016');

INSERT INTO Employee 
VALUES ('E017', 'Daniel Nelson', TO_DATE('2020-06-17', 'YYYY-MM-DD'), 'Full-Time', 'Pilot', 'F017');

INSERT INTO Employee 
VALUES ('E018', 'Mia Moore', TO_DATE('2019-11-30', 'YYYY-MM-DD'), 'Full-Time', 'Pilot', 'F018');

INSERT INTO Employee 
VALUES ('E019', 'Alexander Baker', TO_DATE('2021-03-22', 'YYYY-MM-DD'), 'Part-Time', 'Pilot', 'F019');

INSERT INTO Employee 
VALUES ('E020', 'Evelyn Mitchell', TO_DATE('2022-07-05', 'YYYY-MM-DD'), 'Full-Time', 'Pilot', 'F020');

INSERT INTO Employee 
VALUES ('E021', 'Liam Gonzalez', TO_DATE('2020-01-18', 'YYYY-MM-DD'), 'Full-Time', 'Crew', 'F001');

INSERT INTO Employee 
VALUES ('E022', 'Emma Perez', TO_DATE('2019-06-19', 'YYYY-MM-DD'), 'Full-Time', 'Crew', 'F002');

INSERT INTO Employee 
VALUES ('E023', 'Noah Turner', TO_DATE('2018-08-27', 'YYYY-MM-DD'), 'Part-Time', 'Crew', 'F003');

INSERT INTO Employee 
VALUES ('E024', 'Ava Hill', TO_DATE('2021-12-13', 'YYYY-MM-DD'), 'Full-Time', 'Crew', 'F004');

INSERT INTO Employee 
VALUES ('E025', 'Lucas Flores', TO_DATE('2020-09-14', 'YYYY-MM-DD'), 'Full-Time', 'Crew', 'F005');

INSERT INTO Employee 
VALUES ('E026', 'Mason Rivera', TO_DATE('2022-02-10', 'YYYY-MM-DD'), 'Part-Time', 'Crew', 'F006');

INSERT INTO Employee 
VALUES ('E027', 'Harper Murphy', TO_DATE('2019-04-23', 'YYYY-MM-DD'), 'Full-Time', 'Crew', 'F007');

INSERT INTO Employee 
VALUES ('E028', 'Ethan Bell', TO_DATE('2020-07-30', 'YYYY-MM-DD'), 'Full-Time', 'Crew', 'F008');

INSERT INTO Employee 
VALUES ('E029', 'Avery Howard', TO_DATE('2021-10-09', 'YYYY-MM-DD'), 'Part-Time', 'Crew', 'F009');

INSERT INTO Employee 
VALUES ('E030', 'Logan Ward', TO_DATE('2018-03-15', 'YYYY-MM-DD'), 'Full-Time', 'Crew', 'F010');

INSERT INTO Employee 
VALUES ('E031', 'Ella Brooks', TO_DATE('2020-05-11', 'YYYY-MM-DD'), 'Full-Time', 'Crew', 'F011');

INSERT INTO Employee 
VALUES ('E032', 'Jacob Sanders', TO_DATE('2019-11-20', 'YYYY-MM-DD'), 'Part-Time', 'Crew', 'F012');

INSERT INTO Employee 
VALUES ('E033', 'Sofia Price', TO_DATE('2021-06-25', 'YYYY-MM-DD'), 'Full-Time', 'Crew', 'F013');

INSERT INTO Employee 
VALUES ('E034', 'Michael Coleman', TO_DATE('2022-08-15', 'YYYY-MM-DD'), 'Full-Time', 'Crew', 'F014');

INSERT INTO Employee 
VALUES ('E035', 'Mila Long', TO_DATE('2020-02-14', 'YYYY-MM-DD'), 'Full-Time', 'Crew', 'F015');

INSERT INTO Employee 
VALUES ('E036', 'Jack Foster', TO_DATE('2018-09-30', 'YYYY-MM-DD'), 'Part-Time', 'Crew', 'F016');

INSERT INTO Employee 
VALUES ('E037', 'Grace Ross', TO_DATE('2019-10-22', 'YYYY-MM-DD'), 'Full-Time', 'Crew', 'F017');

INSERT INTO Employee 
VALUES ('E038', 'Sebastian Bryant', TO_DATE('2020-12-07', 'YYYY-MM-DD'), 'Full-Time', 'Crew', 'F018');

INSERT INTO Employee 
VALUES ('E039', 'Zoey Alexander', TO_DATE('2021-03-09', 'YYYY-MM-DD'), 'Part-Time', 'Crew', 'F019');

INSERT INTO Employee 
VALUES ('E040', 'Henry Ramirez', TO_DATE('2022-07-29', 'YYYY-MM-DD'), 'Full-Time', 'Crew', 'F020');

INSERT INTO Employee 
VALUES ('E041', 'Ella Thompson', TO_DATE('2023-01-12', 'YYYY-MM-DD'), 'Full-Time', 'Pilot', 'F021');

INSERT INTO Employee 
VALUES ('E042', 'Liam Wilson', TO_DATE('2023-02-15', 'YYYY-MM-DD'), 'Full-Time', 'Pilot', 'F022');

INSERT INTO Employee 
VALUES ('E043', 'Olivia Martinez', TO_DATE('2023-03-10', 'YYYY-MM-DD'), 'Part-Time', 'Pilot', 'F023');

INSERT INTO Employee 
VALUES ('E044', 'Noah Anderson', TO_DATE('2023-01-20', 'YYYY-MM-DD'), 'Full-Time', 'Crew', 'F021');

INSERT INTO Employee 
VALUES ('E045', 'Sophia Robinson', TO_DATE('2023-02-18', 'YYYY-MM-DD'), 'Full-Time', 'Crew', 'F022');

INSERT INTO Employee 
VALUES ('E046', 'Jackson Lewis', TO_DATE('2023-03-25', 'YYYY-MM-DD'), 'Part-Time', 'Crew', 'F023');



INSERT INTO Pilot  VALUES ('E001', 'L12345', 5000.00);
INSERT INTO Pilot  VALUES ('E002', 'L54321', 4800.00);
INSERT INTO Pilot  VALUES ('E003', 'L67890', 5200.00);
INSERT INTO Pilot  VALUES ('E004', 'L98765', 4900.00);
INSERT INTO Pilot  VALUES ('E005', 'L11223', 5300.00);
INSERT INTO Pilot  VALUES ('E006', 'L33211', 5100.00);
INSERT INTO Pilot  VALUES ('E007', 'L88990', 5500.00);
INSERT INTO Pilot  VALUES ('E008', 'L44567', 4950.00);
INSERT INTO Pilot  VALUES ('E009', 'L99887', 5400.00);
INSERT INTO Pilot  VALUES ('E010', 'L12121', 4700.00);
INSERT INTO Pilot  VALUES ('E011', 'L32123', 4800.00);
INSERT INTO Pilot  VALUES ('E012', 'L87654', 5200.00);
INSERT INTO Pilot  VALUES ('E013', 'L77788', 5300.00);
INSERT INTO Pilot  VALUES ('E014', 'L99900', 5000.00);
INSERT INTO Pilot  VALUES ('E015', 'L56678', 5100.00);
INSERT INTO Pilot  VALUES ('E016', 'L12312', 4850.00);
INSERT INTO Pilot  VALUES ('E017', 'L65432', 5250.00);
INSERT INTO Pilot  VALUES ('E018', 'L33223', 4900.00);
INSERT INTO Pilot  VALUES ('E019', 'L88776', 5400.00);
INSERT INTO Pilot  VALUES ('E020', 'L21112', 5000.00);
INSERT INTO Pilot  VALUES ('E041', 'L11111', 5000.00);
INSERT INTO Pilot  VALUES ('E042', 'L22222', 4900.00);
INSERT INTO Pilot  VALUES ('E043', 'L33333', 5200.00);

select *from pilot;



INSERT INTO Crew  VALUES ('E021', 'Cabin Crew', 3000.00);
INSERT INTO Crew  VALUES ('E022', 'Cabin Crew', 3100.00);
INSERT INTO Crew  VALUES ('E023', 'Ground Staff', 3200.00);
INSERT INTO Crew  VALUES ('E024', 'Ground Staff', 3300.00);
INSERT INTO Crew  VALUES ('E025', 'Cabin Crew', 3000.00);
INSERT INTO Crew  VALUES ('E026', 'Ground Staff', 3200.00);
INSERT INTO Crew  VALUES ('E027', 'Cabin Crew', 3100.00);
INSERT INTO Crew  VALUES ('E028', 'Ground Staff', 3300.00);
INSERT INTO Crew  VALUES ('E029', 'Cabin Crew', 3000.00);
INSERT INTO Crew  VALUES ('E030', 'Ground Staff', 3200.00);
INSERT INTO Crew  VALUES ('E031', 'Cabin Crew', 3000.00);
INSERT INTO Crew  VALUES ('E032', 'Ground Staff', 3200.00);
INSERT INTO Crew  VALUES ('E033', 'Cabin Crew', 3100.00);
INSERT INTO Crew  VALUES ('E034', 'Ground Staff', 3300.00);
INSERT INTO Crew  VALUES ('E035', 'Cabin Crew', 3000.00);
INSERT INTO Crew  VALUES ('E036', 'Ground Staff', 3200.00);
INSERT INTO Crew  VALUES ('E037', 'Cabin Crew', 3000.00);
INSERT INTO Crew  VALUES ('E038', 'Ground Staff', 3200.00);
INSERT INTO Crew  VALUES ('E039', 'Cabin Crew', 3100.00);
INSERT INTO Crew  VALUES ('E040', 'Ground Staff', 3300.00);
INSERT INTO Crew  VALUES ('E044', 'Cabin Crew', 3000.00);
INSERT INTO Crew  VALUES ('E045', 'Cabin Crew', 3100.00);
INSERT INTO Crew  VALUES ('E046', 'Ground Staff', 3200.00);

select*from crew;



INSERT INTO Ticket 
VALUES ('T001', 'Economy', 300.00, '12A', 'P001');

INSERT INTO Ticket 
VALUES ('T002', 'Economy', 320.00, '14B', 'P002');

INSERT INTO Ticket 
VALUES ('T003', 'Business', 1200.00, '2C', 'P003');

INSERT INTO Ticket 
VALUES ('T004', 'Economy', 350.00, '16D', 'P004');

INSERT INTO Ticket 
VALUES ('T005', 'First', 2500.00, '1A', 'P005');

INSERT INTO Ticket 
VALUES ('T006', 'Economy', 300.00, '12B', 'P006');

INSERT INTO Ticket 
VALUES ('T007', 'Business', 1100.00, '3C', 'P007');

INSERT INTO Ticket 
VALUES ('T008', 'Economy', 330.00, '18E', 'P008');

INSERT INTO Ticket 
VALUES ('T009', 'First', 2400.00, '1B', 'P009');

INSERT INTO Ticket 
VALUES ('T010', 'Business', 1150.00, '2D', 'P010');

INSERT INTO Ticket 
VALUES ('T011', 'Economy', 310.00, '17A', 'P011');

INSERT INTO Ticket 
VALUES ('T012', 'Business', 1120.00, '3D', 'P012');

INSERT INTO Ticket 
VALUES ('T013', 'Economy', 340.00, '19C', 'P013');

INSERT INTO Ticket 
VALUES ('T014', 'First', 2600.00, '1C', 'P014');

INSERT INTO Ticket 
VALUES ('T015', 'Economy', 300.00, '12C', 'P015');

INSERT INTO Ticket 
VALUES ('T016', 'Business', 1200.00, '2E', 'P016');

INSERT INTO Ticket 
VALUES ('T017', 'Economy', 310.00, '17B', 'P017');

INSERT INTO Ticket 
VALUES ('T018', 'First', 2500.00, '1D', 'P018');

INSERT INTO Ticket 
VALUES ('T019', 'Economy', 350.00, '19D', 'P019');

INSERT INTO Ticket 
VALUES ('T020', 'Business', 1150.00, '2F', 'P020');

INSERT INTO Ticket 
VALUES ('T021', 'Economy', 310.00, '12D', 'P021');

INSERT INTO Ticket 
VALUES ('T022', 'Economy', 330.00, '14C', 'P022');

INSERT INTO Ticket 
VALUES ('T023', 'Business', 1250.00, '2B', 'P023');

INSERT INTO Ticket 
VALUES ('T024', 'Economy', 340.00, '16E', 'P024');

INSERT INTO Ticket 
VALUES ('T025', 'First', 2550.00, '1E', 'P025');

INSERT INTO Ticket 
VALUES ('T026', 'Economy', 320.00, '12E', 'P026');

INSERT INTO Ticket 
VALUES ('T027', 'Business', 1150.00, '3F', 'P027');

INSERT INTO Ticket 
VALUES ('T028', 'Economy', 335.00, '18A', 'P028');

INSERT INTO Ticket 
VALUES ('T029', 'First', 2450.00, '1F', 'P029');

INSERT INTO Ticket 
VALUES ('T030', 'Business', 1100.00, '2G', 'P030');

INSERT INTO Ticket 
VALUES ('T031', 'Economy', 300.00, '17C', 'P031');

INSERT INTO Ticket 
VALUES ('T032', 'Business', 1220.00, '3H', 'P032');

INSERT INTO Ticket 
VALUES ('T033', 'Economy', 340.00, '19E', 'P033');

INSERT INTO Ticket 
VALUES ('T034', 'First', 2650.00, '1G', 'P034');

INSERT INTO Ticket 
VALUES ('T035', 'Economy', 310.00, '12F', 'P035');

INSERT INTO Ticket 
VALUES ('T036', 'Business', 1180.00, '2I', 'P036');

INSERT INTO Ticket 
VALUES ('T037', 'Economy', 320.00, '17D', 'P037');

INSERT INTO Ticket 
VALUES ('T038', 'First', 2500.00, '1H', 'P038');

INSERT INTO Ticket 
VALUES ('T039', 'Economy', 360.00, '19F', 'P039');

INSERT INTO Ticket 
VALUES ('T040', 'Business', 1120.00, '2J', 'P040');

INSERT INTO Ticket 
VALUES ('T041', 'Economy', 305.00, '12G', 'P041');

INSERT INTO Ticket 
VALUES ('T042', 'Business', 1250.00, '2K', 'P042');

INSERT INTO Ticket 
VALUES ('T043', 'First', 2700.00, '1I', 'P043');

INSERT INTO Ticket 
VALUES ('T044', 'Economy', 315.00, '14D', 'P044');

INSERT INTO Ticket 
VALUES ('T045', 'Business', 1190.00, '3J', 'P045');

INSERT INTO Ticket 
VALUES ('T046', 'First', 2500.00, '1J', 'P046');

select*from ticket;




select*from employee;

 

INSERT INTO Aircraft 
VALUES ('AC001', 'SN12345', 5000, 180, 'A001');

INSERT INTO Aircraft 
VALUES ('AC002', 'SN67890', 3500, 150, 'A002');

INSERT INTO Aircraft 
VALUES ('AC003', 'SN54321', 7200, 250, 'A003');

INSERT INTO Aircraft 
VALUES ('AC004', 'SN98765', 4100, 160, 'A004');

INSERT INTO Aircraft 
VALUES ('AC005', 'SN11223', 6400, 200, 'A005');

INSERT INTO Aircraft 
VALUES ('AC006', 'SN33211', 5300, 180, 'A006');

INSERT INTO Aircraft 
VALUES ('AC007', 'SN88990', 6800, 220, 'A007');

INSERT INTO Aircraft 
VALUES ('AC008', 'SN44567', 4700, 190, 'A008');

INSERT INTO Aircraft 
VALUES ('AC009', 'SN99887', 5200, 170, 'A009');

INSERT INTO Aircraft 
VALUES ('AC010', 'SN12121', 7700, 230, 'A010');

INSERT INTO Aircraft 
VALUES ('AC011', 'SN32123', 4400, 160, 'A011');

INSERT INTO Aircraft 
VALUES ('AC012', 'SN87654', 8100, 240, 'A012');

INSERT INTO Aircraft 
VALUES ('AC013', 'SN77788', 4800, 180, 'A013');

INSERT INTO Aircraft 
VALUES ('AC014', 'SN99900', 6100, 160, 'A014');

INSERT INTO Aircraft 
VALUES ('AC015', 'SN56678', 6700, 210, 'A015');

INSERT INTO Aircraft 
VALUES ('AC016', 'SN12312', 5900, 190, 'A016');

INSERT INTO Aircraft 
VALUES ('AC017', 'SN65432', 8000, 250, 'A017');

INSERT INTO Aircraft 
VALUES ('AC018', 'SN33223', 4600, 180, 'A018');

INSERT INTO Aircraft 
VALUES ('AC019', 'SN88776', 7500, 220, 'A019');

INSERT INTO Aircraft 
VALUES ('AC020', 'SN21112', 4900, 160, 'A020');

INSERT INTO Aircraft 
VALUES ('AC021', 'SN22222', 6200, 210, 'A001');

INSERT INTO Aircraft 
VALUES ('AC022', 'SN33333', 4300, 160, 'A002');

INSERT INTO Aircraft 
VALUES ('AC023', 'SN44444', 7500, 240, 'A003');

INSERT INTO Aircraft 
VALUES ('AC024', 'SN55555', 5900, 190, 'A004');

INSERT INTO Aircraft 
VALUES ('AC025', 'SN66666', 4700, 200, 'A005');

INSERT INTO Aircraft 
VALUES ('AC026', 'SN77777', 5400, 220, 'A006');

INSERT INTO Aircraft 
VALUES ('AC027', 'SN88888', 6600, 170, 'A007');

INSERT INTO Aircraft 
VALUES ('AC028', 'SN99999', 7200, 230, 'A008');

INSERT INTO Aircraft 
VALUES ('AC029', 'SN10101', 4800, 180, 'A009');

INSERT INTO Aircraft 
VALUES ('AC030', 'SN20202', 8000, 250, 'A010');

INSERT INTO Aircraft 
VALUES ('AC031', 'SN22222', 6200, 210, 'A021');

INSERT INTO Aircraft 
VALUES ('AC032', 'SN33333', 4300, 160, 'A022');

INSERT INTO Aircraft 
VALUES ('AC033', 'SN44444', 7500, 240, 'A023');

INSERT INTO Aircraft 
VALUES ('AC034', 'SN55555', 5900, 190, 'A024');

INSERT INTO Aircraft 
VALUES ('AC035', 'SN66666', 4700, 200, 'A025');

select*from aircraft;




INSERT INTO Airport 
VALUES ('AP001', 'John F. Kennedy International', 'New York, USA');

INSERT INTO Airport 
VALUES ('AP002', 'Ohare International', 'Chicago, USA');

INSERT INTO Airport 
VALUES ('AP003', 'London Heathrow', 'London, UK');

INSERT INTO Airport 
VALUES ('AP004', 'Toronto Pearson International', 'Toronto, Canada');

INSERT INTO Airport 
VALUES ('AP005', 'Sydney Kingsford Smith', 'Sydney, Australia');

INSERT INTO Airport 
VALUES ('AP006', 'Los Angeles International', 'Los Angeles, USA');

INSERT INTO Airport 
VALUES ('AP007', 'Manchester Airport', 'Manchester, UK');

INSERT INTO Airport 
VALUES ('AP008', 'Houston George Bush Intercontinental', 'Houston, USA');

INSERT INTO Airport 
VALUES ('AP009', 'Vancouver International', 'Vancouver, Canada');

INSERT INTO Airport 
VALUES ('AP010', 'Melbourne International', 'Melbourne, Australia');

INSERT INTO Airport 
VALUES ('AP011', 'San Francisco International', 'San Francisco, USA');

INSERT INTO Airport 
VALUES ('AP012', 'Frankfurt International', 'Frankfurt, Germany');

INSERT INTO Airport 
VALUES ('AP013', 'Dallas/Fort Worth International', 'Dallas, USA');

INSERT INTO Airport 
VALUES ('AP014', 'Calgary International', 'Calgary, Canada');

INSERT INTO Airport 
VALUES ('AP015', 'Perth Airport', 'Perth, Australia');

INSERT INTO Airport 
VALUES ('AP016', 'Phoenix Sky Harbor International', 'Phoenix, USA');

INSERT INTO Airport 
VALUES ('AP017', 'Glasgow International', 'Glasgow, UK');

INSERT INTO Airport 
VALUES ('AP018', 'Ottawa Macdonald-Cartier International', 'Ottawa, Canada');

INSERT INTO Airport 
VALUES ('AP019', 'Adelaide International', 'Adelaide, Australia');

INSERT INTO Airport 
VALUES ('AP020', 'Dallas Love Field', 'Dallas, USA');

INSERT INTO Airport 
VALUES ('AP021', 'San Diego International', 'San Diego, USA');

INSERT INTO Airport 
VALUES ('AP022', 'Seattle-Tacoma International', 'Seattle, USA');

INSERT INTO Airport 
VALUES ('AP023', 'Gatwick Airport', 'London, UK');

INSERT INTO Airport 
VALUES ('AP024', 'Ottawa International', 'Ottawa, Canada');

INSERT INTO Airport 
VALUES ('AP025', 'Melbourne Tullamarine', 'Melbourne, Australia');

INSERT INTO Airport 
VALUES ('AP026', 'San Jose International', 'San Jose, USA');

INSERT INTO Airport 
VALUES ('AP027', 'Birmingham Airport', 'Birmingham, UK');

INSERT INTO Airport 
VALUES ('AP028', 'Calgary International', 'Calgary, Canada');

INSERT INTO Airport 
VALUES ('AP029', 'Brisbane Airport', 'Brisbane, Australia');

INSERT INTO Airport 
VALUES ('AP030', 'Dallas Love Field', 'Dallas, USA');


select*from airport;



INSERT INTO Contains 
VALUES ('AP001', 'A001');

INSERT INTO Contains 
VALUES ('AP001', 'A002');

INSERT INTO Contains 
VALUES ('AP002', 'A002');

INSERT INTO Contains 
VALUES ('AP002', 'A006');

INSERT INTO Contains 
VALUES ('AP003', 'A003');

INSERT INTO Contains 
VALUES ('AP003', 'A017');

INSERT INTO Contains 
VALUES ('AP004', 'A004');

INSERT INTO Contains 
VALUES ('AP004', 'A018');

INSERT INTO Contains 
VALUES ('AP005', 'A005');

INSERT INTO Contains 
VALUES ('AP005', 'A024');

INSERT INTO Contains 
VALUES ('AP006', 'A006');

INSERT INTO Contains 
VALUES ('AP006', 'A010');

INSERT INTO Contains 
VALUES ('AP007', 'A007');

INSERT INTO Contains 
VALUES ('AP008', 'A008');

INSERT INTO Contains 
VALUES ('AP009', 'A009');

INSERT INTO Contains 
VALUES ('AP010', 'A010');

INSERT INTO Contains 
VALUES ('AP011', 'A011');

INSERT INTO Contains 
VALUES ('AP012', 'A012');

INSERT INTO Contains 
VALUES ('AP013', 'A013');

INSERT INTO Contains 
VALUES ('AP014', 'A014');

INSERT INTO Contains 
VALUES ('AP015', 'A015');

INSERT INTO Contains 
VALUES ('AP016', 'A016');

INSERT INTO Contains 
VALUES ('AP017', 'A017');

INSERT INTO Contains 
VALUES ('AP018', 'A018');

INSERT INTO Contains 
VALUES ('AP019', 'A019');

INSERT INTO Contains 
VALUES ('AP020', 'A020');

INSERT INTO Contains 
VALUES ('AP021', 'A001');

INSERT INTO Contains 
VALUES ('AP021', 'A002');

INSERT INTO Contains 
VALUES ('AP022', 'A002');

INSERT INTO Contains 
VALUES ('AP022', 'A006');

INSERT INTO Contains 
VALUES ('AP023', 'A003');

INSERT INTO Contains 
VALUES ('AP024', 'A004');

INSERT INTO Contains 
VALUES ('AP025', 'A005');

INSERT INTO Contains 
VALUES ('AP026', 'A021');

INSERT INTO Contains 
VALUES ('AP027', 'A022');

INSERT INTO Contains 
VALUES ('AP028', 'A023');

INSERT INTO Contains 
VALUES ('AP029', 'A024');

INSERT INTO Contains 
VALUES ('AP030', 'A025');


select*from contains;


--1. Find the total number of passengers for each flight
SELECT f.flight_id, COUNT(p.passenger_id) AS total_passengers
FROM Flight_Info f
LEFT JOIN Passenger p ON f.flight_id = p.flight_id
GROUP BY f.flight_id;

--2. List all airlines that have flights with a specific baggage allowance and the number of such flights
SELECT a.airline_name, COUNT(f.flight_id) AS flight_count
FROM Airline a
JOIN Flight_Info f ON a.airline_id = f.airline_id
WHERE f.baggage_allowance = '20 KGs'
GROUP BY a.airline_name;


--3. Get the average price of tickets for each class on a specific flight
SELECT t.class, AVG(t.price) AS average_price
FROM Ticket t
WHERE t.passenger_id IN (
    SELECT p.passenger_id
    FROM Passenger p
    WHERE p.flight_id = 'F001'
)
GROUP BY t.class;

--4. Find the flight with the maximum delay and the reason for that delay
SELECT fs.flight_id, fs.reason_of_delay, MAX(fs.delay) AS max_delay
FROM Flight_Status fs
GROUP BY fs.flight_id, fs.reason_of_delay
ORDER BY max_delay DESC
FETCH FIRST 1 ROW ONLY;

--6. List all airports that serve a specific airline along with the number of airlines served
SELECT ap.airport_name, COUNT(DISTINCT c.airline_id) AS airline_count
FROM Airport ap
JOIN Contains c ON ap.airport_id = c.airport_id
WHERE c.airline_id = 'A001'
GROUP BY ap.airport_name;


--airports with multiple airlines
SELECT a.airport_id, a.airport_name, COUNT(c.airline_id) AS airline_count
FROM Contains c
JOIN Airport a ON c.airport_id = a.airport_id
GROUP BY a.airport_id, a.airport_name
HAVING COUNT(c.airline_id) > 1;

--airlines with multiple airports
SELECT al.airline_id, al.airline_name, COUNT(c.airport_id) AS airport_count
FROM Contains c
JOIN Airline al ON c.airline_id = al.airline_id
GROUP BY al.airline_id, al.airline_name
HAVING COUNT(c.airport_id) > 1;


--airline with multiple flights
SELECT al.airline_id, al.airline_name, COUNT(f.flight_id) AS flight_count
FROM Airline al
JOIN Flight_Info f ON al.airline_id = f.airline_id
GROUP BY al.airline_id, al.airline_name
HAVING COUNT(f.flight_id) > 1;

--no flights
SELECT al.airline_id, al.airline_name
FROM Airline al
LEFT JOIN Flight_Info f ON al.airline_id = f.airline_id
WHERE f.flight_id IS NULL;


