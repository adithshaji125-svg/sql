use MYDB1;

select *from [dbo].[SalesData$];

--1.display netsales is greater than 50,000

select *from [dbo].[SalesData$] where NetSales>50000;

--2.orders from kerala

select *from [dbo].[SalesData$] where State='kerala';

--3.display completed orders where profit is greater than 10,000;

select *from [dbo].[SalesData$] where OrderStatus='completed' and Profit>10000;

--3.payment method is upi or creditcard

select *from [dbo].[SalesData$] where PaymentMethod='upi' or PaymentMethod='credit card';

--4.orders between 2023-01-01 and 2024-12-31

select *from [dbo].[SalesData$] where OrderDate between '2023-01-01' and '2024-12-31';

--2.aggregate functions

--1.find the total netsales

select sum(netsales) as  totalnetsales from [dbo].[SalesData$];

--2,avg unitprice

select avg(unitprice) as averageunitprice from [dbo].[SalesData$];

--3.highest and lowest sales

select max(netsales) as highestnetsales,min(netsales) as lowestnetsales from [dbo].[SalesData$];

--4.total quantity sold

select sum(quantity) as totalquantity from [dbo].[SalesData$];

--5.total number of orders

select count(*) as totalorders from [dbo].[SalesData$];

--3.Group by

--1.total sales by state

select state, sum(netsales) as totalnetsales from [dbo].[SalesData$] group by state;

--2.total profit by category

select Category, sum(profit) as totalprofit from [dbo].[SalesData$] group by Category;

--3.total quantity by productname

select productname, sum(quantity) as totalquantity from [dbo].[SalesData$] group by ProductName;

--4.number of orders by payment method

select paymentmethod,count(*) as numberodorers from [dbo].[SalesData$] group by paymentmethod;

--5.average sales by saleschannel

select saleschannel, avg(netsales) as averagenetsales from [dbo].[SalesData$] group by SalesChannel;

--4.Having

--1.states with total sales higher than 10,00,000

select state, sum(netsales) as totalnetsales from [dbo].[SalesData$] group by state HAVING sum(netsales)>1000000;

--2.products with total quantity sold greater than 100

select ProductName, sum(quantity) as totalquantity from [dbo].[SalesData$] group by ProductName HAVING sum(quantity)>100;

--3.categories with avg profit is greater than 5,000

select Category, avg(profit) as averageprofit from [dbo].[SalesData$] group by Category HAVING avg(profit)>5000;

--4.salespersons with more than 20,00,000 sales

select salesperson, sum(netsales) as totalnetsales from [dbo].[SalesData$] group by Salesperson HAVING sum(netsales)>2000000;

--5.cities having more than 50 orders

select city, count(*) as numberoforders from [dbo].[SalesData$] group by city HAVING count(*)>50;

--5.CASE

--1.create saleslevel >=50,000 high,20,0000 medium,below 20,000 low

select*, case when netsales>=50000 then 'high'
when netsales>=20000 then 'medium' else 'low'
end as saleslevel from [dbo].[SalesData$];

--2.categorize profit and loss;

select*, case when profit >0 then 'profit'
else 'loss'
end as profitstatus from [dbo].[SalesData$];

--3.categorize orders based on quantity

select*, case when quantity between 1 and 2 then 'small'
when quantity between 3 and 5  then 'medium' else 'large'
end as salesquantity from [dbo].[SalesData$];

--4.create discount category

select*, case when DiscountPct=0 then 'no discount'
when DiscountPct between 1 and  10 then 'low discount' else 'high discount'
end as discountcategory from [dbo].[SalesData$];

--5.customer order status classsification

select*, case when orderstatus='completed' then 'completed'
when orderstatus='shipped' then 'in progress'
when orderstatus='returned' then 'returned'
when orderstatus='cancelled' then 'cancelled' else 'other'
end as statusclassification from [dbo].[SalesData$];

--6.STRING FUCTIONS

--1.customer name in uppercase 

select upper(customername) as customernameupper from [dbo].[SalesData$];

--2.product name in lowecase

select lower(productname) as productnamelower from [dbo].[SalesData$];

--3.length of each customername

select len(customername) as customernamelength from [dbo].[SalesData$];

--4.first 3 characters of product id

select Productid,left(productid,3) as first3characters from [dbo].[SalesData$];

--5.remove leading/trailing spaces from customer name

select customername,trim(customername) as cleancustomer from [dbo].[SalesData$]

--7.DATE FUNCTIONS

--1.extract the year from orderdate

select orderdate, YEAR(orderdate) as orderyear from [dbo].[SalesData$];

--2.extract the month

select orderdate, MONTH(orderdate) as ordermonth from [dbo].[SalesData$];

--3.no of orders for each year.

select YEAR(orderdate) as orderyear, count(*) as no_oforders from [dbo].[SalesData$] group by YEAR(orderdate) order by orderyear;

--4.total sales for each month

SELECT 
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth,
    SUM(NetSales) AS TotalSales
FROM [dbo].[SalesData$]
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY OrderYear, OrderMonth;

--5.order placed during weekends


--8.CTE

--1.total sales by state

with statesales as 
(
select state,sum(netsales) as totalsales from [dbo].[SalesData$] group by state
)
select*from statesales;

--2.total profit by product

with productprofit as
(select productname,sum(profit) as totalprofit from [dbo].[SalesData$] group by productname)
select*from productprofit;

--3.top 5 products with sales

with productsales as 
(select productname,sum(netsales) as totalnetsales from [dbo].[SalesData$] group by productname)
select top 5*from productsales order by totalnetsales desc;

--9.ROW_NUMBER(),RANK(),DENSERANK()

--1.rank products based on total sales

select productname,sum(netsales) as totalsales,RANK() OVER(order by sum(netsales)desc) as salesrank from [dbo].[SalesData$]
group by productname;

--2.rank salespersons based on total profit

SELECT 
    Salesperson,
    SUM(Profit) AS TotalProfit,
    RANK() OVER (ORDER BY SUM(Profit) DESC) AS ProfitRank
FROM [dbo].[SalesData$]
GROUP BY Salesperson;

--3.row numbers based on orderdate

SELECT 
    OrderID,
    OrderDate,
    ROW_NUMBER() OVER (ORDER BY OrderDate) AS RowNumber
FROM [dbo].[SalesData$];

--4. Rank products within each category

SELECT 
    Category,
    ProductName,
    SUM(NetSales) AS TotalSales,
    RANK() OVER (
        PARTITION BY Category 
        ORDER BY SUM(NetSales) DESC
    ) AS CategoryRank
FROM [dbo].[SalesData$]
GROUP BY Category, ProductName;

--5.Compare RANK() and DENSE_RANK()

SELECT 
    ProductName,
    SUM(NetSales) AS TotalSales,
    RANK() OVER (ORDER BY SUM(NetSales) DESC) AS RankValue,
    DENSE_RANK() OVER (ORDER BY SUM(NetSales) DESC) AS DenseRankValue
FROM [dbo].[SalesData$]
GROUP BY ProductName;

--10. LAG() & LEAD()

--1. Current year and previous year's sales using LAG()

WITH YearSales AS
(
    SELECT 
        YEAR(OrderDate) AS SalesYear,
        SUM(NetSales) AS TotalSales
    FROM [dbo].[SalesData$]
    GROUP BY YEAR(OrderDate)
)
SELECT 
    SalesYear,
    TotalSales,
    LAG(TotalSales) OVER (ORDER BY SalesYear) AS PreviousYearSales
FROM YearSales
ORDER BY SalesYear;

--2. Current year and next year's sales using LEAD()

WITH YearSales AS
(
    SELECT 
        YEAR(OrderDate) AS SalesYear,
        SUM(NetSales) AS TotalSales
    FROM [dbo].[SalesData$]
    GROUP BY YEAR(OrderDate)
)
SELECT 
    SalesYear,
    TotalSales,
    LEAD(TotalSales) OVER (ORDER BY SalesYear) AS NextYearSales
FROM YearSales
ORDER BY SalesYear;


--11. PARTITION BY

--1. Rank products separately within each category

SELECT 
    Category,
    ProductName,
    SUM(NetSales) AS TotalSales,
    RANK() OVER (
        PARTITION BY Category
        ORDER BY SUM(NetSales) DESC
    ) AS ProductRank
FROM SalesData$
GROUP BY Category, ProductName;

--2. Highest-selling product in every category

WITH ProductSales AS
(
    SELECT 
        Category,
        ProductName,
        SUM(NetSales) AS TotalSales
    FROM SalesData$
    GROUP BY Category, ProductName
),
RankedProducts AS
(
    SELECT *,
        RANK() OVER (
            PARTITION BY Category
            ORDER BY TotalSales DESC
        ) AS ProductRank
    FROM ProductSales
)
SELECT 
    Category,
    ProductName,
    TotalSales
FROM RankedProducts
WHERE ProductRank = 1;

--12.TOP

--1. Top 10 orders by NetSales

SELECT TOP 10 *
FROM SalesData$
ORDER BY NetSales DESC;

--2. Top 5 products by total sales

SELECT TOP 5
    ProductName,
    SUM(NetSales) AS TotalSales
FROM SalesData$
GROUP BY ProductName
ORDER BY TotalSales DESC;

--13. DATA CLEANING

--1. Find records where CustomerName is NULL

SELECT *
FROM SalesData$
WHERE CustomerName IS NULL;

--2. Find records where UnitPrice is NULL

SELECT *
FROM SalesData$
WHERE UnitPrice IS NULL;
select *from [dbo].[SalesData$]