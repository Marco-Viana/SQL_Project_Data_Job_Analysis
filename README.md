# SQL_Project_Data_Job_Analysis

## Introduction
This repository contains SQL scripts and queries that explore job data to identify high-paying roles, in-demand skills, and optimal skill combinations. Through this project, I practiced essential SQL concepts to better understand how different factors influence the job market.

## Background
The data analyzed here revolves around job salaries, job skills, and the relationship between them. The goal was to derive insights about:
1. What are the top-paying data analyst jobs?  
2. What skills are required for these top-paying jobs?  
3. What skills are most in demand for data analysts?  
4. Which skills are associated with higher salaries?  
5. What are the most optimal skills to learn?

By investigating these questions, I aimed to develop a stronger grasp of SQL techniques while also exploring key trends in the job market.

## Tools Used
Throughout this analysis, a variety of tools and platforms helped bring the project to life:

- **SQL**: The backbone of the analysis—enabling queries and data manipulation to uncover critical insights.
- **PostgreSQL**: Chosen database management system, ideal for managing the job posting data and easily scalable for more extensive datasets.
- **Visual Studio Code**: My go-to environment for writing and running SQL queries with integrated extensions.
- **Git & GitHub**: Essential for version control, collaboration, and transparent tracking of changes to scripts and analysis files.

## The Analysis
Below are five major queries (and their sub-queries) that each focus on a specific aspect of the data analyst job market. Additionally, scripts like `1_create_tables.sql`, `2_dates.sql`, `3_cases.sql`, `4_subqueries_CTL.sql`, and `5_union_operators.sql` were used to lay the groundwork (e.g., table setup, date handling, conditional logic, subqueries, and UNION operations).

---

### 1. Top-Paying Data Analyst Jobs
**Goal**: Identify and rank data analyst roles by the highest salaries, especially remote-friendly positions.

```sql
SELECT	
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim 
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_location = 'Anywhere' 
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;

