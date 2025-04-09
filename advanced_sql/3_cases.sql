SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category
ORDER BY
    number_of_jobs;




SELECT
    j.job_title_short,
    j.salary_year_avg,
    c.name AS company_name,
    CASE
        WHEN j.salary_year_avg >= 120000 THEN 'HIGH'
        WHEN j.salary_year_avg >= 70000  THEN 'STANDARD'
        ELSE 'LOW'
    END AS salary_budget
FROM 
    job_postings_fact j
JOIN
    company_dim c ON j.company_id = c.company_id
WHERE
    j.job_title_short = 'Data Analyst'
ORDER BY
    j.salary_year_avg ASC;
