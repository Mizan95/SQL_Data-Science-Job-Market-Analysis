/*
5. What are the top 20 optimal skills to learn?
Optimal meaning those skills that are High Demand and High Paying
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

-- Main query: Sums salaries and Counts jobs and then, aggregates these results based on each skill
-- This is facilitated by an Inner Join between both CTEs 
SELECT
    SUM(data_scientist_jobs.salary) AS total_salary,
    COUNT(data_scientist_jobs.job_id) AS number_of_jobs,
    skill_name
FROM
    data_scientist_jobs
INNER JOIN
    skills_job_table ON data_scientist_jobs.job_id = skills_job_table.job_id
GROUP BY
  skill_name
ORDER BY number_of_jobs DESC
LIMIT
    20

/*
Analysis
- Foundational Skills Dominate Market Value: Python, SQL, and R are the core requirements, accounting for the vast majority of jobs and the largest aggregate financial value (Python's total salary is approx $595.3M).

- Specialisation Commands Premium Pay: Skills like Go ($147,466 average) and PyTorch ($145,989 average) offer the highest average salaries, suggesting a premium for specialized knowledge in niche or highly technical areas (e.g., performance, deep learning).

- Low Demand, High Reward: The top-paying skills appear in significantly fewer jobs (e.g., Go with 316 jobs) compared to the essential skills (e.g., Python with 4,312 jobs).

- Cloud/ML Frameworks are Mid-Tier: Cloud and machine learning tools like Spark ($144,399 average) and TensorFlow ($143,440 average) bridge the gap, offering high average salaries while still being required in a substantial number of jobs.

[
  {
    "total_salary": "595267751.56640625",
    "number_of_jobs": "4312",
    "skill_name": "python"
  },
  {
    "total_salary": "436194498.89453125",
    "number_of_jobs": "3151",
    "skill_name": "sql"
  },
  {
    "total_salary": "336021244.51171875",
    "number_of_jobs": "2486",
    "skill_name": "r"
  },
  {
    "total_salary": "168230566.0703125",
    "number_of_jobs": "1278",
    "skill_name": "tableau"
  },
  {
    "total_salary": "151178759.0781250",
    "number_of_jobs": "1230",
    "skill_name": "sas"
  },
  {
    "total_salary": "141083006.3281250",
    "number_of_jobs": "1016",
    "skill_name": "aws"
  },
  {
    "total_salary": "136601278.2421875",
    "number_of_jobs": "946",
    "skill_name": "spark"
  },
  {
    "total_salary": "91944925.3515625",
    "number_of_jobs": "641",
    "skill_name": "tensorflow"
  },
  {
    "total_salary": "82794848.5000000",
    "number_of_jobs": "623",
    "skill_name": "azure"
  },
  {
    "total_salary": "76873608.7890625",
    "number_of_jobs": "617",
    "skill_name": "excel"
  },
  {
    "total_salary": "82130354.4921875",
    "number_of_jobs": "602",
    "skill_name": "hadoop"
  },
  {
    "total_salary": "82337830.5078125",
    "number_of_jobs": "564",
    "skill_name": "pytorch"
  },
  {
    "total_salary": "72800375.4218750",
    "number_of_jobs": "557",
    "skill_name": "java"
  },
  {
    "total_salary": "57996954.6718750",
    "number_of_jobs": "489",
    "skill_name": "power bi"
  },
  {
    "total_salary": "66507256.781250",
    "number_of_jobs": "481",
    "skill_name": "pandas"
  },
  {
    "total_salary": "55576609.140625",
    "number_of_jobs": "392",
    "skill_name": "scikit-learn"
  },
  {
    "total_salary": "55266509.968750",
    "number_of_jobs": "381",
    "skill_name": "scala"
  },
  {
    "total_salary": "46352107.5625000",
    "number_of_jobs": "376",
    "skill_name": "git"
  },
  {
    "total_salary": "46348237.21875",
    "number_of_jobs": "339",
    "skill_name": "numpy"
  },
  {
    "total_salary": "46599158.578125",
    "number_of_jobs": "316",
    "skill_name": "go"
  }
]
*/