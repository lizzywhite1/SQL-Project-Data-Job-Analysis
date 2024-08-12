/*
Question: Find the average salary for skills required in ML jobs.
- Ensure there are at least 50 job postings for each skill.
- Why? This helps job seekers identify the skills that are most worth their time 
to learn, based on average salary.
*/

SELECT
    skills.skills,
    -- Rounded average salary for each skill
    ROUND(AVG(salary_year_avg), 0) AS avg_salary,
    -- Number of job postings mentioning each skill
    COUNT(job_postings.job_id) AS job_count
FROM job_postings_fact AS job_postings
INNER JOIN skills_job_dim AS skills_to_job ON job_postings.job_id = skills_to_job.job_id
INNER JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
WHERE
    (job_title ILIKE '%Machine Learning%' 
    OR job_title ILIKE '% ML %') 
    AND salary_year_avg IS NOT NULL
GROUP BY skills.skills
-- Ensure at least 50 job postings per skill for reliable data
HAVING COUNT(job_postings.job_id) >= 50 
ORDER BY avg_salary DESC
LIMIT 10