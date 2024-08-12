/*
Question: What are the most optimal skills for ML roles, considering both high demand and high salary?
- Why? Identifies skills that offer job security (high demand) and are lucrative (high average salary), providing strategic insights for career development.
*/

SELECT
    skills_dim.skills, 
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings.salary_year_avg),0) AS avg_salary
FROM job_postings_fact AS job_postings
INNER JOIN skills_job_dim ON job_postings.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    (job_title ILIKE '%Machine Learning%' 
    OR job_title ILIKE '% ML %') 
    AND salary_year_avg IS NOT NULL
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) >= 50 -- Ensure at least 50 job postings for reliable demand data
ORDER BY 
    demand_count DESC, -- Order by highest demand first
    avg_salary DESC
LIMIT 10