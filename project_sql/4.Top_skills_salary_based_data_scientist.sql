/*
4. What are the top skills based on salary for my role?
This approach also uses two 'daisy-chained' CTEs as a clean maintainable solution. And thereafter a main query containing an inner join of both CTEs.
Comments are present to explain the logic.
*/

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

-- Main query: Sums and averages salaries and aggregates these stats based on each skill
-- This is facilitated by an Inner Join between both CTEs 
    SUM(data_scientist_jobs.salary) AS total_salary,
    AVG(data_scientist_jobs.salary) AS avg_salary,
    skill_name
FROM
    data_scientist_jobs
INNER JOIN
    skills_job_table ON data_scientist_jobs.job_id = skills_job_table.job_id
GROUP BY
  skill_name
ORDER BY total_salary DESC

