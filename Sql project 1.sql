-- Sql Retail Sales Analysis
create Table retail_sales 
			(
				transactions_id	int Primary Key,
                sale_date	Date,
                sale_time	time,
                customer_id	int,
                gender 	varchar(15),
                age	INT,
                category varchar(15),
                quantity	Int,
                price_per_unit float,	
                cogs	float,
                total_sale float);

select *  from retail_sales           
Where 
	transactions_id is null
	or
    sale_date is null
    or
    sale_time is null
    or 
    gender is null
    or 
    cogs is null 
    or 
    price_per_unit is null
    or 
    total_sale is null 
    or 
    quantity is null
    or 
    category is null 
    or 
    customer_id is null 
    or 
    age is null;
    
    -- Data exploration 
   -- How many unique customers we have ?
   Select Distinct customer_id as totak_sales from retail_sales;
   
   -- how many unique categories we have ?
   Select Distinct category from retail_sales;
   
   -- Data Analysis & business analyze
   -- 1) Write a sql query to retrieve all colums for sales made on 2022-11-05
   
   select * from retail_sales
   where sale_date = '2022-11-05';
   
   -- 2)write a sql query to retrieve all transactions where the category is clothing and the quantity sold more than 100 in the month of nov 2022
   
select *
   from retail_sales
   where category = 'clothing'
   and 
   DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
   and 
   quantiy >= 4
   
   -- 3) Write a sql query to calculate totoal sales for each category 
   
 Select category 
		sum(total_sale) as net_sale, 
		count(*) as total_orders
	From retail_sales
    group by category ;
    
    -- 4) Write a sql query to find the average age of customers who purchased items from the beauty category
    
    Select Round (Avg (Age), 2) as Avg_age
    from retail_sales
    where category = 'beauty'
    
    -- 5) Write a sql query to find all the transactions where the total sales is greater than 1000. 
    
    Select * from retail_sales
    where total_sale > 1000
    
    --6) write a sql query to find the total number of transactions made by each gender in each category.
    
    select 
		category,
        gender,
        count(*) as total_trans
	from retail_sales
    group by gender, category
		
   -- 7)   Write a sql query to calculate the average sale for each month. find out best selling month in each year
   
   select 
	year,
    month,
    avg_sale,
    RANK() OVER (ORDER BY avg_sale DESC) AS sales_rank
	From ( Select	
		year(sale_date) as year,
        month(sale_date)as month,
        Round (Avg(total_sale), 2) as Avg_sale
	from retail_sales
    GROUP BY 
    YEAR(sale_date),
    MONTH(sale_date) ) as monthly_avg;
    
    -- 8) Write a sql query to find the top 5 customers based on highest total sale

    select 
		customer_id,
        sum(total_sale) as total_sales
    from retail_sales
   group by customer_id
   order by total_sales desc
   limit 5;
   
   -- 9) write a sql query to find the number of unnique customers who purchased items from each category
   
   select 
		category,
		count(distinct customer_id) as cnt_unique_cs
    from retail_sales
   group by category
   
   -- 10) write a sql query to create each shift and numhber of orders ( example morning <=12, Afternoon between 12 & 17, evening >17 )
   
   With hourly_sale
   as
   (
   select *,
   case when extract(hour from sale_time) <12 then 'Morning'
        when extract(hour from sale_time) between 12 and 17 then 'afternoon'
        else 'Evening'
	End as shift
    from retail_sales )
    select shift,
		count(*) as total_orders
        from hourly_sale
        group by shift
        
        -- End of project