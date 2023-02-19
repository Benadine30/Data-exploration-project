---SELECT THE ENTIRE TABLE
SELECT * FROM tech_layoffs$


---SUM OF THE TOTAL LAYOFFS
SELECT SUM(TOTAL_LAYOFFS) 
FROM tech_layoffs$


---WHAT IS THE TOTAL NUMBER OF LAYOFFS?

SELECT COUNT(total_layoffs)
FROM tech_layoffs$


---GET THE COMPANIES THAT HAS ZERO NO OF LAYOFFS INCLUDING THE DATES 

SELECT COMPANY, reported_date FROM tech_layoffs$
WHERE total_layoffs = '0'


---FIND OUT THE TOTAL NUMBER OF COMPANIES THAT LAYED OFF THEIR EMPLOYEES WITHOUT DUPLICATES

SELECT COUNT (DISTINCT COMPANY)
FROM tech_layoffs$


---FIND OUT THE TOP 10 COMPANIES THAT LAYED OFF THEIR EMPLOYEES AND THE TOTAL NO OF LAYOFFS?

SELECT TOP 10  COMPANY, total_layoffs
FROM tech_layoffs$
WHERE total_layoffs >= '100'
ORDER BY total_layoffs DESC


---FIND OUT THE TOP 10 INDUSTRIES THAT LAYED OFF THEIR EMPLOYEES AND THE TOTAL NO OF LAYOFFS?

SELECT TOP 5  industry, total_layoffs
FROM tech_layoffs$
WHERE total_layoffs >= '200'
ORDER BY total_layoffs DESC


---Get the company,total no of layoffs, the heardquarter and the years of the layoff

SELECT company,
       total_layoffs,
       headquarter_location,
	   YEAR(REPORTED_DATE) AS YEAR_OF_LAYOFF
FROM tech_layoffs$


---WHAT YEAR AND COMPANY RECORDED THE HIGHEST NO OF LAYOFF?

SELECT TOP 1 COMPANY, 
           YEAR(REPORTED_DATE) AS YEAR_OF_LAYOFF, 
		   MONTH(REPORTED_DATE) AS MONTH_OF_LAYOFF, 
		   total_layoffs
FROM tech_layoffs$
WHERE total_layoffs >= '1000'
ORDER BY total_layoffs DESC


---WHAT IS THE AVERAGE NUMBER OF LAYOFFS IN WHOLE NUMBER?

SELECT ROUND (AVG(TOTAL_LAYOFFS),0)
AS AVERAGE_LAYOFF
FROM tech_layoffs$


---WHAT IS THE LEAST 10 COMPANIES THAT LAYED OFF THEIR STAFF?

SELECT TOP 10 COMPANY, total_layoffs
FROM tech_layoffs$
WHERE total_layoffs <= '100'
ORDER BY total_layoffs ASC

---------   OR   ----------

 select * 
 from (select top 10 * 
 from tech_layoffs$ order by total_layoffs asc)
 a order by a.total_layoffs;


---Want to know the highest and lowest no of layoffs in the private sector?

select min(total_layoffs) as lowest_no_of_layoff, 
max(total_layoffs) as highest_no_of_layoff
from tech_layoffs$
where status='private'


---Want to know the highest and lowest no of layoffs in the public sector?

select min(total_layoffs) as lowest_no_of_layoff, 
max(total_layoffs) as highest_no_of_layoff
from tech_layoffs$
where status='public'


---Want to know the highest and lowest no of layoffs in the private sector?

select min(total_layoffs) as lowest_no_of_layoff, 
max(total_layoffs) as highest_no_of_layoff
from tech_layoffs$
where status='private'

---Split the date column into year, month and day

SELECT 
    PARSENAME(REPLACE (reported_date, ',','.'),3)
   ,PARSENAME(REPLACE (reported_date, ',','.'),2)
   ,PARSENAME(REPLACE (reported_date, ',','.'),1)
FROM tech_layoffs$

 ------------OR----------

DECLARE @reported_date datetime2 = '2022-01-12 ';
SELECT 
    DATENAME(day, @reported_date) AS DAY,
    DATENAME(weekday, @reported_date) AS WEEKDAY,
    DATENAME(month, @reported_date) AS MONTH,
    DATENAME(year, @reported_date) AS YEAR
	FROM tech_layoffs$


---Standardize the Date Format(yyyy-mm-dd)

select reported_date, CONVERT(Date, reported_date) AS Updated_date
from tech_layoffs$

Update tech_layoffs$
set reported_date = CONVERT(Date, reported_date)

Alter table tech_layoffs$
add Updated_date Date;

Update tech_layoffs$
Set reported_date = CONVERT(Date, reported_date)


