/* 
Question: What skills are required for the top paying ML jobs?
- Using the top 50 highest paying ML jobs 
- Why? It helps job seekers understand which skills to develop that align
with top salaries 
*/ 

-- Use a CTE 
WITH top_ML_jobs AS (
    SELECT 
        job_id,
        companies.name AS company_name,
        job_title,
        job_location,
        salary_year_avg
    FROM 
        job_postings_fact AS job_postings
    LEFT JOIN company_dim AS companies ON job_postings.company_id = companies.company_id
    WHERE 
        (job_title LIKE '%Machine Learning%' 
        OR job_title LIKE '% ML %') -- ML Jobs
        AND salary_year_avg IS NOT NULL -- No NULL salaries
    ORDER BY salary_year_avg DESC
    LIMIT 50
)

-- Second Query 
SELECT 
    skills,
    COUNT(skills) AS skill_count 
FROM top_ML_jobs
LEFT JOIN skills_job_dim AS skills_to_job ON top_ML_jobs.job_id = skills_to_job.job_id
LEFT JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
WHERE skills IS NOT NULL 
GROUP BY skills
ORDER BY skill_count DESC 

 