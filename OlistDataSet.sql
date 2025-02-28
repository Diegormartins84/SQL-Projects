--Data Analysis Project in SQL Server

--Dataset: --https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
--Tutorial: --https://www.youtube.com/watch?v=8f9eeVS8-Zw&t=2331s

--Steps:
--1. Data Loading: Import the necessary tables from the dataset into SQL Server using SSMS.
--2. Data Exploration: Visualize the imported tables to understand their structure and content.

SELECT TOP 10 * FROM [dbo].[TB_CG_OLIST_CUSTOMER]
SELECT TOP 10 * FROM [dbo].[TB_CG_OLIST_GEOLOCALIZATION]
SELECT TOP 10 * FROM [dbo].[TB_CG_OLIST_ORDER_ITEMS]
SELECT TOP 10 * FROM [dbo].[TB_CG_OLIST_ORDER_PAYMENTS]
SELECT TOP 10 * FROM [dbo].[TB_CG_OLIST_ORDERS]
SELECT TOP 10 * FROM [dbo].[TB_CG_OLIST_PRODUCTS]
SELECT TOP 10 * FROM [dbo].[TB_CG_OLIST_SELLERS]
SELECT TOP 10 * FROM [dbo].[TB_CG_PRODUCT_CATEGORY]

--3. Create fact tables for each database (*switch  database names*)

--Most comon data types:
--INT
--FLOAT
--NVARCHAR
--DATETIME (may use DATE)

--Set empty to NULL
--UPDATE [OLIST].[dbo].[TB_CG_OLIST_ORDERS] SET order_delivered_customer_date = NULL
--WHERE order_delivered_carrier_date=''


--Creating Fact Tables
SELECT * FROM TB_ACT_OLIST_CUSTOMER

CREATE TABLE TB_ACT_OLIST_CUSTOMER
(
CUSTOMER_ID NVARCHAR(150),
CUSTOMER_UNIQUE_ID NVARCHAR(150),
CUSTOMER_ZIP_CODE_PREFIX NVARCHAR(15),
CUSTOMER_CITY NVARCHAR(100),
CUSTOMER_STATE CHAR(2)
)
INSERT INTO TB_ACT_OLIST_CUSTOMER
SELECT * FROM TB_CG_OLIST_CUSTOMER

SELECT * FROM TB_ACT_OLIST_CUSTOMER


SELECT TOP 10 * FROM [dbo].[TB_CG_OLIST_GEOLOCATION]

CREATE TABLE TB_ACT_OLIST_GEOLOCATION
(
GEOLOCATION_ZIP_CODE_PREFIX NVARCHAR(15),
GEOLOCATION_LAT NVARCHAR(100),
GEOLOCATION_LNG NVARCHAR(100),
GEOLOCATION_CITY NVARCHAR(100),
GEOLOCATION_STATE CHAR(2)
)
SELECT * FROM TB_ACT_OLIST_GEOLOCATION

INSERT INTO TB_ACT_OLIST_GEOLOCATION
SELECT * FROM TB_CG_OLIST_GEOLOCATION


SELECT TOP 10 * FROM [dbo].[TB_CG_OLIST_ORDER_ITEMS]

CREATE TABLE TB_ACT_OLIST_ORDER_ITEMS
(
ORDER_ID NVARCHAR(50),
ORDER_ITEM_ID NVARCHAR(100),
PRODUCT_ID NVARCHAR(100),
SELLER_ID NVARCHAR(100),
SHIPPING_LIMIT_DATE DATE,
PRICE FLOAT(50),
FREIGHT_VALUE FLOAT(50)
)
SELECT * FROM TB_ACT_OLIST_ORDER_ITEMS

INSERT INTO TB_ACT_OLIST_ORDER_ITEMS
SELECT * FROM [TB_CG_OLIST_ORDER_ITEMS]


SELECT TOP 10 * FROM [dbo].[TB_CG_OLIST_ORDER_PAYMENTS]

CREATE TABLE TB_ACT_OLIST_ORDER_PAYMENTS
(
ORDER_ID NVARCHAR(50),
PAYMENT_SEQUENCIAL INT,
PAYMENT_TYPE NVARCHAR(100),
PAYMENT_INSTALLMENTS INT,
PAYMENT_VALUE FLOAT(50)
)
SELECT * FROM TB_ACT_OLIST_ORDER_PAYMENTS

INSERT INTO TB_ACT_OLIST_ORDER_PAYMENTS
SELECT * FROM [TB_CG_OLIST_ORDER_PAYMENTS]


SELECT TOP 10 * FROM [dbo].[TB_CG_OLIST_ORDER_REVIEWS]

CREATE TABLE TB_ACT_OLIST_ORDER_REVIEWS
(
REVIEW_ID NVARCHAR(50),
ORDER_ID NVARCHAR(50),
REVIEW_SCORE INT,
REVIEW_COMMENT_TITLE NVARCHAR(300),
REVIEW_COMMENT_MESSAGE NVARCHAR(300),
REVIEW_CREATION_DATE DATE,
RIVIEW_ANSWER_TIMESTAMP DATE
)
SELECT * FROM TB_ACT_OLIST_ORDER_REVIEWS

INSERT INTO TB_ACT_OLIST_ORDER_REVIEWS
SELECT * FROM [TB_CG_OLIST_ORDER_REVIEWS]

--DROP TABLE TB_ACT_OLIST_ORDER_REVIEWS

SELECT TOP 10 * FROM [OLIST].[dbo].[TB_CG_OLIST_ORDERS]


CREATE TABLE OLIST.dbo.TB_ACT_OLIST_ORDERS
(
ORDER_ID NVARCHAR(50),
CUSTOMER_ID NVARCHAR(50),
ORDER_STATUS NVARCHAR(50),
ORDER_PURCHASE_TIMESTAMP DATE,
ORDER_APPROVED_AT DATE,
ORDER_DELIVERED_CARRIER_DATE DATE,
ORDER_DELIVERED_CUSTOMER_DATE DATE,
ORDER_ESTIMATED_DELIVERY_DATE DATE
)
SELECT * FROM OLIST.dbo.TB_ACT_OLIST_ORDERS

INSERT INTO OLIST.dbo.TB_ACT_OLIST_ORDERS
SELECT * FROM OLIST.dbo.TB_CG_OLIST_ORDERS

DROP TABLE OLIST.dbo.TB_ACT_OLIST_ORDERS


SELECT TOP 10 * FROM [dbo].[TB_CG_OLIST_PRODUCTS]

CREATE TABLE TB_ACT_OLIST_PRODUCTS
(
PRODUCT_ID NVARCHAR(50),
PRODUCT_CATEGORY_NAME NVARCHAR(250),
PRODUCT_NAME_LENGHT INT,
PRODUCT_DESCRIPTION_LENGHT INT,
PRODUCT_PHOTOS_QTY INT,
PRODUCT_WEIGHT_G INT,
PRODUCT_LENGTH_CM INT,
PRODUCT_HEIGHT_CM INT,
PRODUCT_WIDTH_CM INT
)
SELECT * FROM TB_ACT_OLIST_PRODUCTS

INSERT INTO TB_ACT_OLIST_PRODUCTS
SELECT * FROM [TB_CG_OLIST_PRODUCTS]
--DROP TABLE TB_ACT_OLIST_ORDERS


SELECT TOP 10 * FROM [dbo].[TB_CG_OLIST_SELLERS]

CREATE TABLE TB_ACT_OLIST_SELLERS
(
SELLER_ID NVARCHAR(50),
SELLER_ZIP_CODE_PREFIX INT,
SELLER_CITY NVARCHAR(200),
SELLER_STATE NVARCHAR(2)
)
SELECT * FROM TB_ACT_OLIST_SELLERS

INSERT INTO TB_ACT_OLIST_SELLERS
SELECT * FROM [TB_CG_OLIST_SELLERS]
--DROP TABLE TB_ACT_OLIST_SELLERS

SELECT TOP 10 * FROM [dbo].[TB_CG_PRODUCT_CATEGORY]

CREATE TABLE TB_ACT_PRODUCT_CATEGORY
(
PRODUCT_CATEGORY_NAME NVARCHAR(200),
PRODUCT_CATEGORY_NAME_ENGLISH NVARCHAR(200)
)
SELECT * FROM TB_ACT_PRODUCT_CATEGORY

INSERT INTO TB_ACT_PRODUCT_CATEGORY
SELECT * FROM [TB_CG_PRODUCT_CATEGORY]
--DROP TABLE TB_ACT_OLIST_PRODUCT_CATEGORY


--4. Creating View
--Which customers placed an order? (Understanding order behavior)

SELECT * FROM OLIST.dbo.TB_ACT_OLIST_ORDERS

CREATE VIEW VW_PEDIDOS_POR_CLIENTE
AS
SELECT O.*, C.CUSTOMER_STATE
FROM [OLIST].[dbo].[TB_ACT_OLIST_ORDERS] AS O
INNER JOIN [OLIST].[dbo].[TB_ACT_OLIST_CUSTOMER] AS C
ON O.CUSTOMER_ID = C.CUSTOMER_ID

SELECT * FROM VW_PEDIDOS_POR_CLIENTE

--Create changes in View:
ALTER VIEW VW_PEDIDOS_POR_CLIENTE
AS
SELECT O.*, C.CUSTOMER_STATE
FROM [OLIST].[dbo].[TB_ACT_OLIST_ORDERS] AS O
INNER JOIN [OLIST].[dbo].[TB_ACT_OLIST_CUSTOMER] AS C
ON O.CUSTOMER_ID = C.CUSTOMER_ID
WHERE ORDER_STATUS = 'delivered'


--5. To create a report:

--Open Excel and go to Data, Get Data, From SQL Server Database.
--Enter your database details.
--Database name: OLIST
--In the advanced options box, type: SELECT * FROM VW_PEDIDOS_POR_CLIEN