CREATE DATABASE Ecommerce;
USE Ecommerce;

select * from Customer 
where name REGEXP '^a$';

select Customer.C_ID , Customer.Name , orders.O_ID , orders.amount
from Customer inner join orders on Customer.C_id = orders.C_ID;

=-- =========================================
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
-- 1. CUSTOMER
-- Name mein kahin bhi letter 'a' hona chahiye
-- =========================================================

SELECT *
FROM Customer
WHERE Name REGEXP 'a';


-- =========================================================
-- 2. CUSTOMER
-- Name ka first character 'A' hona chahiye
-- =========================================================

SELECT *
FROM Customer
WHERE Name REGEXP '^A';


-- =========================================================
-- 3. CUSTOMER
-- Name ka last character 'n' hona chahiye
-- =========================================================

SELECT *
FROM Customer
WHERE Name REGEXP 'n$';


-- =========================================================
-- 4. PRODUCT
-- Product Name mein 'phone' kahin bhi hona chahiye
-- =========================================================

SELECT *
FROM Product
WHERE Name REGEXP 'phone';


-- =========================================================
-- 5. PRODUCT
-- Product Name mein 'Laptop' ya 'Jeans' mein se koi ek hona chahiye
-- =========================================================

SELECT *
FROM Product
WHERE Name REGEXP 'Laptop|Jeans';


-- =========================================================
-- 6. CUSTOMER
-- Name mein sirf letters aur spaces hone chahiye
-- =========================================================

SELECT *
FROM Customer
WHERE Name REGEXP '^[A-Za-z ]+$';


-- =========================================================
-- 7. CUSTOMER
-- Email ka ending @gmail.com hona chahiye
-- =========================================================

SELECT *
FROM Customer
WHERE Email REGEXP '@gmail\\.com$';


-- =========================================================
-- 8. PRODUCT
-- Product Description mein literal dot (.) hona chahiye
-- =========================================================

SELECT *
FROM Product
WHERE Description REGEXP '\\.';


-- =========================================================
-- 9. PRODUCT
-- Product Name exactly 5 letters ka hona chahiye
-- =========================================================

SELECT *
FROM Product
WHERE Name REGEXP '^[A-Za-z]{5,}$';


-- =========================================================
-- 1. CUSTOMER + ORDERS
-- Un customers ko show karega jinka Name 'A' se start hota hai
-- =========================================================

SELECT Customer.C_ID, Customer.Name, Orders.O_ID
FROM Customer
INNER JOIN Orders
ON Customer.C_ID = Orders.C_ID
WHERE Customer.Name REGEXP '^A';


-- =========================================================
-- 2. PRODUCT + CATEGORY
-- Un products ko show karega jinke Name mein 'phone' ho
-- =========================================================

SELECT Product.P_ID, Product.Name, Category.Name AS Category
FROM Product
INNER JOIN Category
ON Product.Cat_ID = Category.Cat_ID
WHERE Product.Name REGEXP 'phone';


-- =========================================================
-- 3. CUSTOMER + ORDERS
-- Un customers ke orders show karega jinki Email @gmail.com par end hoti hai
-- =========================================================

SELECT Customer.Name, Customer.Email, Orders.O_ID, Orders.Amount
FROM Customer
INNER JOIN Orders
ON Customer.C_ID = Orders.C_ID
WHERE Customer.Email REGEXP '@gmail\\.com$';



-- =========================================================
-- 1. CUSTOMER + ORDERS
-- Customer ne kaun kaun se orders place kiye
-- =========================================================

SELECT
    Customer.C_ID,
    Customer.Name,
    Orders.O_ID,
    Orders.Amount,
    Orders.Order_Date
    FROM Customer INNER JOIN Orders ON Customer.C_ID = Orders.C_ID;


-- =========================================================
-- 2. PRODUCT + CATEGORY
-- Har product kis category mein hai
-- =========================================================

SELECT
    Product.P_ID,
    Product.Name AS Product_Name,
    Product.Price,
    Category.Cat_ID,
    Category.Name AS Category_Name
    FROM Product INNER JOIN Category
    ON Product.Cat_ID = Category.Cat_ID;


-- =========================================================
-- 3. ORDERS + CUSTOMER
-- Orders ki customer information
-- =========================================================

SELECT
    Orders.O_ID,
    Customer.C_ID,
    Customer.Name AS Customer_Name,
    Orders.Amount,
    Orders.Order_Date
    FROM Orders INNER JOIN Customer
    ON Orders.C_ID = Customer.C_ID;


-- =========================================================
-- 4. ORDER DETAILS + PRODUCT
-- Har order mein kaunsa product hai
-- =========================================================

SELECT
    OrderDetails.O_ID,
    Product.P_ID,
    Product.Name AS Product_Name,
    OrderDetails.Quantity,
    OrderDetails.Price
    FROM OrderDetails INNER JOIN Product
    ON OrderDetails.P_ID = Product.P_ID;


-- =========================================================
-- 5. ORDER DETAILS + ORDERS
-- Order details ko order information ke saath show karna
-- =========================================================

SELECT
    OrderDetails.O_ID,
    Orders.C_ID,
    OrderDetails.P_ID,
    OrderDetails.Quantity,
    OrderDetails.Price,
    Orders.Amount,
    Orders.Order_Date FROM OrderDetails INNER JOIN Orders
    ON OrderDetails.O_ID = Orders.O_ID;


-- =========================================================
-- 6. ORDERS + PAYMENT
-- Har order ki payment information
-- =========================================================

SELECT
    Orders.O_ID,
    Orders.C_ID,
    Orders.Amount AS Order_Amount,
    Payment.Payment_ID,
    Payment.Type AS Payment_Type,
    Payment.Amount AS Payment_Amount
    FROM Orders INNER JOIN Payment
    ON Orders.O_ID = Payment.O_ID;


-- =========================================================
-- 7. CART + CUSTOMER
-- Cart kis customer ki hai
-- =========================================================

SELECT
    Cart.Cart_ID,
    Customer.C_ID,
    Customer.Name AS Customer_Name,
    Cart.P_ID,
    Cart.Quantity
	FROM Cart INNER JOIN Customer
    ON Cart.C_ID = Customer.C_ID;


-- =========================================================
-- 8. CART + PRODUCT
-- Cart mein kaunsa product hai
-- =========================================================

SELECT
    Cart.Cart_ID,
    Product.P_ID,
    Product.Name AS Product_Name,
    Product.Price,
    Cart.Quantity
    FROM Cart INNER JOIN Product
    ON Cart.P_ID = Product.P_ID;


-- =========================================================
-- 9. CUSTOMER + CART + PRODUCT
-- Customer ke cart mein kaun se products hain
-- =========================================================

SELECT
    Customer.C_ID,
    Customer.Name AS Customer_Name,
    Product.P_ID,
    Product.Name AS Product_Name,
    Product.Price,
    Cart.Quantity FROM Cart INNER JOIN Customer
    ON Cart.C_ID = Customer.C_ID
    INNER JOIN Product
    ON Cart.P_ID = Product.P_ID;


-- =========================================================
-- 10. CUSTOMER + ORDERS + ORDER DETAILS
-- Customer ke orders aur unki details
-- =========================================================

SELECT
    Customer.Name AS Customer_Name,
    Orders.O_ID,
    OrderDetails.P_ID,
    OrderDetails.Quantity,
    OrderDetails.Price,
    Orders.Amount,
    Orders.Order_Date
    FROM Customer
    INNER JOIN Orders
    ON Customer.C_ID = Orders.C_ID
    INNER JOIN OrderDetails
    ON Orders.O_ID = OrderDetails.O_ID;


-- =========================================================
-- 11. ORDERS + ORDER DETAILS + PRODUCT
-- Order mein kaunsa product aur kitni quantity hai
-- =========================================================

SELECT
    Orders.O_ID,
    Product.Name AS Product_Name,
    OrderDetails.Quantity,
    OrderDetails.Price,
    Orders.Amount
    FROM Orders INNER JOIN OrderDetails
    ON Orders.O_ID = OrderDetails.O_ID
	INNER JOIN Product
    ON OrderDetails.P_ID = Product.P_ID;


-- =========================================================
-- 12. PRODUCT + CATEGORY + ORDER DETAILS
-- Product ki category aur order details
-- =========================================================

SELECT
    Product.P_ID,
    Product.Name AS Product_Name,
    Category.Name AS Category_Name,
    OrderDetails.O_ID,
    OrderDetails.Quantity,
    OrderDetails.Price
    FROM Product
    INNER JOIN Category
    ON Product.Cat_ID = Category.Cat_ID
    INNER JOIN OrderDetails
    ON Product.P_ID = OrderDetails.P_ID;


-- =========================================================
-- 13. ORDERS + CUSTOMER + PAYMENT
-- Customer ke order aur payment details
-- =========================================================

SELECT
    Customer.Name AS Customer_Name,
    Orders.O_ID,
    Orders.Amount AS Order_Amount,
    Payment.Type AS Payment_Type,
    Payment.Amount AS Payment_Amount,
    Orders.Order_Date
    FROM Orders INNER JOIN Customer
    ON Orders.C_ID = Customer.C_ID INNER JOIN Payment
    ON Orders.O_ID = Payment.O_ID;


-- =========================================================
-- 14. CUSTOMER + ORDERS + PAYMENT + ORDER DETAILS
-- Customer, order, payment aur order details
-- =========================================================

SELECT
    Customer.Name AS Customer_Name,
    Orders.O_ID,
    OrderDetails.P_ID,
    OrderDetails.Quantity,
    OrderDetails.Price,
    Orders.Amount AS Order_Amount,
    Payment.Type AS Payment_Type,
    Payment.Amount AS Payment_Amount
    FROM Customer INNER JOIN Orders ON Customer.C_ID = Orders.C_ID
    INNER JOIN OrderDetails ON Orders.O_ID = OrderDetails.O_ID
    INNER JOIN Payment ON Orders.O_ID = Payment.O_ID;


-- =========================================================
-- 15. PRODUCT + CATEGORY + ORDER DETAILS + ORDERS
-- Product se related complete order information
-- =========================================================

SELECT
    Product.P_ID,
    Product.Name AS Product_Name,
    Category.Name AS Category_Name,
    Orders.O_ID,
    OrderDetails.Quantity,
    OrderDetails.Price,
    Orders.Amount,
    Orders.Order_Date
    FROM Product INNER JOIN Category
    ON Product.Cat_ID = Category.Cat_ID
    INNER JOIN OrderDetails
    ON Product.P_ID = OrderDetails.P_ID
    INNER JOIN Orders
    ON OrderDetails.O_ID = Orders.O_ID;


-- =========================================================
-- 16. COMPLETE ORDER INFORMATION
-- Customer + Order + Product + Category
-- =========================================================

SELECT
    Customer.C_ID,
    Customer.Name AS Customer_Name,
    Orders.O_ID,
    Product.P_ID,
    Product.Name AS Product_Name,
    Category.Name AS Category_Name,
    OrderDetails.Quantity,
    OrderDetails.Price,
    Orders.Amount,
    Orders.Order_Date
    FROM Customer
    INNER JOIN Orders
    ON Customer.C_ID = Orders.C_ID
    INNER JOIN OrderDetails
    ON Orders.O_ID = OrderDetails.O_ID
    INNER JOIN Product
    ON OrderDetails.P_ID = Product.P_ID
    INNER JOIN Category
    ON Product.Cat_ID = Category.Cat_ID;


-- =========================================================
-- 17. COMPLETE ORDER + PAYMENT
-- Customer + Order + Product + Category + Payment
-- =========================================================

SELECT
    Customer.Name AS Customer_Name,
    Orders.O_ID,
    Product.Name AS Product_Name,
    Category.Name AS Category_Name,
    OrderDetails.Quantity,
    OrderDetails.Price AS Product_Price,
    Orders.Amount AS Order_Amount,
    Payment.Type AS Payment_Type,
    Payment.Amount AS Payment_Amount,
    Orders.Order_Date
	FROM Customer INNER JOIN Orders
    ON Customer.C_ID = Orders.C_ID
    INNER JOIN OrderDetails
    ON Orders.O_ID = OrderDetails.O_ID
    INNER JOIN Product
    ON OrderDetails.P_ID = Product.P_ID
    INNER JOIN Category
    ON Product.Cat_ID = Category.Cat_ID
    INNER JOIN Payment
    ON Orders.O_ID = Payment.O_ID;


-- =========================================================
-- 18. COMPLETE CART INFORMATION
-- Customer + Cart + Product + Category
-- =========================================================

SELECT
    Customer.Name AS Customer_Name,
    Cart.Cart_ID,
    Product.Name AS Product_Name,
    Category.Name AS Category_Name,
    Product.Price,
    Cart.Quantity
    FROM Customer
    INNER JOIN Cart
    ON Customer.C_ID = Cart.C_ID
    INNER JOIN Product
    ON Cart.P_ID = Product.P_ID
    INNER JOIN Category
    ON Product.Cat_ID = Category.Cat_ID;


-- =========================================================
-- 19. INNER JOIN WITH WHERE
-- Sirf Electronics category ke products
-- =========================================================

SELECT
    Product.Name AS Product_Name,
    Product.Price,
    Category.Name AS Category_Name FROM Product
    INNER JOIN Category
    ON Product.Cat_ID = Category.Cat_ID
    WHERE Category.Name = 'Electronics';


-- =========================================================
-- 20. INNER JOIN WITH WHERE
-- Sirf Ali Khan ke orders
-- =========================================================

SELECT
    Customer.Name AS Customer_Name,
    Orders.O_ID,
    Orders.Amount,
    Orders.Order_Date
    FROM Customer
    INNER JOIN Orders
    ON Customer.C_ID = Orders.C_ID
    WHERE Customer.Name = 'Ali Khan';


-- =========================================================
-- 21. INNER JOIN WITH ORDER BY
-- Products ko highest price se lowest price tak
-- =========================================================

SELECT
    Product.Name AS Product_Name,
    Category.Name AS Category_Name,
    Product.Price
    FROM Product
    INNER JOIN Category
    ON Product.Cat_ID = Category.Cat_ID
    ORDER BY Product.Price DESC;


-- =========================================================
-- 22. INNER JOIN WITH REGEXP
-- Customer names jo A se start hote hain
-- =========================================================

SELECT
    Customer.Name AS Customer_Name,
    Orders.O_ID,
    Orders.Amount
    FROM Customer
    INNER JOIN Orders
    ON Customer.C_ID = Orders.C_ID
    WHERE Customer.Name REGEXP '^A';


-- =========================================================
-- 23. INNER JOIN WITH REGEXP
-- Product names jisme "phone" word/part hai
-- =========================================================

SELECT
    Product.Name AS Product_Name,
    Category.Name AS Category_Name,
    Product.Price
    FROM Product
    INNER JOIN Category
    ON Product.Cat_ID = Category.Cat_ID
    WHERE Product.Name REGEXP 'phone';


-- =========================================================
-- 24. INNER JOIN + MULTIPLE CONDITIONS
-- Electronics category ke products jinki price 5000 se zyada hai
-- =========================================================

SELECT
    Product.Name AS Product_Name,
    Product.Price,
    Category.Name AS Category_Name
    FROM Product
    INNER JOIN Category
    ON Product.Cat_ID = Category.Cat_ID
    WHERE Category.Name = 'Electronics'
    AND Product.Price > 5000;


-- =========================================================
-- 25. INNER JOIN + BETWEEN
-- 5000 se 10000 ke darmiyan products
-- =========================================================

SELECT
    Product.Name AS Product_Name,
    Product.Price,
    Category.Name AS Category_Name
    FROM Product
    INNER JOIN Category
    ON Product.Cat_ID = Category.Cat_ID
    WHERE Product.Price BETWEEN 5000 AND 10000;


-- =========================================================
-- 26. INNER JOIN + LIKE
-- Product name mein "a" ho
-- =========================================================

SELECT
    Product.Name AS Product_Name,
    Category.Name AS Category_Name,
    Product.Price
    FROM Product
    INNER JOIN Category
    ON Product.Cat_ID = Category.Cat_ID
    WHERE Product.Name LIKE '%a%';


-- =========================================================
-- 27. INNER JOIN + DISTINCT
-- Orders mein use hone wali categories
-- =========================================================

SELECT DISTINCT
    Category.Name AS Category_Name
	FROM Category
    INNER JOIN Product
    ON Category.Cat_ID = Product.Cat_ID
    INNER JOIN OrderDetails
    ON Product.P_ID = OrderDetails.P_ID;


-- =========================================================
-- 28. INNER JOIN + LIMIT
-- Sirf first 5 products with categories
-- =========================================================

SELECT
    Product.Name AS Product_Name,
    Category.Name AS Category_Name,
    Product.Price
    FROM Product
    INNER JOIN Category
    ON Product.Cat_ID = Category.Cat_ID
    LIMIT 5;