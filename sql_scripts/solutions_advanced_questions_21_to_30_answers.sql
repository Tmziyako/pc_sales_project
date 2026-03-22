SELECT [Continent]
      ,[Country_or_State]
      ,[Province_or_City]
      ,[Shop_Name]
      ,[Shop_Age]
      ,[PC_Make]
      ,[PC_Model]
      ,[Storage_Type]
      ,[Customer_Name]
      ,[Customer_Surname]
      ,[Customer_Contact_Number]
      ,[Customer_Email_Address]
      ,[Sales_Person_Name]
      ,[Sales_Person_Department]
      ,[Cost_Price]
      ,[Sale_Price]
      ,[Payment_Method]
      ,[Discount_Amount]
      ,[Purchase_Date]
      ,[Ship_Date]
      ,[Finance_Amount]
      ,[RAM]
      ,[Credit_Score]
      ,[Channel]
      ,[Priority]
      ,[Cost_of_Repairs]
      ,[Total_Sales_per_Employee]
      ,[PC_Market_Price]
      ,[Storage_Capacity]
  FROM [PC_SalesDo].[dbo].[pc_data ]

-- ADVANCED QUESTIONS

-- 21. Calculate profit per Shop Name.
Select Shop_Name,
sum(sale_price)-sum(cost_Price) as profit 
from [dbo].[pc_data ] 
group by Shop_Name;
-- 22. Calculate profit margin per sale ((Sale Price - Cost Price) / Sale Price).
Select Shop_Name,
sum(sale_price)-sum(cost_Price) as profit,
(sum(sale_price)-sum(cost_Price))*100/sum(sale_price) as profit_Margin_Percentage
from [dbo].[pc_data ] 
group by Shop_Name;
-- 23. Determine which Continent has the highest total revenue.
Select top 1 Continent,
sum(sale_Price) as Revenue
From [dbo].[pc_data ]
group by Continent
Order by
Revenue desc;

-- 24. Calculate average Sale Price per RAM size.
Select Ram,
AVG(Sale_price) as Sale_Price_Per_Ram
from [dbo].[pc_data ]
group by RAM;
-- 25. Find the PC Model with the highest Sale Price.
select top 1
Pc_Model,
max(sale_price) as Highest_Price_PC_Model
from [dbo].[pc_data ]
group by PC_Model
order by PC_Model asc;


-- 26. Calculate the average number of days between Purchase Date and Ship Date.
select AVG(DATEDIFF(day,TRY_CONVERT(DATE,purchase_date,111),TRY_CONVERT(DATE,ship_date,111))) as Avgdaybetweenpurchaseandship
from [dbo].[pc_data ];
-- 27. Determine which Sales Person Department generates the highest revenue.
select top 1 
sales_person_department,
Sum(sale_price) as Revenue
from [dbo].[pc_data ]
group by Sales_Person_Department
order by Sales_Person_Department asc;

select
sales_person_department,
Sum(sale_price) as Revenue
from [dbo].[pc_data ]
group by Sales_Person_Department
order by Sales_Person_Department asc;
-- 28. Calculate total revenue per Storage Capacity.
select storage_capacity,
sum(sale_price) as Revenue_Per_storage_capacity
from [dbo].[pc_data ]
group by storage_capacity;
-- 29. Identify sales where Sale Price is lower than PC Market Price.
select PC_Model,
Shop_Name,
Sale_price,
PC_Market_Price
from [dbo].[pc_data ]
where sale_price < pc_market_price;

select sale_price,
pc_market_price
from [dbo].[pc_data ]
where Sale_Price = PC_Market_Price;
-- 30. Rank Sales Person Name by Total Sales per Employee using a window function.
Select Sales_person_Name,
sum(sale_price) as Total_Sales,
Rank() over (order by sum(sale_price) desc) as SalesRank
from [dbo].[pc_data ]
group by Sales_Person_Name
order by SalesRank asc;