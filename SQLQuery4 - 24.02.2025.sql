CREATE DATABASE[CarsShowroom]

CREATE TABLE Categories(
categories_id INT PRIMARY KEY IDENTITY(1,1),
categories_type  NVARCHAR(50) NOT NULL
);
 
CREATE TABLE Engines(
engines_id INT PRIMARY KEY IDENTITY(1,1),
engines_type NVARCHAR(50) NOT NULL
);
 
CREATE TABLE Cars(
car_id INT PRIMARY KEY IDENTITY(1,1),
brand NVARCHAR(50) NOT NULL,
model NVARCHAR(50) NOT NULL,
categories_id INT FOREIGN KEY REFERENCES Categories([categories_id]),
engines_id INT FOREIGN KEY REFERENCES Engines(engines_id),
color NVARCHAR(50) NOT NULL,
yearPublished INT NOT NULL,
price DECIMAL NOT NULL
)
 
CREATE TABLE Customers(
customer_id INT PRIMARY KEY IDENTITY(1,1),
name NVARCHAR(50) NOT NULL,
surname NVARCHAR(50) NOT NULL,
number NVARCHAR(10) NOT NULL
)
 
CREATE TABLE Sales(
sales_id INT PRIMARY KEY IDENTITY(1,1),
car_id INT FOREIGN KEY REFERENCES Cars(car_id),
customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
yearSale DATE NOT NULL
)
 
INSERT INTO Categories(categories_type)
VALUES
(N'���'), (N'����'), (N'������'), (N'�����'), (N'����'),
(N'�������'), (N'�����'), (N'�����'), (N'����� ��������'), (N'������')
 
INSERT INTO Engines(engines_type)
VALUES
(N'��������'), (N'�������'), (N'������������'), (N'��������'), (N'Plug-In ������')
 
INSERT INTO Cars(brand,model,categories_id,engines_id,color,yearPublished,price)
VALUES
('VW', 'Golf', 1, 1, N'�����', 2022, 20000),
('Audi', 'A3', 2, 2, N'���', 2021, 25000),
('BMW', '3 Series', 2, 1, N'���', 2020, 30000),
('Mercedes-Benz', 'C-Class', 2, 1, N'���', 2022, 35000),
('Toyota', 'Corolla', 1, 3, N'���', 2021, 22000),
('Audi', 'A5', 1, 1, N'�����', 2020, 32000),
('BMW', '6 Series', 1, 2, N'�����', 2019, 35000),
('Audi', 'A8', 3, 1, N'����� ���', 2023, 75000),
('Mercedes-Benz', 'G 500', 2, 3, N'�����', 2022, 68000),
('Peugeot', '308', 1, 2, N'���', 2022, 23000);
 
INSERT INTO Customers(name,surname,number)
VALUES
(N'����', N'������', '0888123456'),
(N'�����', N'������', '0899123456'),
(N'������', N'��������', '0877123456'),
(N'������', N'�������', '0885123456'),
(N'�����', N'�����������', '0897123456'),
(N'�����', N'�������', '0886123456'),
(N'�����', N'�������', '0876123456'),
(N'������', N'�����', '0896123456'),
(N'�����', N'�������', '0884123456'),
(N'�������', N'�������', '0875123456');
 
INSERT INTO Sales(car_id,customer_id,yearSale)
VALUES
(6, 8, '2022-01-16'),
(2, 3, '2022-02-09'),
(5, 1, '2022-11-30'),
(7, 4, '2022-04-19'),
(1, 6, '2023-05-21');

SELECT * FROM Cars
SELECT *FROM Cars WHERE (yearPublished<2020)
SELECT [model],[color],[yearPublished],[price] FROM Cars WHERE ([brand]='Audi')
SELECT [brand],[model],[yearPublished],[price] FROM Cars WHERE ([engines_id]=1)
SELECT [brand],[model],[yearPublished],[price] FROM Cars WHERE ([categories_id]=1)
SELECT * FROM Cars WHERE([color]=N'�����'OR [color]= N'���')
SELECT TOP 1 [brand],[model],[yearPublished],[price] FROM Cars ORDER BY [price] ASC
SELECT [brand],[model],[color],[yearPublished],[price] FROM Cars WHERE(engines_id=1) ORDER BY price DESC
SELECT [brand],[model],[categories_id],[yearPublished],[price] FROM Cars WHERE(categories_id=1)
SELECT Customers.[name],Cars.brand,Cars.model,Cars.color,Cars.price
FROM 
Customers
JOIN 
Sales ON Customers.customer_id=Sales.customer_id
JOIN
Cars ON Cars.car_id=Sales.car_id
ORDER BY Cars.brand ASC, Cars.price DESC
SELECT [brand],[model],[yearPublished],[price],[categories_id] FROM Cars WHERE(price BETWEEN 20000 AND 30000 AND categories_id=2)
SELECT Customers.[name], Cars.brand,Cars.model,Cars.color,Cars.price
FROM
Sales
JOIN 
Customers ON Customers.customer_id=Sales.sales_id
JOIN 
Cars ON Cars.car_id=Sales.car_id
WHERE(Cars.color=N'�����') ORDER BY Cars.price ASC

SELECT Categories.categories_id,Categories.categories_type
FROM
Categories
LEFT JOIN 
Cars ON Categories.categories_id=Cars.categories_id
WHERE Cars.car_id IS NULL

SELECT Customers.[name],Customers.surname,Sales.yearSale
FROM
Customers
LEFT JOIN 
Sales On Customers.customer_id=Sales.customer_id
WHERE Sales.sales_id IS NULL OR Sales.sales_id IS NOT NULL

SELECT Customers.[name],Customers.surname
FROM
Customers
LEFT JOIN 
Sales On Customers.customer_id=Sales.customer_id
WHERE Sales.sales_id IS NULL