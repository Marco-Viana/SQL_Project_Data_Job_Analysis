/*
SELECT 
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM    
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    month
ORDER BY
    job_posted_count DESC;
*/


/*
SELECT 
    job_schedule_type,
    AVG(salary_year_avg) AS salary_year_avg,
    AVG(salary_hour_avg) AS salary_hour_avg
FROM 
    job_postings_fact
WHERE
    job_posted_date > '2023-06-01'::DATE
GROUP BY
    job_schedule_type
ORDER BY
    job_schedule_type;
*/

/*
SELECT  
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'America/New_York') AS month,
    COUNT(*) AS job_posted_count
FROM
    job_postings_fact
WHERE  
    EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'America/New_York') = 2023
GROUP BY
    month
ORDER BY
    month;
*/


SELECT DISTINCT c.name
FROM job_postings_fact j
JOIN company_dim c
    ON j.company_id = c.company_id
WHERE j.job_health_insurance = TRUE
  AND EXTRACT(YEAR FROM j.job_posted_date) = 2023
  AND EXTRACT(QUARTER FROM j.job_posted_date) = 2;

 





