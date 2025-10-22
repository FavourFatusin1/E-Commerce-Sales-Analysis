-- 1️⃣ Create and use the database
DROP DATABASE amazon_orders;
CREATE DATABASE amazon_orders;
USE amazon_orders;

SHOW DATABASES;
CREATE TABLE amazon_sale_report (
    `IndexID` INT,
    `Order_ID` VARCHAR(50),
    `Date` DATE,
    `Status` VARCHAR(100),
    `Fulfilment` VARCHAR(100),
    `Sales_Channel` VARCHAR(100),
    `Ship_Service_Level` VARCHAR(100),
    `Style` VARCHAR(100),
    `SKU` VARCHAR(100),
    `Category` VARCHAR(100),
    `Size` VARCHAR(20),
    `ASIN` VARCHAR(50),
    `Courier_Status` VARCHAR(100),
    `Qty` INT,
    `Currency` VARCHAR(10),
    `Amount` DECIMAL(10,2),
    `Ship_City` VARCHAR(100),
    `Ship_State` VARCHAR(100),
    `Ship_Postal_Code` VARCHAR(20),
    `Ship_Country` VARCHAR(50),
    `Promotion_IDs` TEXT,
    `B2B` VARCHAR(10),
    `Fulfilled_By` VARCHAR(50)
);

USE amazon_orders;
SHOW TABLES;


-- 2️⃣ View full dataset
SELECT *
FROM amazon_sale_report;

LOAD DATA INFILE '/Users/favorito5137/mysql-files/Amazon_Sale_Report.csv'
INTO TABLE amazon_sale_report
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_rows FROM amazon_sale_report;
