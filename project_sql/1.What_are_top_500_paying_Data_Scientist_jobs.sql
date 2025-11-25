/* ❓What are the 500 top paying Data Scientist jobs in the UK and which companies are hiring for these roles?
I will return the above analysis with two approaches in our SQL queries. After both approaches is my conclusion describing which
approach is best practice.
The first approach is by using a CTE.
And the second is without.
Comments are visible to explain the logic.
*/


/*
*-*-*-*- Below is the first approach using a CTE *-*-*-*-
*/

/*
This query is split up into two blocks. The first block is the CTE. Whilst the second block is the main query.
*/

-- CTE returning company name and ID from company Dimension table (company_dim)
WITH company_list AS (
    SELECT
    company_id,
    name
    FROM
    company_dim
)

/* Main query which: 
1. Merges the Fact table (job_postings_fact) with CTE (company_list) using inner join. The primary key of the CTE is company_id. This matches with the foreign key of
job_postings_fact which is also company_id.
2. Filters out NULL values and selecting only Data Scientist jobs
3. Returns top 500 Data Scientist jobs along with company names and yearly salaries
*/

SELECT
    job_title_short AS job_title,
    company_list.name AS company_name,
    job_country AS country,
    salary_year_avg AS salary
FROM
    job_postings_fact AS job_postings
-- Inner join with CTE to retrieve company name
INNER JOIN company_list ON job_postings.company_id = company_list.company_id
-- Filter out NULL value in salary and only choose Data Scientist jobs
WHERE
    salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Scientist' AND
    job_location = 'United Kingdom'
-- Show results in descending order based on salaries
ORDER BY
    salary DESC
-- Limit result set to 500
LIMIT
    500;

/*
*-*-*-*- Below is the second approach without a CTE *-*-*-*-
*/

/*
1. This query consists of a single block and merges the Fact table (job_postings_fact) with the company Dimension table (company_dim) directly
without any intermediary CTE
2. The merge is an inner join with the primary key of company_dim being company_id. This matching with the foreign key of
job_postings_fact which is also company_id.
3. The query then selects the appropriate columns from both tables whilst filtering out NULL values selecting only Data Scientist jobs
4. This returns the top 500 Data Scientist jobs along with company names and yearly salaries
*/
SELECT 
    job_title_short AS job_title,
    company_dim.name AS company_name,
    job_country AS country,
    job_postings.salary_year_avg AS salary
FROM 
    job_postings_fact AS job_postings
-- Inner join with company_dim table to retrieve company name
INNER JOIN company_dim ON job_postings.company_id = company_dim.company_id
WHERE 
-- Filter out NULL value in salary and only choose Data Scientist jobs
    job_postings.salary_year_avg IS NOT NULL AND
    job_postings.job_title_short = 'Data Scientist' AND
    job_location = 'United Kingdom'
-- Show results in descending order based on salaries
ORDER BY
    salary DESC
-- Limit result set to 500
LIMIT
    500


