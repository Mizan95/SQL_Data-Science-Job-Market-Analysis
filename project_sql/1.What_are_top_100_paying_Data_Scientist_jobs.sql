/* ❓What are the 100 top paying Data Scientist jobs in the UK and which companies are hiring for these roles?
Comments are visible to explain the logic.
*/


/*
1. This query consists of a single block and merges the Fact table (job_postings_fact) with the company Dimension table (company_dim) directly
without any intermediary CTE
2. The merge is an inner join with the primary key of company_dim being company_id. This matching with the foreign key of
job_postings_fact which is also company_id.
3. The query then selects the appropriate columns from both tables whilst filtering out NULL values selecting only Data Scientist jobs
4. This returns the top 500 Data Scientist jobs along with company names and yearly salaries
*/

SELECT 
    job_title_short AS job_title,
    company_dim.name AS company_name,
    job_country AS country,
    job_postings.salary_year_avg AS salary
FROM 
    job_postings_fact AS job_postings
-- Inner join with company_dim table to retrieve company name
INNER JOIN company_dim ON job_postings.company_id = company_dim.company_id
WHERE 
-- Filter out NULL value in salary and only choose Data Scientist jobs
    job_postings.salary_year_avg IS NOT NULL AND
    job_postings.job_title_short = 'Data Scientist'
-- Show results in descending order based on salaries
ORDER BY
    salary DESC
-- Limit result set to 100
LIMIT
    100

/*
Analysis
The maximum salary in this set is an outlier at $960,000.00, offered by East River Electric Power Cooperative, Inc.

The average salary for these elite roles is approximately $339,611.22, reflecting the highest compensation tier in data science.

The minimum salary in the top 100 is still exceptionally high at $274,675.00, setting a very high floor for the best-paid positions.

The median salary of $336,110.00 is very close to the average, indicating that most of the top 100 jobs offer uniformly high pay, with few major dips.

The vast majority of these highest-paying roles, 87 out of 100, are located in the United States demonstrating its dominance in the market for elite data science compensation.

[
  {
    "job_title": "Data Scientist",
    "company_name": "East River Electric Power Cooperative, Inc.",
    "country": "United States",
    "salary": "960000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "ReServe",
    "country": "United States",
    "salary": "585000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Selby Jennings",
    "country": "United States",
    "salary": "550000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Selby Jennings",
    "country": "United States",
    "salary": "525000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Netflix",
    "country": "United States",
    "salary": "450000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Netflix",
    "country": "United States",
    "salary": "450000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Glocomms",
    "country": "United States",
    "salary": "425000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "GM Financial",
    "country": "Sudan",
    "salary": "375000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "CACI International",
    "country": "United States",
    "salary": "375000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Asana",
    "country": "United States",
    "salary": "375000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Linquest Corporation",
    "country": "United States",
    "salary": "375000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Algo Capital Group",
    "country": "United States",
    "salary": "375000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Analog Devices, Inc",
    "country": "United States",
    "salary": "375000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Big Lots",
    "country": "United States",
    "salary": "375000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Algo Capital Group",
    "country": "United States",
    "salary": "375000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "PayPal",
    "country": "United States",
    "salary": "375000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Truist Financial",
    "country": "United States",
    "salary": "375000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Linquest Corporation",
    "country": "United States",
    "salary": "375000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Linquest Corporation",
    "country": "United States",
    "salary": "375000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "YETI Coolers",
    "country": "Sudan",
    "salary": "375000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Lands End",
    "country": "United States",
    "salary": "375000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Meta",
    "country": "United States",
    "salary": "375000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "CACI International",
    "country": "United States",
    "salary": "375000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "FIS",
    "country": "United States",
    "salary": "375000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Rippling",
    "country": "United States",
    "salary": "375000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Blue Cross and Blue Shield of Minnesota",
    "country": "United States",
    "salary": "375000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "TikTok",
    "country": "United States",
    "salary": "361000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Demandbase",
    "country": "Sudan",
    "salary": "351500.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Demandbase",
    "country": "United States",
    "salary": "351500.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Meta",
    "country": "United States",
    "salary": "350000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Zoox.com",
    "country": "United States",
    "salary": "350000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Intuit Inc",
    "country": "United States",
    "salary": "350000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "UBS",
    "country": "United States",
    "salary": "350000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Stripe",
    "country": "United States",
    "salary": "350000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Meta",
    "country": "United States",
    "salary": "350000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Mercury",
    "country": "Canada",
    "salary": "350000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Snap Inc",
    "country": "United States",
    "salary": "350000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "CodeStream, Inc.",
    "country": "United States",
    "salary": "350000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Gilead Sciences Inc",
    "country": "United States",
    "salary": "350000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Meta",
    "country": "United States",
    "salary": "350000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Meta",
    "country": "United States",
    "salary": "350000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Meta",
    "country": "United States",
    "salary": "350000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Nextdoor",
    "country": "United States",
    "salary": "350000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Selby Jennings",
    "country": "United States",
    "salary": "350000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Waymo",
    "country": "United States",
    "salary": "350000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Algo Capital Group",
    "country": "United States",
    "salary": "350000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Nextdoor",
    "country": "United States",
    "salary": "350000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Zoox.com",
    "country": "United States",
    "salary": "350000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Visa Inc",
    "country": "United States",
    "salary": "350000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Glocomms",
    "country": "United States",
    "salary": "337500.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Roblox",
    "country": "United States",
    "salary": "334720.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Demandbase",
    "country": "United States",
    "salary": "324000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Teramind",
    "country": "Sudan",
    "salary": "320000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Wells Fargo",
    "country": "United States",
    "salary": "320000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "SWS",
    "country": "Russia",
    "salary": "320000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Figma",
    "country": "United States",
    "salary": "314000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Reddit",
    "country": "United States",
    "salary": "313000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Stripe",
    "country": "United States",
    "salary": "309152.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Grammarly",
    "country": "United States",
    "salary": "308500.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "OpenAI",
    "country": "United States",
    "salary": "307500.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Chime",
    "country": "United States",
    "salary": "301000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Storm5",
    "country": "United States",
    "salary": "300000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Coda Search",
    "country": "United States",
    "salary": "300000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Walmart",
    "country": "United States",
    "salary": "300000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Storm4",
    "country": "United States",
    "salary": "300000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Block",
    "country": "United States",
    "salary": "300000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Lawrence Harvey",
    "country": "Sudan",
    "salary": "300000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Teradata",
    "country": "Sudan",
    "salary": "288000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "TikTok",
    "country": "United States",
    "salary": "285500.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "SAP America",
    "country": "United States",
    "salary": "285000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Snapchat",
    "country": "United States",
    "salary": "282500.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Stripe",
    "country": "United States",
    "salary": "281450.5"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Stripe",
    "country": "United States",
    "salary": "281450.5"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Stripe",
    "country": "United States",
    "salary": "281450.5"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Stripe",
    "country": "United States",
    "salary": "281450.5"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Stripe",
    "country": "United States",
    "salary": "281450.5"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Stripe",
    "country": "Sudan",
    "salary": "281450.5"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Stripe",
    "country": "Sudan",
    "salary": "281450.5"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Stripe",
    "country": "United States",
    "salary": "281450.5"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Stripe",
    "country": "United States",
    "salary": "281450.5"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Stripe",
    "country": "United States",
    "salary": "281450.5"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "The Aerospace Corporation",
    "country": "United States",
    "salary": "281070.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Home Depot / THD",
    "country": "United States",
    "salary": "280000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Rippling",
    "country": "United States",
    "salary": "279000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Meta",
    "country": "United States",
    "salary": "277500.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Instagram",
    "country": "United States",
    "salary": "277500.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Meta",
    "country": "United States",
    "salary": "277500.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Instagram",
    "country": "United States",
    "salary": "277500.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Meta",
    "country": "United States",
    "salary": "277500.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Meta",
    "country": "United States",
    "salary": "277500.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Meta",
    "country": "United States",
    "salary": "277500.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Snap Inc.",
    "country": "United States",
    "salary": "277500.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Meta",
    "country": "United States",
    "salary": "277500.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Torc Robotics",
    "country": "Sudan",
    "salary": "275000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Algo Capital Group",
    "country": "United States",
    "salary": "275000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Algo Capital Group",
    "country": "Sudan",
    "salary": "275000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Nord Group",
    "country": "United States",
    "salary": "275000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Glocomms",
    "country": "United States",
    "salary": "275000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Harnham",
    "country": "Sudan",
    "salary": "275000.0"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "ROBLOX Corporation",
    "country": "United States",
    "salary": "274675.0"
  }
]
*/