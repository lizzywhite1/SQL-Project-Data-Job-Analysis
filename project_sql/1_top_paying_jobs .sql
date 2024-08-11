/*
Question: What are the top paying ML roles?
- Identitfy top 10 highest paying ML jobs and company 
- Focus on job postings with saleries (No null values)
- Why? Highlight top-paying oppurunities for ML Engineers
*/

SELECT 
    companies.name AS company_name,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM 
    job_postings_fact AS job_postings
-- Use company dimension table to determine company from company id
LEFT JOIN company_dim AS companies ON job_postings.company_id = companies.company_id
WHERE 
-- Filtering to only show roles which contain the keywords ML or Machine Learning
    (job_title LIKE '%Machine Learning%' 
    OR job_title LIKE '% ML %')
-- Only show jobs with a salary input
    AND salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10