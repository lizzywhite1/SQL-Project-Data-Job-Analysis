/*
Question: Which companies pay the most on average to their ML workers?
- Only include companies that offer health insurance.
- Why? This helps job seekers identify the best companies to target for their job 
search based on salary and benefits.
*/

SELECT 
    company_dim.name AS company_name,
    ROUND(AVG(salary_year_avg),0) AS avg_salary_company
FROM (
    SELECT *
    FROM job_postings_fact AS job_postings
    WHERE 
        (job_title ILIKE '%Machine Learning%' 
        OR job_title ILIKE '% ML %') 
        AND (salary_year_avg IS NOT NULL) 
        AND job_health_insurance IS TRUE -- Job includes health insurance
) AS ML_jobs

LEFT JOIN company_dim ON ML_jobs.company_id = company_dim.company_id
GROUP BY company_name
ORDER BY avg_salary_company DESC
LIMIT 10