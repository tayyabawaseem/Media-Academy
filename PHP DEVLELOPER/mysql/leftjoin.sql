CREATE DATABASE Ecommerce;
USE Ecommerce;

select * from Customer cross join product;
select C_ID , Amount ,
 count(*) from orders group by C_ID having avg(Amount) >2000;


select  Customer.C_ID , Customer.Name
 , COUNT(orders.O_ID) As total_orders
from Customer
inner join orders on  Customer.C_ID = orders.C_ID
group by  Customer.C_ID ,Customer.Name;

-- =========================================
-- 1. CUSTOMER
-- =========================================

CREATE TABLE Customer (
    C_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE
);


-- =========================================
-- 2. CATEGORY
-- =========================================

CREATE TABLE Category (
    Cat_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Picture VARCHAR(255),
    Description TEXT
);


-- =========================================
-- 3. PRODUCT
-- =========================================

CREATE TABLE Product (
    P_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(150) NOT NULL,
    Description TEXT,
    Price DECIMAL(10,2) NOT NULL CHECK (Price > 0),
    Cat_ID INT NOT NULL,

    FOREIGN KEY (Cat_ID)
        REFERENCES Category(Cat_ID)
);


-- =========================================
-- 4. ORDERS
-- =========================================

CREATE TABLE Orders (
    O_ID INT PRIMARY KEY AUTO_INCREMENT,
    C_ID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    Order_Date DATE DEFAULT (CURRENT_DATE),

    FOREIGN KEY (C_ID)
        REFERENCES Customer(C_ID)
);


-- =========================================
-- 5. ORDER DETAILS
-- =========================================

CREATE TABLE OrderDetails (
    O_ID INT NOT NULL,
    P_ID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    Price DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (O_ID, P_ID),

    FOREIGN KEY (O_ID)
        REFERENCES Orders(O_ID),

    FOREIGN KEY (P_ID)
        REFERENCES Product(P_ID)
);


-- =========================================
-- 6. PAYMENT
-- =========================================

CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY AUTO_INCREMENT,
    O_ID INT NOT NULL,
    Type VARCHAR(50) NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (O_ID)
        REFERENCES Orders(O_ID)
);


-- =========================================
-- 7. CART
-- =========================================

CREATE TABLE Cart (
    Cart_ID INT PRIMARY KEY AUTO_INCREMENT,
    C_ID INT NOT NULL,
    P_ID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,

    FOREIGN KEY (C_ID)
        REFERENCES Customer(C_ID),

    FOREIGN KEY (P_ID)
        REFERENCES Product(P_ID)
);


-- =========================================
-- CUSTOMER DATA
-- =========================================

INSERT INTO Customer (Name, Password, Email)
VALUES
('Ali Khan', 'Ali@123', 'ali@gmail.com'),
('Sara Ahmed', 'Sara@123', 'sara@gmail.com'),
('Hamza Malik', 'Hamza@123', 'hamza@gmail.com'),
('Ayesha Noor', 'Ayesha@123', 'ayesha@gmail.com'),
('Usman Tariq', 'Usman@123', 'usman@gmail.com');


-- =========================================
-- CATEGORY DATA
-- =========================================

INSERT INTO Category (Name, Picture, Description)
VALUES
('Electronics', 'electronics.jpg',
 'Electronic products such as laptops, smartphones and headphones'),

('Clothing', 'clothing.jpg',
 'Clothing products such as T-Shirts and Jeans'),

('Footwear', 'footwear.jpg',
 'Footwear products such as sneakers and shoes'),

('Accessories', 'accessories.jpg',
 'Fashion and electronic accessories such as watches and handbags');


-- =========================================
-- PRODUCT DATA
-- =========================================

INSERT INTO Product (Name, Description, Price, Cat_ID)
VALUES
('Laptop', 'HP Core i5 Laptop', 120000.00, 1),
('Smartphone', 'Samsung Android Smartphone', 75000.00, 1),
('T-Shirt', 'Cotton Round Neck T-Shirt', 2500.00, 2),
('Jeans', 'Regular Fit Blue Jeans', 4500.00, 2),
('Sneakers', 'Casual Running Sneakers', 6000.00, 3),
('Watch', 'Smart Digital Watch', 8500.00, 4),
('Headphones', 'Wireless Bluetooth Headphones', 5500.00, 1),
('Handbag', 'Ladies Fashion Handbag', 7000.00, 4);


-- =========================================
-- ORDERS DATA
-- =========================================

INSERT INTO Orders (C_ID, Amount)
VALUES
(1, 122500.00),
(2, 10500.00),
(3, 80500.00),
(1, 15500.00),
(4, 6000.00);


-- =========================================
-- ORDER DETAILS
-- =========================================

INSERT INTO OrderDetails (O_ID, P_ID, Quantity, Price)
VALUES
(1, 1, 1, 120000.00),
(1, 3, 1, 2500.00),
(2, 4, 1, 4500.00),
(2, 5, 1, 6000.00),
(3, 2, 1, 75000.00),
(3, 7, 1, 5500.00),
(4, 6, 1, 8500.00),
(4, 8, 1, 7000.00),
(5, 5, 1, 6000.00);


-- =========================================
-- PAYMENT DATA
-- =========================================

INSERT INTO Payment (O_ID, Type, Amount)
VALUES
(1, 'Credit Card', 122500.00),
(2, 'Cash on Delivery', 10500.00),
(3, 'Bank Transfer', 80500.00),
(4, 'Credit Card', 15500.00),
(5, 'Cash on Delivery', 6000.00);


-- =========================================
-- CART DATA
-- =========================================

INSERT INTO Cart (C_ID, P_ID, Quantity)
VALUES
(1, 2, 1),
(1, 6, 1),
(2, 3, 2),
(3, 7, 1),
(4, 8, 1),
(5, 5, 2);



SELECT * FROM Customer;

SELECT * FROM Category;

SELECT * FROM Product;

SELECT * FROM Orders;

SELECT * FROM OrderDetails;

SELECT * FROM Payment;

SELECT * FROM Cart;

-- =========================================================
-- 1. CUSTOMER + ORDERS
-- Har customer show hoga, chahe uska koi order ho ya na ho
-- =========================================================



SELECT
    Customer.C_ID,
    Customer.Name,
    Orders.O_ID,
    Orders.Amount,
    Orders.Order_Date FROM Customer
    LEFT JOIN Orders
    ON Customer.C_ID = Orders.C_ID;


-- =========================================================
-- 5. CUSTOMER + CART
-- Har customer show hoga, chahe uske cart mein product ho ya na ho
-- =========================================================

SELECT
    Customer.C_ID,
    Customer.Name,
    Cart.Cart_ID,
    Cart.P_ID,
    Cart.Quantity
FROM Customer
LEFT JOIN Cart
ON Customer.C_ID = Cart.C_ID;


-- =========================================================
-- 6. CUSTOMER + ORDERS + PAYMENT
-- Customer ke orders aur unki payment details
-- =========================================================

SELECT
    Customer.Name,
    Orders.O_ID,
    Orders.Amount AS Order_Amount,
    Payment.Type,
    Payment.Amount AS Payment_Amount
FROM Customer
LEFT JOIN Orders
ON Customer.C_ID = Orders.C_ID
LEFT JOIN Payment
ON Orders.O_ID = Payment.O_ID;


-- =========================================================
-- 8. CUSTOMER + ORDERS + ORDER DETAILS + PRODUCT
-- Customer ne kaunsa product order kiya
-- =========================================================

SELECT
    Customer.Name AS Customer_Name,
    Orders.O_ID,
    Product.Name AS Product_Name,
    OrderDetails.Quantity,
    OrderDetails.Price
FROM Customer
LEFT JOIN Orders
ON Customer.C_ID = Orders.C_ID
LEFT JOIN OrderDetails
ON Orders.O_ID = OrderDetails.O_ID
LEFT JOIN Product
ON OrderDetails.P_ID = Product.P_ID;




-- =========================================================
-- 3. PRODUCT + ORDER DETAILS
-- OrderDetails table ka ALL data show hoga
-- Product ka matching data show hoga
-- =========================================================

SELECT
    Product.P_ID,
    Product.Name AS Product_Name,
    Product.Price,
    OrderDetails.O_ID,
    OrderDetails.Quantity
FROM Product
RIGHT JOIN OrderDetails
ON Product.P_ID = OrderDetails.P_ID;

-- =========================================================
-- 6. CUSTOMER + ORDERS + PAYMENT
-- Payment table ka ALL data show hoga
-- Orders aur Customer ka matching data show hoga
-- =========================================================

SELECT
    Customer.Name AS Customer_Name,
    Orders.O_ID,
    Orders.Amount AS Order_Amount,
    Payment.Type,
    Payment.Amount AS Payment_Amount
FROM Customer
RIGHT JOIN Orders
ON Customer.C_ID = Orders.C_ID
RIGHT JOIN Payment
ON Orders.O_ID = Payment.O_ID;


-- =========================================================
-- CUSTOMER + ORDERS + PAYMENT
-- Customer ka matching order
-- Payment ka sara data
-- =========================================================

SELECT
    Customer.Name AS Customer_Name,
    Orders.O_ID,
    Orders.Amount AS Order_Amount,
    Payment.Type,
    Payment.Amount AS Payment_Amount

FROM Customer

INNER JOIN Orders
ON Customer.C_ID = Orders.C_ID

RIGHT JOIN Payment
ON Orders.O_ID = Payment.O_ID;


-- =========================================================
-- CATEGORY + PRODUCT + ORDER DETAILS
-- Har category show hogi
-- Sirf matching product ke order details show honge
-- =========================================================

SELECT
    Category.Name AS Category_Name,
    Product.Name AS Product_Name,
    OrderDetails.O_ID,
    OrderDetails.Quantity

FROM Category

LEFT JOIN Product
ON Category.Cat_ID = Product.Cat_ID

INNER JOIN OrderDetails
ON Product.P_ID = OrderDetails.P_ID;


-- =========================================================
-- 1. CUSTOMER + CATEGORY
-- Har customer ko har category ke saath combine karega
-- 5 Customers × 4 Categories = 20 rows
-- =========================================================

SELECT
    Customer.Name AS Customer_Name,
    Category.Name AS Category_Name
FROM Customer
CROSS JOIN Category;


-- =========================================================
-- 4. CUSTOMER + PRODUCT + CATEGORY
-- Har customer ko har product aur har category ke combination
-- ke saath combine karega
-- =========================================================

SELECT
    Customer.Name AS Customer_Name,
    Product.Name AS Product_Name,
    Category.Name AS Category_Name
FROM Customer
CROSS JOIN Product
CROSS JOIN Category;


-- =========================================================
-- 1. CATEGORY-WISE PRODUCTS
-- Har category mein kitne products hain
-- =========================================================

SELECT
    Cat_ID,
    COUNT(*) AS Total_Products
FROM Product
GROUP BY Cat_ID;

-- =========================================================
-- 2. CUSTOMER-WISE ORDERS
-- Har customer ne kitne orders place kiye
-- =========================================================

SELECT
    C_ID,
    COUNT(*) AS Total_Orders
FROM Orders
GROUP BY C_ID;

-- =========================================================
-- 4. CATEGORY-WISE AVERAGE PRICE
-- Har category ke products ki average price
-- =========================================================

SELECT
    Cat_ID,
    AVG(Price) AS Average_Price
FROM Product
GROUP BY Cat_ID;

-- =========================================================
-- 1. CATEGORY-WISE PRODUCTS
-- Sirf woh categories show hongi jahan 1 se zyada products hain
-- =========================================================

SELECT
    Cat_ID,
    COUNT(*) AS Total_Products
FROM Product
GROUP BY Cat_ID
HAVING COUNT(*) > 1;

-- =========================================================
-- 4. CATEGORY-WISE AVERAGE PRICE
-- Sirf woh categories show hongi jinki average price 5,000 se zyada hai
-- =========================================================

SELECT
    Cat_ID,
    AVG(Price) AS Average_Price
FROM Product
GROUP BY Cat_ID
HAVING AVG(Price) > 5000;


