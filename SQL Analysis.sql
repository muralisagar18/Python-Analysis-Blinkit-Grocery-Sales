select* from blinkit_data


update blinkit_data
set Item_Fat_Content=
case
when Item_Fat_Content in ('LF','low fat') then 'Low Fat'
when Item_Fat_Content in ('reg') then 'Regular'
else Item_Fat_Content
end
select distinct Item_Fat_Content from  blinkit_data

/* Total Sales: The overall revenue generated from all items sold.*/

select CAST(SUM(Sales) as decimal(10,2 ))as total_sales from blinkit_data

/*Average Sales: The average revenue per sale.*/

select CAST(avg(Sales) as decimal(10,2))as avg_sales from blinkit_data

/*Number of Items: The total count of different items sold.*/

select COUNT(*)  as no_of_items from blinkit_data

/*Average Rating: The average customer rating for items sold. */

select CAST(avg(Rating) as decimal(10,2)) as avg_rating from blinkit_data


/*Total Sales by Fat Content:*/

Select Item_Fat_Content,
		CAST(SUM(Sales) as decimal(10,2 ))as total_sales,
		CAST(avg(Sales) as decimal(10,2))as avg_sales,
		COUNT(*)  as no_of_items,
		CAST(avg(Rating) as decimal(10,2)) as avg_rating 
		from blinkit_data
		GROUP BY Item_Fat_Content

/*Total Sales by Item Type:*/

Select Item_Type,
		CAST(SUM(Sales) as decimal(10,2 ))as total_sales,
		CAST(avg(Sales) as decimal(10,2))as avg_sales,
		COUNT(*)  as no_of_items,
		CAST(avg(Rating) as decimal(10,2)) as avg_rating 
		from blinkit_data
		GROUP BY Item_Type

/*Fat Content by Outlet for Total Sales:*/

select Outlet_size,	
		CAST(SUM(Sales) as decimal(10,2 ))as total_sales,
		CAST(avg(Sales) as decimal(10,2))as avg_sales,
		COUNT(*)  as no_of_items,
		CAST(avg(Rating) as decimal(10,2)) as avg_rating 
		from blinkit_data
		group by Outlet_size

 /*Total Sales by Outlet Establishment:*/

 select Outlet_Establishment_Year,	
		CAST(SUM(Sales) as decimal(10,2 ))as total_sales,
		CAST(avg(Sales) as decimal(10,2))as avg_sales,
		COUNT(*)  as no_of_items,
		CAST(avg(Rating) as decimal(10,2)) as avg_rating 
		from blinkit_data
		group by Outlet_Establishment_Year

/*Percentage of Sales by Outlet Size:*/

Select Outlet_Size,	
	CAST(SUM(Sales) as decimal(10,2 ))as total_sales,
		 CAST((sum(Sales) * 100.0 / SUM(SUM(Sales)) OVER() ) AS decimal(10,2)) as percentage_sales 
		 from blinkit_data
		group by Outlet_Size


/*Sales by Outlet Location:*/

select Outlet_Location_Type,
	ISNULL([Low Fat],0) as Low_Fat,
	ISNULL([Regular],0) as Regular 
from 
 (
	select Outlet_Location_Type, Item_Fat_Content ,
	
	CAST(sum(Sales) as decimal(10,2))as total_sales from blinkit_data
	group by Outlet_Location_Type, Item_Fat_Content 
	) as SourceTable
	pivot
	(
	sum(total_sales) 
	for Item_Fat_Content IN ([Low Fat], [Regular])
	) as PivotTable

/*All Metrics by Outlet Type:*/
select Outlet_Type,	
		CAST(SUM(Sales) as decimal(10,2 ))as total_sales,
		CAST(avg(Sales) as decimal(10,2))as avg_sales,
		COUNT(*)  as no_of_items,
		CAST(avg(Rating) as decimal(10,2)) as avg_rating 
		from blinkit_data
		group by Outlet_Type
