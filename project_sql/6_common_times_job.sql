/* 
Question: What are the busiest times of the year for job postings related to ML roles?
- Why? Provides job seekers with insights into the best times of the year to search 
for ML jobs.
*/

SELECT 
    EXTRACT(MONTH FROM job_posted_date) AS month_posted, -- Month the job was posted
    COUNT(job_id) AS jobs_posted -- Number of jobs posted in that month
FROM job_postings_fact AS job_postings
WHERE 
     (job_title ILIKE '%Machine Learning%' 
    OR job_title ILIKE '% ML %')
GROUP BY 
    month_posted
ORDER BY jobs_posted DESC;
