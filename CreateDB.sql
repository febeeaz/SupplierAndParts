CREATE DATABASE suppliersAndParts;

-- Create SUPPLIER table
CREATE TABLE SUPPLIER (
    Sno VARCHAR(2) PRIMARY KEY,
    Sname VARCHAR(50) NOT NULL,
    Status INT CHECK (Status > 0),
    City VARCHAR(50)
);

-- Create PART table
CREATE TABLE PART (
    Pno VARCHAR(2) PRIMARY KEY,
    Pname VARCHAR(50) NOT NULL,
    Color VARCHAR(50),
    Weight INT CHECK (Weight BETWEEN 1 AND 100),
    City VARCHAR(50),
    CONSTRAINT UC_Pname_Color UNIQUE (Pname,Color)
);

-- Create SHIPMENT table
CREATE TABLE SHIPMENT (
    Sno VARCHAR(2),
    Pno VARCHAR(2),
    Qty INT DEFAULT 100,
    Price DECIMAL(10, 3) CHECK (Price > 0),
    PRIMARY KEY (Sno, Pno),
    FOREIGN KEY (Sno) REFERENCES SUPPLIER(Sno),
    FOREIGN KEY (Pno) REFERENCES PART(Pno)
);
