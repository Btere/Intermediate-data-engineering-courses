-- =========================
-- 🟢 BEGINNER QUESTIONS
-- =========================
-- Thinking level with dataset to make my brain sees it as simple, no matter the data
-- 1. Show all wines in the dataset.

--quality >= 7 → Good  
-- quality 5–6 → Average  
-- quality < 5 → Poor

-- 2. Show only the columns: quality, alcohol, pH

-- 3. Find all wines with quality greater than 7

-- 4. Find wines where alcohol is less than 10

-- 5. Show wines with pH between 3.0 and 3.5

-- 6. Count total number of wines

-- 7. Find the minimum and maximum alcohol values

-- 8. Show all wines sorted by quality (highest first)

-- 9. Show wines where residual sugar is greater than 5

-- 10. Count how many wines have quality = 6


-- =========================
-- 🟡 INTERMEDIATE QUESTIONS
-- =========================

-- 11. Find the average quality of all wines

-- 12. Find the average alcohol content by quality

-- 13. Group wines by quality and count how many in each group

-- 14. Find average residual sugar for each quality level

-- 15. Show quality levels where average alcohol > 10

-- 16. Find wines where sulphates < 0.5 AND alcohol > 10

-- 17. Find wines where total sulfur dioxide is between 20 and 50

-- 18. Sort wines by residual sugar (lowest to highest)

-- 19. Find top 5 wines with highest alcohol

-- 20. Find average pH for wines grouped by quality


-- =========================
-- 🔵 CASE STATEMENT QUESTIONS
-- =========================

-- 21. Create a column 'quality_label':
--     quality >= 7 → 'Good'
--     quality 5–6 → 'Average'
--     quality < 5 → 'Poor'

-- 22. Classify wines based on alcohol:
--     alcohol < 9 → 'Low Alcohol'
--     9–12 → 'Medium'
--     >12 → 'High'

-- 23. Count how many wines fall into each quality_label category

-- 24. Group wines by sugar level:
--     residual_sugar < 5 → 'Low Sugar'
--     5–10 → 'Medium Sugar'
--     >10 → 'High Sugar'

-- 25. Find average quality for each sugar category


-- =========================
-- 🔴 ANALYSIS / THINKING QUESTIONS
-- =========================

-- 26. Do wines with higher alcohol have higher quality?
--     (Compare average quality across alcohol ranges)

-- 27. What is the average quality for wines with low sulphates (<0.5)?

-- 28. Compare average quality for:
--     low pH (<3.2) vs high pH (>3.5)

-- 29. Find the relationship between residual sugar and quality

-- 30. Which combination gives better quality:
--     high alcohol + low sugar OR low alcohol + high sugar?


-- =========================
-- 🧠 ADVANCED (INTERVIEW STYLE)
-- =========================

-- 31. Find top 3 quality levels with highest average alcohol

-- 32. Find wines that are above average alcohol (use subquery)

-- 33. Find wines with quality higher than the overall average quality

-- 34. Rank wines by alcohol within each quality group

-- 35. Find the percentage of wines that are 'Good'

-- 36. Identify outliers:
--     wines with alcohol much higher than average

-- 37. Find wines where sulphates are below average but quality is high

-- 38. Find correlation pattern:
--     group by ranges of alcohol and compute avg quality

-- 39. Find the most common quality score

-- 40. Find distribution of wines across different pH ranges


-- =========================
-- 🚀 BONUS (REAL-WORLD THINKING)
-- =========================

-- 41. Predict wine quality category using:
--     alcohol, pH, and residual sugar (use CASE)

-- 42. Find conditions that produce mostly 'Good' wines

-- 43. Create a rule:
--     IF alcohol > X AND sulphates > Y → Good wine
--     Test how accurate this rule is

-- 44. Segment wines into clusters based on:
--     sugar, alcohol, sulphates

-- 45. Find wines that contradict expectations:
--     high alcohol but low quality

-- 46. Find best “balanced” wines:
--     moderate sugar, moderate pH, high quality

-- 47. Build a scoring system combining:
--     alcohol + sulphates + sugar

-- 48. Find top 10% wines by quality

-- 49. Compare average features of top 10% vs bottom 10%

-- 50. Identify feature ranges that most frequently produce quality ≥ 7

-- using between instead of =

SELECT *
FROM wine_dataset
WHERE 
    total_sulfur_dioxide BETWEEN 13 AND 15
    AND residual_sugar BETWEEN 4.5 AND 5.5
    AND pH BETWEEN 3.1 AND 3.3;

SELECT  alcohol, 
quality, 
Id,
chlorides
FROM "Wine-dataset"
WHERE quality < 5;

#PEMDAS - order of operation within mysql
# Understanding distinct - to remove duplicates rows

SELECT DISTINCT w."fixed acidity",
	w. "citric acid", 
	w. quality,
	w. Id,
	w.density
FROM "Wine-dataset" AS w
WHERE 
	w.quality > 6
	 AND  w."fixed acidity" < 8.5 
	 AND w.pH > 2.8 
	 AND w."residual sugar" < 2.5;
	 
-- GROUP BY and  ORDERBY
-- with& without aggregarate function

SELECT quality, 
"total sulfur dioxide",
SUM("residual sugar"), 
AVG(density),
MAX(pH)
FROM "Wine-dataset"
GROUP BY quality
ORDER BY "total sulfur dioxide";

-- WHERE example
SELECT  
    pH,  
    MAX(quality), 
    SUM(density), 
    MIN(sulphates)
FROM "Wine-dataset"
GROUP BY pH
HAVING MIN(sulphates) > 0.06
LIMIT 45;

-- Learning inner join/JOIN

SELECT quality,
density,
"wds".sulphates 
FROM "Wine-dataset" AS wds
	INNER JOIN   customers AS cus
	ON wds.sulphates = cus.sulphates;
	
-- Right OUTER JOIN
SELECT  *
FROM "Wine-dataset"
	RIGHT JOIN customers
	ON "wine-dataset".sulphates = customers.sulphates;

-- Left join
SELECT quality,
density,
"wds".sulphates 
FROM "Wine-dataset" AS wds
	LEFT JOIN   customers AS cus
	ON wds.sulphates = cus.sulphates;
--full join
SELECT quality,
density,
"wds".sulphates 
FROM "Wine-dataset" AS wds
	FULL OUTER JOIN   customers AS cus
	ON wds.sulphates = cus.sulphates;

--Self join	
SELECT wds1.pH,
wds1."fixed acidity",
wds1."citric acid"
FROM "Wine-dataset" AS wds1
JOIN "Wine-dataset" AS wds2
	ON  wds1.quality = wds2.quality;

	
-- Create a TABLE

CREATE TABLE customers(Id INTEGER  PRIMARY KEY AUTOINCREMENT,
	CustomerName TEXT,
    ContactName TEXT,
    Address TEXT,
    City TEXT,
    PostalCode TEXT,
    Country TEXT,
	alcohol INTEGER
);
-- Populate the table automatically

WITH RECURSIVE numbers(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n < 52
)
INSERT INTO customers (
    CustomerName, ContactName, Address, City, PostalCode, Country, alcohol
)
SELECT 
    'Customer' || n,
    'Contact' || n,
    'Address' || n,
    'City' || n,
    '1000' || n,
    'Country' || n,
    abs(random() % 20)
FROM numbers;

-- alter TABLE
ALTER TABLE customers
ADD COLUMN sulphates REAL;

ALTER  TABLE customers
ADD COLUMN residual_sugar REAL;

-- add data to the new columns
UPDATE customers
SET sulphates = ROUND((abs(random()) % 100) / 100.0, 2);

UPDATE customers
SET residual_sugar = ROUND(1.0 + (abs(random()) % 144) / 10.0, 1);

-- UNION, UNION ALL

SELECT sulphates,
alcohol
FROM customers
UNION
SELECT sulphates, alcohol
FROM "Wine-dataset";

--UNION ALL-returns rows  with duplicates

SELECT sulphates,
alcohol
FROM customers
UNION ALL
SELECT sulphates, alcohol
FROM "Wine-dataset";


--CASE statement

SELECT CustomerName,
sulphates,
alcohol
CASE
	WHEN alcohol < 8 THEN 'Low'
	WHEN alcohol <= 12.5 THEN 'Medium'
	ELSE 'High'
END AS alcohol_level
FROM customers;


-- case with groupby
SELECT 
    CASE 
        WHEN alcohol < 8 THEN 'Low'
        WHEN alcohol <= 12 THEN 'Medium'
        ELSE 'High'
    END AS alcohol_level,
    COUNT(*) AS total
FROM customers
GROUP BY 
    CASE 
        WHEN alcohol < 8 THEN 'Low'
        WHEN alcohol <= 12 THEN 'Medium'
        ELSE 'High'
    END;

-- case with HAVING
SELECT 
    CASE 
        WHEN alcohol < 8 THEN 'Low'
        WHEN alcohol <= 12 THEN 'Medium'
        ELSE 'High'
    END AS alcohol_level,
    AVG(alcohol) AS avg_alcohol
FROM customers
GROUP BY 
    CASE 
        WHEN alcohol < 8 THEN 'Low'
        WHEN alcohol <= 12 THEN 'Medium'
        ELSE 'High'
    END
HAVING AVG(alcohol) > 9;

--using subquery instead of case

SELECT alcohol_level, COUNT(*)
FROM (
    SELECT 
        CASE 
            WHEN alcohol < 8 THEN 'Low'
            WHEN alcohol <= 12 THEN 'Medium'
            ELSE 'High'
        END AS alcohol_level
    FROM customers
) t
GROUP BY alcohol_level;


--case with orderby
SELECT alcohol_level, COUNT(*)
FROM (
    SELECT 
        CASE 
            WHEN alcohol < 8 THEN 'Low'
            WHEN alcohol <= 12 THEN 'Medium'
            ELSE 'High'
        END AS alcohol_level
    FROM customers
) t
GROUP BY alcohol_level;

--Find the percentage of wines that are 'Good' (good wines / total wines) * 100

SELECT alcohol, 
density,
pH, 
quality,
CASE
	WHEN quality <= 4 THEN "poor"
	WHEN quality BETWEEN 5 AND 6  THEN 'Average'
     ELSE 'Good'
  END AS alcohol_level,
  COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS percentage
FROM "Wine-dataset";

-- simpler method
SELECT 
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM "Wine-dataset") AS good_percentage
FROM "Wine-dataset"
WHERE quality >= 7;


-- subquery in sql
-- syntax
--SELECT column_name-common
-- FROM table_name1
-- WHERE column_name-common IN 
  -- (SELECT column_name-common FROM table_name2 WHERE conditions_to_filters);
  -- clauses that works for subqueries WHERE< FROM< HAVING etc

SELECT "fixed acidity",
chlorides,
"free sulfur dioxide",
sulphates
FROM "Wine-dataset"
WHERE sulphates IN (
SELECT sulphates FROM customers
WHERE sulphates =0.74);

--subquery and groupby
SELECT 
    quality,
    avg_alcohol
FROM (
    SELECT 
        quality,
        AVG(alcohol) AS avg_alcohol
    FROM "Wine-dataset"
    GROUP BY quality
) t;
