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

/*
Analysis
- Python is the single most valuable skill, leading the market with a total combined salary of approximately $595.3 million across high-paying jobs.

- The foundational trio of Python, SQL ($436.2 million), and R ($336.0 million) collectively account for the vast majority of the data science market's aggregate financial value.

- The high Total Combined Salary for these top skills is driven by a massive volume of job postings, rather than extremely high individual salaries.

- All top skills—Python, SQL, R, Tableau, and SAS—are associated with a consistently high average salary range (mostly between $122,000 and $138,500).

- This ranking highlights the essential skills required for the broadest and most lucrative segment of the data science job market in 2023.

[
  {
    "total_salary": "595267752",
    "avg_salary": "138049",
    "skill_name": "python"
  },
  {
    "total_salary": "436194499",
    "avg_salary": "138430",
    "skill_name": "sql"
  },
  {
    "total_salary": "336021245",
    "avg_salary": "135165",
    "skill_name": "r"
  },
  {
    "total_salary": "168230566",
    "avg_salary": "131636",
    "skill_name": "tableau"
  },
  {
    "total_salary": "151178759",
    "avg_salary": "122910",
    "skill_name": "sas"
  },
  {
    "total_salary": "141083006",
    "avg_salary": "138861",
    "skill_name": "aws"
  },
  {
    "total_salary": "136601278",
    "avg_salary": "144399",
    "skill_name": "spark"
  },
  {
    "total_salary": "91944925",
    "avg_salary": "143440",
    "skill_name": "tensorflow"
  },
  {
    "total_salary": "82794849",
    "avg_salary": "132897",
    "skill_name": "azure"
  },
  {
    "total_salary": "82337831",
    "avg_salary": "145989",
    "skill_name": "pytorch"
  },
  {
    "total_salary": "82130354",
    "avg_salary": "136429",
    "skill_name": "hadoop"
  },
  {
    "total_salary": "76873609",
    "avg_salary": "124593",
    "skill_name": "excel"
  },
  {
    "total_salary": "72800375",
    "avg_salary": "130701",
    "skill_name": "java"
  },
  {
    "total_salary": "66507257",
    "avg_salary": "138269",
    "skill_name": "pandas"
  },
  {
    "total_salary": "57996955",
    "avg_salary": "118603",
    "skill_name": "power bi"
  },
  {
    "total_salary": "55576609",
    "avg_salary": "141777",
    "skill_name": "scikit-learn"
  },
  {
    "total_salary": "55266510",
    "avg_salary": "145056",
    "skill_name": "scala"
  },
  {
    "total_salary": "46599159",
    "avg_salary": "147466",
    "skill_name": "go"
  },
  {
    "total_salary": "46352108",
    "avg_salary": "123277",
    "skill_name": "git"
  },
  {
    "total_salary": "46348237",
    "avg_salary": "136720",
    "skill_name": "numpy"
  }
]
*/