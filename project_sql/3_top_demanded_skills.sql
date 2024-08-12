/* 
Question: What are the most in-demand skills across all ML jobs, and how many
job postings mention these skills?
- Additionally, compare whether the required skills differ for remote vs. onsite jobs.
- Why? To provide job seekers with insights into the most sought-after skills for ML roles.
*/
 
-- CTE for in-demand skills in onsite jobs
WITH in_demand_skills_o AS (
    SELECT 
        skills.skills,
        COUNT(job_postings.job_id) AS demand_count -- Number of job postings mentioning each skill
    FROM job_postings_fact AS job_postings
    LEFT JOIN skills_job_dim AS skills_to_job ON job_postings.job_id = skills_to_job.job_id
    LEFT JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
    WHERE 
        (job_title ILIKE '%Machine Learning%' 
        OR job_title ILIKE '% ML %') 
        AND job_location <> 'Anywhere' -- Exclude remote jobs
    GROUP BY skills.skills
    ORDER BY demand_count DESC
    LIMIT 10
)
-- Retrieve results for in-demand skills in onsite jobs
SELECT * 
FROM in_demand_skills_o;

-- CTE for in-demand skills in remote jobs
WITH in_demand_skills_r AS (
    SELECT 
        skills.skills,
        COUNT(job_postings.job_id) AS demand_count
    FROM job_postings_fact AS job_postings
    LEFT JOIN skills_job_dim AS skills_to_job ON job_postings.job_id = skills_to_job.job_id
    LEFT JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
    WHERE 
        (job_title ILIKE '%Machine Learning%' 
        OR job_title ILIKE '% ML %') 
        AND job_location = 'Anywhere' -- Include only remote jobs
    GROUP BY skills.skills
    ORDER BY demand_count DESC
    LIMIT 10
)
-- Query for in demand skills for remote jobs
SELECT *
FROM in_demand_skills_r;
