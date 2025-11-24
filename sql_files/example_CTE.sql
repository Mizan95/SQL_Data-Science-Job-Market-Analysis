/*
- calculate total job postings each company has
- classify each company as small, medium or large based on
number of job postings they have
< 10 job postings = small
10 - 50 job postings = medium
> 50 job postings = large
*/

WITH remote_job_skills AS (
    SELECT
    skills_to_job.skill_id,
    COUNT(*) AS job_count,
    SUM(salary_year_avg) AS total_skill_salary
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE 
        job_postings.job_work_from_home = True 
        AND
        job_postings.job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)

SELECT
    skills.skill_id,
    skills.skills AS skill_name,
    job_count,
    total_skill_salary
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
    job_count DESC
LIMIT 5

