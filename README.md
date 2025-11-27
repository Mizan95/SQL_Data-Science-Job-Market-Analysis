# Introduction
📈This is a data analysis project of the global data job market for the year 2023. It focuses on the role of Data Scientist. It explores top paying Data Scientist jobs, in-demand skills and where high demand meets a high salary.

🔎SQL queries can be found here: [project_sql folder](/project_sql/)

# Tools I used
For this project, I harnessed the power of the following tools:

- **SQL:** This allowed me to query the database and unearth the insights
- **PosgreSQL:** The database management system ideal for handling the data
- **Visual Studio Code:** My ideal code editor for executing SQL queries
- **Git and GitHub:** An essential for version control, and sharing my SQL queries and overall data analysis.

# My Approach
My approach to this analysis was to implement a scalable and maintainable code base from the beginning. In other words, reduce the amount of redundant lines of code and enable efficient querying.
The way I achieved this, was that I generated reusable modules of CTEs. These CTEs were the foundation of the main queries found within each SQL file (to the exception of file 1 where there was no requirement of a CTE).

These CTE modules handled joins between database tables. So, there was no need in my main queries to perform any of these kinds of joins.
This reduced the possibility of reference errors within my code base.

I used aggregation functions for key calculations. And to make the data more clear, I also used the ROUND function to remove any decimal values in salary data.


# The Analysis
Each query was aimed at investigating different aspects of the Data Scientist job market with a main focus on skills and salary.

### Top 100 paying Data Scientist jobs and which companies are hiring for them
To identify top 100 paying Data Scientist jobs, I filtered and ordered the data based on overage yearly salary. I then merged the fact table with a dimension table to show which companies were hiring for these roles.

```sql
SELECT 
    job_title_short AS job_title,
    company_dim.name AS company_name,
    job_country AS country,
    ROUND((job_postings.salary_year_avg), 0) AS salary
FROM 
    job_postings_fact AS job_postings
-- Inner join with company_dim table to retrieve company name
INNER JOIN company_dim ON job_postings.company_id = company_dim.company_id
WHERE 
-- Filter out NULL value in salary and only choose Data Scientist jobs
    job_postings.salary_year_avg IS NOT NULL AND
    job_postings.job_title_short = 'Data Scientist'
-- Show results in descending order based on salaries
ORDER BY
    salary DESC
-- Limit result set to 100
LIMIT
    100

```

Breakdown of top Data Scientist jobs of 2023

- The maximum salary in this set is an outlier at $960,000, offered by East River Electric Power Cooperative, Inc.
- The average salary for these elite roles is approximately $339,611, reflecting the highest compensation tier in data science.
- The minimum salary in the top 100 is still exceptionally high at $274,675.00, setting a very high floor for the best-paid positions.
- The median salary of $336,110 is very close to the average, indicating that most of the top 100 jobs offer uniformly high pay, with few major dips.
- The vast majority of these highest-paying roles, 87 out of 100, are located in the United States demonstrating its dominance in the market for elite data science compensation.

![Top Paying Data Scientist Roles](assets/1.top_DS_roles.png)
*Bar chart visualising the salary for the top 10 salaries for Data Scientist roles and the companies hiring for them.*

### Top 20 skills required for the top-paying 500 Data Scientist jobs
To identify top 10 skills required for the top-paying 500 Data Scientist jobs, I generated two CTEs as the foundation of my query. Then I merged both CTEs with an INNER JOIN and filtered out NULL values.

```sql
-- CTE 1: Maps Job IDs with Skill Dimension table
WITH skills_job_table AS (
    SELECT
        skills_to_job.job_id,
        skills_to_job.skill_id,
        skills_dim.skills AS skill_name
    FROM
        skills_job_dim AS skills_to_job
    LEFT OUTER JOIN skills_dim ON skills_to_job.skill_id = skills_dim.skill_id
),

-- CTE 2: Selects the top 500 job IDs for 'Data Scientist' roles based  on the highest yearly salary.
top_data_scientist_jobs AS (
    SELECT
        job_id,
        job_title_short AS job_title,
        salary_year_avg AS salary,
        job_country
    FROM job_postings_fact
    WHERE
        job_title_short = 'Data Scientist' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT
        500
)

-- Main Query: Aggregates skills for the jobs identified in the top_data_scientist_jobs CTE and orders the result.
-- Additionally, I have ranked them by number of jobs
-- NULL value are also removed from the result
SELECT
    ROW_NUMBER() OVER (ORDER BY COUNT(top_data_scientist_jobs.job_id) DESC) AS ranking,
    skills_job_table.skill_name AS skill_name,
    COUNT(top_data_scientist_jobs.job_id) AS number_of_jobs
FROM
    top_data_scientist_jobs
INNER JOIN skills_job_table ON top_data_scientist_jobs.job_id = skills_job_table.job_id
WHERE
    skill_name IS NOT NULL
GROUP BY
    skill_name
ORDER BY
    number_of_jobs DESC
LIMIT
    20;
```
Breakdown of top 20 skills required for top 500 Data Scientist jobs in 2023

- Python is the most demanded skill, appearing in 357 of the job postings.
- SQL is the second most critical skill, mentioned in 278 job listings.
- R rounds out the top three languages, required by 188 jobs.
- Spark leads the specialized tools, demanded by 103 job postings for Big Data processing.
- Tableau and AWS are close, with 83 and 80 mentions, highlighting visualisation and cloud infrastructure needs.
- Note for conciseness the chart below shows top 10 skills.

![top 10 skills required for top 500 data scientist jobs](assets/2.top_10_skills_required.png)

*Bar chart visualising the top 20 skills required for top 500 Data Scientist jobs in 2023*

### Top 20 skills for Data Scientist roles overall
To identify top 20 skills for Data Scientist roles overall, I also used two CTEs as the foundation of my query. Then, I aggregated the data which was facilitated by an INNER JOIN of both CTEs.

```sql
-- CTE 1: Maps Job IDs with Skill Dimension table
WITH skills_job_table AS (
    SELECT
        skills_to_job.job_id,
        skills_to_job.skill_id,
        skills_dim.skills AS skill_name
    FROM
        skills_job_dim AS skills_to_job
    LEFT OUTER JOIN skills_dim ON skills_to_job.skill_id = skills_dim.skill_id
),

-- CTE 2: Selects all job IDs for 'Data Scientist' roles based across entire data set
data_scientist_jobs AS (
    SELECT
    job_id,
    job_title_short AS job_title,
    salary_year_avg AS salary,
    job_country
    FROM job_postings_fact
    WHERE
        job_title_short = 'Data Scientist'
)

-- Main query: Counts number of Job IDs and aggregates this based on each skill
-- This is facilitated by an Inner Join between both CTEs
SELECT
    COUNT(data_scientist_jobs.job_id) AS number_of_jobs,
    skill_name
FROM
    data_scientist_jobs
INNER JOIN skills_job_table ON data_scientist_jobs.job_id = skills_job_table.job_id
GROUP BY
    skill_name
ORDER BY
    number_of_jobs DESC
LIMIT
    20
```
Analysis of top 20 skills for all Data Scientist jobs globally in 2023
- Python is the most dominant skill, required for 114,016 of the data scientist jobs.
- SQL remains critical, following closely with 79,174 job mentions.
- R is the third most requested language, demanded in 59,754 job listings.
- The top five is completed by the statistical language SAS (29,642) and the visualization tool Tableau (29,513).
- The core programming and database skills (Python, SQL, R) are requested in significantly more jobs than all other skills combined.
- Note for conciseness the chart below shows top 10 skills.

 
![top 10 skills for all Data Scientist jobs globally in 2023](assets/3.top_10_skills_ALL_JOBS.png)
*Bar chart visualising the top 10 skills required for all Data Scientist jobs in 2023*

### Top 20 skills for Data Scientist roles based on combined and average salaries
To identify top 20 skills based on salary for Data Scientist roles, I also used two CTEs as the foundation of my query. Then, I aggregated the data which was facilitated by an INNER JOIN of both CTEs. 

```sql
-- CTE 1: Maps Job IDs with Skill Dimension table
WITH skills_job_table AS (
    SELECT
        skills_to_job.job_id,
        skills_to_job.skill_id,
        skills_dim.skills AS skill_name
    FROM
        skills_job_dim AS skills_to_job
    LEFT OUTER JOIN skills_dim ON skills_to_job.skill_id = skills_dim.skill_id
),

-- CTE 2: Selects all job IDs for 'Data Scientist' roles based across entire data set
data_scientist_jobs AS (
    SELECT
    job_id,
    job_title_short AS job_title,
    salary_year_avg AS salary,
    job_country
    FROM job_postings_fact
    WHERE
        job_title_short = 'Data Scientist' AND
        salary_year_avg IS NOT NULL
)

-- Main query: Sums and averages salaries and aggregates these results based on each skill
-- This is facilitated by an Inner Join between both CTEs 
SELECT
    ROUND(SUM(data_scientist_jobs.salary), 0) AS total_salary,
    ROUND(AVG(data_scientist_jobs.salary), 0) AS avg_salary,
    skill_name
FROM
    data_scientist_jobs
INNER JOIN
    skills_job_table ON data_scientist_jobs.job_id = skills_job_table.job_id
GROUP BY
  skill_name
ORDER BY total_salary DESC
LIMIT
    20
```

Analysis of top 20 skills for all Data Scientist jobs and their combined salaries and their average salaries

- Python is the single most valuable skill, leading the market with a total combined salary of approximately $595.3 million across high-paying jobs.

- The foundational trio of Python, SQL ($436.2 million), and R ($336.0 million) collectively account for the vast majority of the data science market's aggregate financial value.

- The high Total Combined Salary for these top skills is driven by a massive volume of job postings, rather than extremely high individual salaries.

- All top skills—Python, SQL, R, Tableau, and SAS—are associated with a consistently high average salary range (mostly between $122,000 and $138,500).

- This ranking highlights the essential skills required for the broadest and most lucrative segment of the data science job market in 2023.

- Note for conciseness the chart below shows top 10 skills.

![Analysis of top 20 skills for all Data Scientist jobs and their combined salaries and their average salaries](assets/4.top_10_skills_combined_salaries.png)
*Bar chart visualising the top 10 skills and their combined total salaries in the job market*


### Top 20 Optimal skills for Data Scientist roles overall
To identify optimal skills to learn for Data Scientist roles overall, I once again used two CTEs as the foundation of my query. I then aggregated the data which was facilitated by an INNER JOIN of both CTEs.

```sql
-- CTE 1: Maps Job IDs with Skill Dimension table
WITH skills_job_table AS (
    SELECT
        skills_to_job.job_id,
        skills_to_job.skill_id,
        skills_dim.skills AS skill_name
    FROM
        skills_job_dim AS skills_to_job
    LEFT OUTER JOIN skills_dim ON skills_to_job.skill_id = skills_dim.skill_id
),

-- CTE 2: Selects all job IDs for 'Data Scientist' roles based across entire data set
data_scientist_jobs AS (
    SELECT
    job_id,
    job_title_short AS job_title,
    salary_year_avg AS salary,
    job_country
    FROM job_postings_fact
    WHERE
        job_title_short = 'Data Scientist' AND
        salary_year_avg IS NOT NULL
)

-- Main query: Sums salaries and Counts jobs and then, aggregates these results based on each skill
-- This is facilitated by an Inner Join between both CTEs 
SELECT
    ROUND(SUM(data_scientist_jobs.salary), 0) AS total_salary,
    COUNT(data_scientist_jobs.job_id) AS number_of_jobs,
    skill_name
FROM
    data_scientist_jobs
INNER JOIN
    skills_job_table ON data_scientist_jobs.job_id = skills_job_table.job_id
GROUP BY
  skill_name
ORDER BY 
  number_of_jobs DESC
LIMIT
    20
```
Analysis of top 20 skills for all Data Scientist jobs and their combined salaries and their average salaries

- Python is the clear market leader, with the highest total combined salary (nearly $595 Million) and the highest number of job postings (4,312).
- The overall trend shows a strong positive correlation: as the total number of job postings (green line) decreases across the top 10 skills, the total combined salary (orange bars) generally decreases as well.
- The foundational languages, Python, SQL, and R, account for the vast majority of both the total salary and the job count in the top 10.
- The combined total salary for a skill like Tableau, ($168 Million) is significantly higher than deep learning frameworks like TensorFlow ($92 Million) and PyTorch ($82 Million), primarily due to the higher volume of job postings for Tableau.

- Note for conciseness the table below shows top 10 skills.

| Combined salaries     | Number of jobs | Skill |
|------------------|----------------|------------|
| $595,267,752     | 4312           | python     |
| $436,194,499     | 3151           | sql        |
| $336,021,245     | 2486           | r          |
| $168,230,566     | 1278           | tableau    |
| $151,178,759     | 1230           | sas        |
| $141,083,006     | 1016           | aws        |
| $136,601,278     | 946            | spark      |
| $91,944,925      | 641            | tensorflow |
| $82,794,849      | 623            | azure      |
| $82,337,831      | 564            | pytorch    |

*Table visualising the top 10 Optimal skills with their combined total salaries in the job market, and their total job postings*
# What I learned
In this project, I learned and upskilled on key SQL techniques and best practises. 

- **Crafting complex yet simple queries**: I crafted complex queries in terms of their functionality. Yet, they were easy in their syntax and I keept the code concise and easy to read. This was especially so in my CTE component approach where I resused components in my project as a scalable and maintenanble solution.
- **Data aggregation**: I became very confortable with aggregating data with SQL code and expanding the fundamental logic by combining aggregations across CTEs.
- **Problem solving capabilities**: I increased my problem-solving skills especially so when I had to plan the most appropriate approach when turning my initial questions into insightful SQL queries. 


# Conclusions
### Insights
1. **Elite data science roles command exceptionally high pay**, with top-100 salaries ranging from $274k to nearly $1M, and a stable median around $336k—showing the uniform strength of compensation at the top tier.

2. **The U.S. overwhelmingly dominates high-end data science hiring**, accounting for 87% of the top-100 highest-paying jobs globally.

3. **Python, SQL, and R form the core skill set of the profession**, appearing in the majority of high-paying postings and representing the largest share of total combined salary value across all skills.

4. **Market demand strongly influences financial value**, as the highest total salary pools (e.g., Python: $595M) are driven by high job volumes rather than extreme individual salaries.

5. **Specialized tools like Spark, Tableau, AWS, and SAS remain highly valuable**, with Tableau notably generating more total salary than deep-learning frameworks due to broader industry adoption.

### Closing Thoughts
By working and completing this SQL project, my SQL skills were greatly enhanced. 
This also provided me with valuable insights into the job market of 2023, which was the year that AI tools were starting to become mass adopted by the world.
Data Scientists were becoming in high demand and the exceptionally high pay they were being offered for the most elite roles showcase this.
Skills such as Python and SQL are at the core of a Data Scientist's toolkit. This is indicated by their clear high demand and high salary.
Aspiring Data Scientists can better position themselves by focusing on these high-demand and high-salary skills.



