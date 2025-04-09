/*
 SELECT *
 FROM (
 SELECT *
 FROM job_postings_fact
 WHERE EXTRACT(
 MONTH
 FROM job_posted_date
 ) = 1
 ) AS january_jobs;
 SELECT *
 FROM january_jobs;
 */
/*
 SELECT company_id,
 name AS company_name
 FROM company_dim
 WHERE company_id IN (
 SELECT company_id
 FROM job_postings_fact
 WHERE job_no_degree_mention = true
 ORDER BY company_id
 ) WITH company_job_count AS (
 SELECT company_id,
 COUNT(*) AS total_jobs
 FROM job_postings_fact 
 GROUP BY company_id
 )
 SELECT company_dim.name AS company_name,
 company_job_count.total_jobs
 FROM company_dim
 LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
 ORDER BY total_jobs DESC;
 */
/*
 SELECT s.skills_id,
 s.skills AS skill_name,
 top5.skill_count
 FROM (
 SELECT skills_id,
 COUNT(*) as skill_count
 FROM skill_job_dim
 GROUP BY skills_id
 ORDER BY COUNT(*) DESC
 LIMIT 5
 ) AS top5
 JOIN skills_dim s ON s.skill_id = top5.skill_id
 ORDER BY top5.skill_count DESC;
 */
/*
 SELECT c.company_id,
 c.name AS company_name,
 company_counts.job_count,
 CASE
 WHEN company_counts.job_count < 10 THEN 'Small'
 WHEN company_counts.job_count BETWEEN 10 AND 50 THEN 'Medium'
 ELSE 'Large'
 END AS size_category
 FROM company_dim c
 JOIN (
 -- Subquery: total job postings per company
 SELECT company_id,
 COUNT(*) AS job_count
 FROM job_posting_facts
 GROUP BY company_id
 ) AS company_counts ON c.company_id = company_counts.company_id
 ORDER BY company_counts.job_count DESC;
 */
WITH remote_job_skils AS (
    SELECT skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim AS skills_to_job
        INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE job_postings.job_work_from_home = true
        AND job_title_short = 'Data Analyst'
    GROUP BY skill_id
)
SELECT skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skils
    INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skils.skill_id
ORDER BY skill_count DESC
LIMIT 5;