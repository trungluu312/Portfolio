-- Update to replace NA in Markdown to 0
UPDATE [Retail Analytics]..['Features data set$']
set MarkDown1 = 0
WHERE MarkDown1 = 'NA'

UPDATE [Retail Analytics]..['Features data set$']
set MarkDown2 = 0
WHERE MarkDown2 = 'NA'

UPDATE [Retail Analytics]..['Features data set$']
set MarkDown3 = 0
WHERE MarkDown3 = 'NA'

UPDATE [Retail Analytics]..['Features data set$']
set MarkDown4 = 0
WHERE MarkDown4 = 'NA'

UPDATE [Retail Analytics]..['Features data set$']
set MarkDown5 = 0
WHERE MarkDown5 = 'NA'

SELECT *
FROM [Retail Analytics]..['Features data set$']

-- Check Markdown data
SELECT *
FROM [Retail Analytics]..['Features data set$'] feature
JOIN [Retail Analytics]..['sales data-set$'] sale ON feature.Store = sale.Store 
												and feature.Date = sale.Date



ALTER TABLE [Retail Analytics]..['sales data-set$']
DROP COLUMN F6, F7, F8, F9, F10

ALTER TABLE [Retail Analytics]..['Features data set$']
ALTER COLUMN MarkDown1 float;

ALTER TABLE [Retail Analytics]..['Features data set$']
ALTER COLUMN MarkDown2 float;

ALTER TABLE [Retail Analytics]..['Features data set$']
ALTER COLUMN MarkDown3 float;

ALTER TABLE [Retail Analytics]..['Features data set$']
ALTER COLUMN MarkDown4 float;

ALTER TABLE [Retail Analytics]..['Features data set$']
ALTER COLUMN MarkDown5 float;


-- Sales per Store, Type and Dept
SELECT sale.Store, sale.Dept, sale.Date, SUM(sale.Weekly_Sales) AS Total_Sales, store.Type
FROM [Retail Analytics]..['sales data-set$'] sale
JOIN [Retail Analytics]..['stores data-set$'] store ON sale.Store = store.Store
GROUP BY sale.Dept, sale.Store, sale.Date, store.Type
ORDER BY 1,2,3


SELECT *
FROM [Retail Analytics]..['sales data-set$'] sale
JOIN [Retail Analytics]..['stores data-set$'] store ON sale.Store = store.Store
WHERE Type = 'C'


SELECT *
FROM [Retail Analytics]..['Features data set$']
WHERE MarkDown1 = 0 and MarkDown2 = 0