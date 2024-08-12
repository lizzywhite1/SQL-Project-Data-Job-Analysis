/*
Question: What are the top paying ML roles?
- Identitfy top 10 highest paying ML jobs and company 
- Focus on job postings with saleries (No null values)
- Why? Highlight top-paying oppurunities for ML Engineers
*/


SELECT 
    companies.name AS company_name, -- Name of company
    job_title,
    job_location,
    job_schedule_type, -- Type of job schedule (e.g. full-time)
    salary_year_avg,
    job_posted_date -- Date the job was posted 
FROM 
    job_postings_fact AS job_postings
-- Join with the company dimension table to get company details from company_id
LEFT JOIN company_dim AS companies ON job_postings.company_id = companies.company_id
WHERE 
-- Filter to include only roles that contain the keywords "ML" or "Machine Learning"    (job_title ILIKE '%Machine Learning%' 
    OR job_title ILIKE '% ML %')
    AND salary_year_avg IS NOT NULL -- Exclude NULL salaries
ORDER BY 
    salary_year_avg DESC
LIMIT 10; -- Limit to top 10 roles