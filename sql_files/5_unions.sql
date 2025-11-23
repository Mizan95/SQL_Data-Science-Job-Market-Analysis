WITH skills_table AS (
    SELECT
        skills_job_dim.job_id AS job_ident,
        skills_job_dim.skill_id AS skill_ident,
        skills_dim.skills AS skill_name,
        skills_dim.type AS skill_type
    FROM
        skills_job_dim
    LEFT OUTER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
),

jobs_Q1 AS (
    SELECT
        job_id,
        job_title_short,
        salary_year_avg
    FROM
        january_jobs

    UNION ALL

    SELECT 
        job_id,
        job_title_short,
        salary_year_avg
    FROM
        february_jobs

    UNION ALL

    SELECT 
        job_id,
        job_title_short,
        salary_year_avg
    FROM
        march_jobs
)

SELECT
    jobs_Q1.job_id,
    jobs_Q1.job_title_short,
    jobs_Q1.salary_year_avg
    skills_table.skill_ident,
    skills_table.skill_name,
    skills_table.skill_type
FROM
    jobs_Q1
LEFT OUTER JOIN skills_table ON jobs_Q1.job_id = skills_table.job_ident
WHERE
    jobs_Q1.salary_year_avg > 70000 AND
    jobs_Q1.job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC




