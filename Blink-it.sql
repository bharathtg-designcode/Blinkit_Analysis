select * from BlinkIT_Grocery_Data
select COUNT(*) from BlinkIT_Grocery_Data

--data cleaning 'low fat and regular'
update BlinkIT_Grocery_Data
set Item_Fat_Content =
case
when Item_Fat_Content in ('LF','low fat') then 'Low Fat'
when Item_Fat_Content = 'reg' then 'Regular'
else Item_Fat_Content
end

select distinct(Item_Fat_Content) from BlinkIT_Grocery_Data

--KPI Requirement
--Total_sales
select cast(sum(Sales)/1000000 as decimal(10,2))as total_sales_millions from BlinkIT_Grocery_Data
where Item_Fat_Content ='regular'
--Average_sales
select CAST(AVG(Sales) as decimal(10,2)) as Avg_sales from BlinkIT_Grocery_Data
where Item_Fat_Content ='Low Fat'
--number of items
select count(*) as no_of_items from BlinkIT_Grocery_Data
where Item_Fat_Content ='Low Fat'

--average_rating
select CAST(AVG(Rating) as decimal(10,2)) as Avg_rating from BlinkIT_Grocery_Data
where Item_Fat_Content ='Regular'

--Granualar Reuirement
select item_Fat_Content,
		cast(sum(Sales)/1000000 as decimal(10,2))as total_sales_millions,
		CAST(AVG(Sales) as decimal(10,2)) as Avg_sales,
		count(*) as no_of_items,
		CAST(AVG(Rating) as decimal(10,2)) as Avg_rating
from BlinkIT_Grocery_Data
group by item_Fat_Content
order by total_sales_millions

select * from BlinkIT_Grocery_Data

--total sales by item sales
select Item_Type,
		cast(sum(Sales)/1000000 as decimal(10,2))as total_sales_thousands,
		CAST(AVG(Sales) as decimal(10,2)) as Avg_sales,
		count(*) as no_of_items,
		CAST(AVG(Rating) as decimal(10,2)) as Avg_rating
from BlinkIT_Grocery_Data
where Outlet_Establishment_Year = 2022
group by Item_Type
order by total_sales_thousands 


--fat content by outlet for total sales
SELECT Outlet_Location_Type,
       ISNULL([Low Fat], 0) AS Low_Fat,
       ISNULL([Regular], 0) AS Regular
FROM
(
    SELECT Outlet_Location_Type, item_fat_content,
	CAST(Sales AS DECIMAL(10,2)) AS total_sales
    FROM BlinkIT_Grocery_Data
) AS source_table
PIVOT
(
    SUM(total_sales)
    FOR item_fat_content IN ([Low Fat], [Regular])
) AS pivot_table
ORDER BY Outlet_Location_Type;

---outlet establishment year
select * from BlinkIT_Grocery_Data;
--*/---
select Outlet_Establishment_year,
	cast(sum(Sales) as decimal(10,2)) as total_sales,
	cast(avg(Sales) as decimal(10,2)) as Avg_sales,
	count (*) as no_of_items,
	cast(avg(rating) as decimal(10,2)) as avg_rating
from BlinkIT_Grocery_Data
group by Outlet_Establishment_year
order by total_sales desc

-------Chart's Requirement--------
WITH Total AS (
    SELECT SUM(Sales) AS total_sales
    FROM BlinkIT_Grocery_Data
)

SELECT 
    Outlet_size,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS total_sales,
    CAST(SUM(Sales) * 100.0 / t.total_sales AS DECIMAL(10,2)) AS Sales_percentage
FROM 
    BlinkIT_Grocery_Data, Total t
GROUP BY 
    Outlet_size, t.total_sales
ORDER BY 
    total_sales DESC;

    select * from BlinkIT_Grocery_Data;

------outlet location---------
WITH Total AS (
    SELECT SUM(Sales) AS total_sales
    FROM BlinkIT_Grocery_Data
)

SELECT 
    Outlet_Location_Type,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS total_sales,
    CAST(SUM(Sales) * 100.0 / t.total_sales AS DECIMAL(10,2)) AS Sales_percentage
FROM 
    BlinkIT_Grocery_Data, Total t
GROUP BY 
    Outlet_Location_Type, t.total_sales
ORDER BY 
    total_sales


----outlet type----
WITH Total AS (
    SELECT SUM(Sales) AS total_sales
    FROM BlinkIT_Grocery_Data
)

SELECT 
    Outlet_Type,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS total_sales,
    CAST(SUM(Sales) * 100.0 / t.total_sales AS DECIMAL(10,2)) AS Sales_percentage
FROM 
    BlinkIT_Grocery_Data, Total t
GROUP BY 
    Outlet_Type, t.total_sales
ORDER BY 
    total_sales desc;