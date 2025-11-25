/*
❓What are the top 10 skills required for the top-paying 500 Data Scientist jobs?
This query uses two Common Table Expressions (CTEs) to first identify the top 500 highest paying Data Scientist roles and then map them to their required skills before aggregating the results.
Both CTEs are 'daisy chained' together.
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

/*
Analysis
Python is the most demanded skill, appearing in 358 of the job postings.
SQL is the second most critical skill, mentioned in 279 job listings.
R rounds out the top three languages, required by 189 jobs.
Spark leads the specialized tools, demanded by 101 job postings for Big Data processing.
Tableau and AWS are close, with 84 and 77 mentions, highlighting visualization and cloud infrastructure needs.

[
  {
    "ranking": "1",
    "skill_name": "python",
    "number_of_jobs": "358"
  },
  {
    "ranking": "2",
    "skill_name": "sql",
    "number_of_jobs": "279"
  },
  {
    "ranking": "3",
    "skill_name": "r",
    "number_of_jobs": "189"
  },
  {
    "ranking": "4",
    "skill_name": "spark",
    "number_of_jobs": "101"
  },
  {
    "ranking": "5",
    "skill_name": "tableau",
    "number_of_jobs": "84"
  },
  {
    "ranking": "6",
    "skill_name": "aws",
    "number_of_jobs": "77"
  },
  {
    "ranking": "7",
    "skill_name": "tensorflow",
    "number_of_jobs": "64"
  },
  {
    "ranking": "8",
    "skill_name": "pytorch",
    "number_of_jobs": "57"
  },
  {
    "ranking": "9",
    "skill_name": "scala",
    "number_of_jobs": "49"
  },
  {
    "ranking": "10",
    "skill_name": "hadoop",
    "number_of_jobs": "41"
  },
  {
    "ranking": "11",
    "skill_name": "scikit-learn",
    "number_of_jobs": "40"
  },
  {
    "ranking": "12",
    "skill_name": "sas",
    "number_of_jobs": "38"
  },
  {
    "ranking": "13",
    "skill_name": "pandas",
    "number_of_jobs": "35"
  },
  {
    "ranking": "14",
    "skill_name": "snowflake",
    "number_of_jobs": "34"
  },
  {
    "ranking": "15",
    "skill_name": "go",
    "number_of_jobs": "34"
  },
  {
    "ranking": "16",
    "skill_name": "excel",
    "number_of_jobs": "33"
  },
  {
    "ranking": "17",
    "skill_name": "azure",
    "number_of_jobs": "33"
  },
  {
    "ranking": "18",
    "skill_name": "c",
    "number_of_jobs": "27"
  },
  {
    "ranking": "19",
    "skill_name": "numpy",
    "number_of_jobs": "27"
  },
  {
    "ranking": "20",
    "skill_name": "java",
    "number_of_jobs": "25"
  }
]
*/