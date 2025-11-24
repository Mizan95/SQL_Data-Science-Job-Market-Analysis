/*
❓What are the skills required for the top-paying 500 Data Scientist jobs?
This query uses two Common Table Expressions (CTEs) to first identify the most relevant jobs and then link them to their required skills before aggregating the results.
The main query counts the frequency of each skill among the top 500 highest-paying jobs.
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

-- Main Query: Aggregates skills for the jobs identified in the top_data_scientist_jobs CTE, ranks them by frequency, and orders the result.
-- NULL value are also removed from the result
SELECT
    ROW_NUMBER() OVER (ORDER BY COUNT(top_data_scientist_jobs.job_id) DESC) AS ranking,
    skills_job_table.skill_name AS skill_name,
    COUNT(top_data_scientist_jobs.job_id) AS number_of_jobs
FROM
    top_data_scientist_jobs
LEFT OUTER JOIN skills_job_table ON top_data_scientist_jobs.job_id = skills_job_table.job_id
WHERE
    skill_name IS NOT NULL
GROUP BY
    skill_name
ORDER BY
    number_of_jobs DESC;
