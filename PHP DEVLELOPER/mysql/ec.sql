create Database Ecommerce;
use Ecommerce;

create table Product(
P_ID int primary Key auto_increment,
P_name varchar(255) Unique NOT NULL,
price int NOT NULL,
Description varchar(255) Not Null
);

insert into Product(P_name,price,Description)
values('shampoo' , 200, 'kjcfkdsjhgf');

INSERT INTO Product (P_name, price, Description)
VALUES ('Laptop', 150000, 'HP Laptop');

select * from Product;

ALTER TABLE Product AUTO_INCREMENT = 1011;

UPDATE Product
SET P_ID = 1011
WHERE P_ID = 1;


CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Order_Amount DECIMAL(10, 2),
    Order_Date DATE
);