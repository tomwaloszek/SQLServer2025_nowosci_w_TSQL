/* ###########################################
   ##     DEMO: OBSŁUGA TYPU JSON           ##
   ########################################### */

DROP TABLE IF EXISTS dbo.orders;
GO
CREATE TABLE dbo.orders
(
    order_id INT PRIMARY KEY,         
    customer NVARCHAR(50),            
    details JSON                      
);
GO

INSERT INTO dbo.orders (order_id, customer, details) VALUES
(1, 'Tony Stark', '{"title": "Civil War", "hero": "Iron Man", "quantity": 2, "price": 8.70}'),
(2, 'Peter Parker', '{"title": "Spider-Man: Kraven’s Last Hunt", "hero": "Spider-Man", "quantity": 1, "price": 9.20}'),
(3, 'Logan Howlett', '{"title": "Old Man Logan", "hero": "Wolverine", "quantity": 3, "price": 9.10}'),
(4, 'Stephen Strange', '{"title": "Infinity Gauntlet", "hero": "Thanos", "quantity": 2, "price": 8.80}'),
(5, 'Steve Rogers', '{"title": "Captain America: Winter Soldier", "hero": "Captain America", "quantity": 1, "price": 9.00}'),
(6, 'Wanda Maximoff', '{"title": "House of M", "hero": "Scarlet Witch", "quantity": 1, "price": 8.50}');
GO


SELECT * FROM dbo.orders;
GO


SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    CHARACTER_MAXIMUM_LENGTH
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'orders';
GO


-- Rzutowanie tekstu na JSON
SELECT CAST('{"title": "Sample", "quantity": 1}' AS JSON) AS JsonResult;
GO

-- Analiza typu przez SQL Server
EXEC sp_describe_first_result_set 
    N'SELECT CAST(''{"title": "Sample"}'' AS JSON) AS JsonResult';
GO



-- Agregacja całych zamówień do jednej tablicy JSON
SELECT 
    JSON_ARRAYAGG(details) AS AllOrders_JSONArray
FROM 
    dbo.orders;
GO



-- Agregacja nazw klientów do jednej tablicy JSON
SELECT 
    JSON_ARRAYAGG(customer) AS CustomerNames_JSON
FROM 
    dbo.orders;
GO




-- Lista klientów i ich zamówień
SELECT 
    customer,
    details
FROM 
    dbo.orders;
GO

-- Mapowanie klient → zamówienie jako JSON
SELECT 
    JSON_OBJECTAGG(customer:details) AS CustomerOrderMap_JSON
FROM 
    dbo.orders;
GO
