-- ✅ Use the database
USE amazon_orders;

-- ✅ Check database and tables
SHOW DATABASES;
SHOW TABLES;
/*
-- ✅ Fix structure: drop bad column and ensure IndexID is proper
ALTER TABLE amazon_sale_report
DROP COLUMN IF EXISTS `Unnamed: 22`;

ALTER TABLE amazon_sale_report
DROP COLUMN IF EXISTS `IndexID`;

ALTER TABLE amazon_sale_report
ADD COLUMN `IndexID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;

-- ✅ Fill empty fields
UPDATE amazon_sale_report
SET `Promotion_IDs` = 'N/A'
WHERE `Promotion_IDs` IS NULL OR `Promotion_IDs` = '';

UPDATE amazon_sale_report
SET `Fulfilled_By` = 'Unknown'
WHERE `Fulfilled_By` IS NULL OR `Fulfilled_By` = '';
*/
-- ✅ Confirm structure
DESCRIBE amazon_sale_report;

-- ✅ View all data
SELECT * FROM amazon_sale_report;

-- ✅ Analytics Queries

-- 1️⃣ State with highest shipped orders
SELECT 
    `ship_state`, 
    COUNT(*) AS total_shipped
FROM amazon_sale_report
WHERE Status LIKE '%Shipped%'
GROUP BY `ship_state`
ORDER BY total_shipped DESC
LIMIT 1;

-- 2️⃣ Total Sales
SELECT SUM(Amount) AS 'Total Sales' FROM amazon_sale_report;

-- 3️⃣ Shipments by Category
SELECT Category, COUNT(Category) AS 'Shipments by Category'
FROM amazon_sale_report
GROUP BY Category;

-- 4️⃣ Cancelled vs Shipped Orders
SELECT 
    Status, 
    COUNT(*) AS 'Number of Orders'
FROM amazon_sale_report
WHERE Status IN ('Cancelled', 'Shipped', 'Shipped - Delivered to Buyer')
GROUP BY Status;

-- 5️⃣ Average Order Value and Quantity
SELECT 
    AVG(Amount) AS 'Average Order Value',
    AVG(Qty) AS 'Average Quantity per Order'
FROM amazon_sale_report;

-- 6️⃣ Top 5 States by Shipment Volume
SELECT 
    `ship_state`, 
    COUNT(*) AS 'Number of Shipments'
FROM amazon_sale_report
GROUP BY `ship_state`
ORDER BY COUNT(*) DESC
LIMIT 5;

-- 7️⃣ Top 5 Cities by Shipment Volume
SELECT 
    `ship_city`, 
    COUNT(*) AS 'Number of Shipments'
FROM amazon_sale_report
GROUP BY `ship_city`
ORDER BY COUNT(*) DESC
LIMIT 5;

-- 8️⃣ Monthly Sales Trend
SELECT 
    DATE_FORMAT(`Date`, '%Y-%m') AS 'Month',
    SUM(Amount) AS 'Total Sales'
FROM amazon_sale_report
GROUP BY DATE_FORMAT(`Date`, '%Y-%m')
ORDER BY Month;

-- 9️⃣ Daily Sales Trend
SELECT 
    `Date`,
    SUM(Amount) AS 'Total Sales'
FROM amazon_sale_report
GROUP BY `Date`
ORDER BY `Date`;

-- Total orders by fulfillment type
SELECT Fulfilment, COUNT(Order_ID) AS Total_Orders
FROM amazon_sale_report
GROUP BY Fulfilment;

-- Delivery success rate
SELECT 
  COUNT(CASE WHEN Status LIKE '%Delivered%' THEN 1 END) * 100.0 / COUNT(*) AS Delivery_Success_Rate
FROM amazon_sale_report;

-- Orders by courier status
SELECT `Courier Status`, COUNT(Order_ID) AS Count
FROM amazon_sale_report
GROUP BY `Courier Status`;
