/*3. What are the top 20 skills for data scientist roles overall
This approach also uses two 'daisy-chained' CTEs as a clean maintainable solution. And thereafter a main query to do an inner join of both CTEs.
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

/*
Analysis
- Python is the most dominant skill, required for 114,016 of the data scientist jobs.

- SQL remains critical, following closely with 79,174 job mentions.

- R is the third most requested language, demanded in 59,754 job listings.

- The top five is completed by the statistical language SAS (29,642) and the visualization tool Tableau (29,513).

- The core programming and database skills (Python, SQL, R) are requested in significantly more jobs than all other skills combined.
 
[
  {
    "number_of_jobs": "114016",
    "skill_name": "python"
  },
  {
    "number_of_jobs": "79174",
    "skill_name": "sql"
  },
  {
    "number_of_jobs": "59754",
    "skill_name": "r"
  },
  {
    "number_of_jobs": "29642",
    "skill_name": "sas"
  },
  {
    "number_of_jobs": "29513",
    "skill_name": "tableau"
  },
  {
    "number_of_jobs": "26311",
    "skill_name": "aws"
  },
  {
    "number_of_jobs": "24353",
    "skill_name": "spark"
  },
  {
    "number_of_jobs": "21698",
    "skill_name": "azure"
  },
  {
    "number_of_jobs": "19193",
    "skill_name": "tensorflow"
  },
  {
    "number_of_jobs": "17601",
    "skill_name": "excel"
  },
  {
    "number_of_jobs": "16314",
    "skill_name": "java"
  },
  {
    "number_of_jobs": "15744",
    "skill_name": "power bi"
  },
  {
    "number_of_jobs": "15575",
    "skill_name": "hadoop"
  },
  {
    "number_of_jobs": "15075",
    "skill_name": "pytorch"
  },
  {
    "number_of_jobs": "14866",
    "skill_name": "pandas"
  },
  {
    "number_of_jobs": "12285",
    "skill_name": "git"
  },
  {
    "number_of_jobs": "11636",
    "skill_name": "scikit-learn"
  },
  {
    "number_of_jobs": "10818",
    "skill_name": "numpy"
  },
  {
    "number_of_jobs": "10416",
    "skill_name": "scala"
  },
  {
    "number_of_jobs": "8736",
    "skill_name": "gcp"
  }
]
*/
