use blinkit_db;

select * from [BlinkIT_Grocery];

select COUNT(*) from [BlinkIT_Grocery];

update BlinkIT_Grocery 
set Item_Fat_Content = 
Case 
when Item_Fat_Content IN ('LF','low fat') then 'Low Fat'
when Item_Fat_Content = 'reg' then 'Regular'
else Item_Fat_Content
End

select * from BlinkIT_Grocery;

select distinct(Item_Fat_Content) from BlinkIT_Grocery;

select * from BlinkIT_Grocery;

select cast(SUM(Sales)/1000000 AS decimal(10,2)) AS Total_Sales_Millions from BlinkIT_Grocery;

select cast(AVG(Sales) as decimal(10,0)) AS Avg_Sales from BlinkIT_Grocery;

select * from BlinkIT_Grocery;

select COUNT(*) AS No_of_Items from BlinkIT_Grocery;

select cast(AVG(Sales) as decimal(10,0)) AS Avg_Sales from BlinkIT_Grocery;

select cast(SUM(Sales)/1000000 AS decimal(10,2)) AS Total_Sales_Millions 
from BlinkIT_Grocery where Item_Fat_Content = 'Low Fat';


select COUNT(*) AS No_of_Item 
from BlinkIT_Grocery where Outlet_Establishment_Year = 2022;

Select * from BlinkIT_Grocery;

select cast(AVG(Rating) as decimal(10,0)) AS Avg_Sales from BlinkIT_Grocery;

select * from BlinkIT_Grocery;

select Item_Fat_Content, 
	Concat(cast(SUM(Sales)/1000 AS decimal(10,2)),' K')As Total_Sales_Thousands,
	CAST(avg(Sales) As decimal(10, 1)) AS AVG_sales,
	COUNT(*) as No_of_Items
from BlinkIT_Grocery
Group By Item_Fat_Content 
Order by Total_Sales_Thousands DESC;


select * from BlinkIT_Grocery;

select TOP 5 Item_Type,
	CAST(SUM(Sales) AS decimal(10,2)) AS Total_Sales,
	CAST(AVG(Sales) As decimal(10,1)) As Avg_Sales,
	COUNT(*) AS No_of_Items,
	CAST(avg(rating) AS decimal(10,2)) AS Avg_Ratings
from BlinkIT_Grocery
group by Item_Type
order by Total_Sales DESC;

Select * from BlinkIT_Grocery;

select Outlet_Location_Type,
	ISNULL([Low Fat], 0) AS Low_Fat,
	ISNULL([Regular], 0) AS Regular
from 
(
	Select Outlet_Location_type, Item_Fat_Content,
			CAST(SUM(Sales) AS decimal(10,2)) AS Total_Sales
	from BlinkIT_Grocery
	group by Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT 
(
	SUM(Total_Sales)
	for Item_Fat_Content IN ([Low Fat],[Regular])
) AS PivotTable
Order BY Outlet_Location_Type;


select * from BlinkIT_Grocery

select Outlet_Establishment_Year,
	cast(sum(Sales) AS decimal (10,2)) As Total_Sales,
	CAST(AVG(Sales) AS Decimal(10,2)) AS AVG_Sales,
	COUNT(*) AS No_of_Items,
	CAST(avg(Rating) AS decimal(10,2)) AS Avg_Rating
from BlinkIT_Grocery
Group By Outlet_Establishment_Year
order by Total_Sales ASC;


# Percentage of Sales by Outlet Size
select * from BlinkIT_Grocery;
select Outlet_size,
	CAST(sum(Sales) AS decimal(10,2)) AS Total_Sales,
	concat(CAST((SUM(Sales) *100.0/SUM(SUM(Sales)) over()) AS decimal(10,2)),' %' )AS Sales_percentage
from BlinkIT_Grocery
Group by Outlet_Size
order by Total_Sales Desc

# Sales BY outlet location
select * from BlinkIT_Grocery;
select Outlet_Location_Type,
	cast(sum(Sales)/1000 AS decimal(10,2)) AS Total_sales_Thousands,
	concat(CAST((SUM(Sales) *100.0/SUM(SUM(Sales)) over()) AS decimal(10,2)),' %' )AS Sales_percentage
	from BlinkIT_Grocery
	Group by Outlet_location_type
	order by Total_sales_Thousands;


select Outlet_Type,
	cast(sum(Sales)/1000 AS decimal(10,2)) AS Total_sales_Thousands,
	concat(CAST((SUM(Sales) *100.0/SUM(SUM(Sales)) over()) AS decimal(10,2)),' %' )AS Sales_percentage,
	cast(avg(Sales) AS decimal(10,1)) AS Avg_Sales,
	Count(*) AS no_of_Items,
	Cast(Avg(Rating) AS decimal(10,2)) As Avg_Rating
	from BlinkIT_Grocery
	Group by Outlet_Type
	order by Total_sales_Thousands;