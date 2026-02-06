# CREATING A COPY OF THE ORIGINAL TABLE
## creating a copy of the table before making any changes in order to keep the original data intact##
use world_layoffs;
create table layoffs_copy
like layoffs;
insert layoffs_copy
select *
from layoffs;
select count(*)
from layoffs_copy;

# DATA CLEANING

with sub as (select *, row_number() over ( partition by company , 
location ,
industry ,
total_laid_off ,
percentage_laid_off , 
date ,
stage ,
country ,
funds_raised_millions) as row_num
from layoffs_copy)
select *
from sub 
where row_num > 1;

create table layoffs_clean
like layoffs_copy;

insert layoffs_clean
select company , 
location ,
industry ,
total_laid_off ,
percentage_laid_off , 
date ,
stage ,
country ,
funds_raised_millions
from (select *, row_number() over ( partition by company , 
location ,
industry ,
total_laid_off ,
percentage_laid_off , 
date ,
stage ,
country ,
funds_raised_millions) as row_num
from layoffs_copy) as sub

where row_num =1;
select count(*)
from layoffs_clean;
drop table layoffs_copy;
rename table layoffs_clean to layoffs_copy;
select *
from layoffs_copy;


select distinct(country)
from layoffs_copy
order by country;
update layoffs_copy
set country = 'united states'
where country = 'united states.';
select distinct (industry)
from layoffs_copy
order by industry;

update layoffs_copy
set industry = 'crypto currency'
where industry = 'cryptocurrency';

update layoffs_copy
set country = trim(country),
	industry = trim(industry),
    company = trim(company);
    select date
    from layoffs_copy
    limit 10;
    
    ALTER TABLE layoffs_copy
ADD COLUMN date_clean DATE;

UPDATE layoffs_copy
SET date_clean = STR_TO_DATE(date, '%m/%d/%Y');

select date, date_clean
from layoffs_copy
limit 10;
alter table layoffs_copy
drop column date;
alter table layoffs_copy
change column date_clean Date date;
select date
from layoffs_copy;

select distinct(percentage_laid_off)
from layoffs_copy
order by percentage_laid_off;
describe layoffs_copy;
ALTER TABLE layoffs_copy
ADD COLUMN percentage_clean FLOAT;

UPDATE layoffs_copy
SET percentage_clean = CAST(percentage_laid_off AS DECIMAL(5,2));

alter table layoffs_copy
drop column percentage_laid_off;

alter table layoffs_copy
change column percentage_clean percentage_laid_off decimal (5,2) ;

## dealing with null values##

select *
from layoffs_copy
where percentage_laid_off is null and total_laid_off is null;

# the reason why i am deleting them is because these rows cannot contribute to layoff analysis##

delete 
from layoffs_copy
where percentage_laid_off is null and total_laid_off is null;

select count(*)
from layoffs_copy;

## YEARLY TREND ANALYSIS

SELECT 
YEAR(date) AS layoff_year,
SUM(total_laid_off) AS total_layoffs
FROM layoffs_copy
GROUP BY YEAR(date)
ORDER BY layoff_year ;

WITH yearly AS (
    SELECT 
        YEAR(date) AS layoff_year,
        SUM(total_laid_off) AS total_layoffs
    FROM layoffs_copy
    GROUP BY YEAR(date)
)

SELECT *,
       ROUND(
           (total_layoffs - LAG(total_layoffs) OVER (ORDER BY layoff_year))
           / LAG(total_layoffs) OVER (ORDER BY layoff_year) * 100, 
       2) AS pct_change
FROM yearly;  ## The data suggests 2022 was a structural correction year following an artificially low layoff period in 2021 
#driven by pandemic-era stimulus and aggressive hiring.#

## INDUSTRY ANALYSIS (2022)
with year_2022 as (select year(date)as layoff_year, industry, sum(total_laid_off) as total_layoffs
from layoffs_copy
group by year(date), industry
order by layoff_year, total_layoffs desc)
select *
from year_2022
where layoff_year = 2022
order by total_layoffs desc;
## the 2022 spike was not random
# a broad microeconomic correction triggered by inflation, interest rate hikes, and post-pandemic demand normalization.
# it wasn't just tech layoffs but it was systematic.

# COMPANY ANALYSIS
SELECT 
company,
SUM(total_laid_off) AS total_layoffs
FROM layoffs_copy
WHERE YEAR(date) = 2022
GROUP BY company
ORDER BY total_layoffs DESC
LIMIT 10;
## The 2022 layoff spike was heavily driven by technology companies.
## Even though Retail was top industry overall, the biggest individual layoffs came from tech giants.

SELECT 
SUM(total_laid_off) AS total_2022_layoffs
FROM layoffs_copy
WHERE YEAR(date) = 2022;

# While Meta’s layoffs of 11,000 employees made headlines in 2022, it represented only 6.85% of global layoffs recorded in our dataset.
# This indicates that the 2022 workforce reduction was widespread across industries
# and countries, driven by macroeconomic and market-wide factors rather than a few headline companies.

# FUNDING VS LAYOFF CORRELATION
with sub as (select company,sum(total_laid_off) as total_layoff ,sum(funds_raised_millions) as funds_raised
from layoffs_copy
group by company)

select ROUND(
    (AVG(funds_raised * total_layoff) 
     - AVG(funds_raised) * AVG(total_layoff)) /
    (STDDEV(funds_raised) * STDDEV(total_layoff)),
2
) AS correlation
from sub
where funds_raised is not null and total_layoff is not null;
## The correlation analysis revealed a weak positive relationship (r = 0.11) between funding raised and total layoffs.
## This suggests that capital availability alone did not significantly influence workforce reduction decisions during the period studied.

# STAGE ANALYSIS
select stage, sum(total_laid_off) as total_layoff
from layoffs_copy
group by stage
order by total_layoff desc;
## The layoffs were concentrated among Post-IPO firms
## This indicates that mature companies and not early stage startups were the most affected during the economic downturn.

select year(date) as Year,stage, sum(total_laid_off) as total_layoff
from layoffs_copy
where year(date)= 2022
group by year(date),stage
order by total_layoff desc;
## In conclussion the layoffs reflect strategic cost restructuring by mature firms rather than widespread business failure

SELECT VERSION();
