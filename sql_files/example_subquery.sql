/*
    - Find the count of remote job postings per skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name and count of postings required 
    for the skill
*/



-- my solution
SELECT
    skills_job_dim.skill_id AS skill_number,
    skills_dim.skills AS skill_name,
    COUNT(skills_job_dim.job_id) AS job_count
FROM 
    skills_job_dim
LEFT OUTER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    skills_job_dim.job_id IN (
    SELECT job_postings_fact.job_id
    FROM job_postings_fact
    WHERE 
        job_location LIKE 'Anywhere' AND
        job_title_short = 'Data Analyst'
)
GROUP BY
    skill_number,
    skill_name
ORDER BY
    job_count DESC
LIMIT
5



SELECT DISTINCT
    skills_job_dim.skill_id AS skill_number,
    skills_dim.skills AS name
FROM
skills_job_dim
LEFT OUTER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    skill_number