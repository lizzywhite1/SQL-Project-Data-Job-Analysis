/* 
Question: What are the top 10 skills required for the highest-paying ML jobs?
- Focusing on the top 50 highest-paying ML jobs
- Why? To help job seekers identify the skills that are most aligned with high 
salaries in the ML field.
*/


SELECT 
    skills.skills,
    COUNT(skills) AS skill_count -- No. of job listings mentioning each skill
-- Subquery to select the top 50 highest-paying ML jobs
FROM (
    SELECT 
        job_id
    FROM 
        job_postings_fact AS job_postings
    WHERE 
        (job_title ILIKE '%Machine Learning%' 
        OR job_title ILIKE '% ML %') 
        AND salary_year_avg IS NOT NULL 
    ORDER BY salary_year_avg DESC -- Order by highest salary
    LIMIT 50 -- Only top 50 highest paying jobs
) AS top_ML_jobs
INNER JOIN skills_job_dim AS skills_to_job ON top_ML_jobs.job_id = skills_to_job.job_id
INNER JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
WHERE skills.skills IS NOT NULL -- Exclude any NULL skills
GROUP BY skills
ORDER BY skill_count DESC -- Order by most mentioned skills
LIMIT 10;

 