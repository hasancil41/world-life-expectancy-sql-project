/*
World Life Expectancy Project
Data Cleaning SQL Script
*/

-- Preview data
SELECT * FROM world_life_expectancy;

--------------------------------------------------------------------------------
-- A) Remove Duplicate Records by Country and Year
--------------------------------------------------------------------------------

-- 1) Identify duplicates
SELECT Country, Year, COUNT(*) AS duplicate_count
FROM world_life_expectancy
GROUP BY Country, Year
HAVING COUNT(*) > 1;

-- 2) Identify duplicates using ROW_NUMBER()
SELECT *
FROM (
  SELECT Row_id,
         Country,
         Year,
         ROW_NUMBER() OVER (PARTITION BY Country, Year ORDER BY Row_id) AS Row_Num
  FROM world_life_expectancy
) AS duplicates
WHERE Row_Num > 1;

-- 3) Delete duplicate rows, keeping the first entry per Country & Year
DELETE FROM world_life_expectancy
WHERE Row_ID IN (
  SELECT Row_id FROM (
    SELECT Row_id,
           ROW_NUMBER() OVER (PARTITION BY Country, Year ORDER BY Row_id) AS Row_Num
    FROM world_life_expectancy
  ) AS duplicates
  WHERE Row_Num > 1
);

--------------------------------------------------------------------------------
-- B) Handle Missing or Blank Status Values
--------------------------------------------------------------------------------

-- Check for blank Status
SELECT * FROM world_life_expectancy WHERE Status = '';

-- Check distinct Status values (non-blank)
SELECT DISTINCT Status FROM world_life_expectancy WHERE Status <> '';

-- Check countries with 'Developing' status
SELECT DISTINCT Country FROM world_life_expectancy WHERE Status = 'Developing';

-- Update blank Status to 'Developing' where other records for same country have 'Developing'
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2 ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
  AND t2.Status = 'Developing';

-- Update blank Status to 'Developed' where other records for same country have 'Developed'
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2 ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
  AND t2.Status = 'Developed';

-- Final check for blanks or NULL Status
SELECT * FROM world_life_expectancy WHERE Status = '' OR Status IS NULL;

--------------------------------------------------------------------------------
-- C) Fix Missing Lifeexpectancy Values
--------------------------------------------------------------------------------

-- Check rows where Lifeexpectancy is blank
SELECT * FROM world_life_expectancy WHERE Lifeexpectancy = '';

-- Preview Lifeexpectancy by Country and Year
SELECT Country, Year, Lifeexpectancy FROM world_life_expectancy;

-- Check life expectancy for rows with missing Lifeexpectancy using neighbors
SELECT t1.Country, t1.Year, t1.Lifeexpectancy, 
       t2.Year AS Prev_Year, t2.Lifeexpectancy AS Prev_LifeExp,
       t3.Year AS Next_Year, t3.Lifeexpectancy AS Next_LifeExp,
       ROUND((t2.Lifeexpectancy + t3.Lifeexpectancy) / 2, 1) AS Imputed_LifeExp
FROM world_life_expectancy t1
JOIN world_life_expectancy t2 ON t1.Country = t2.Country AND t1.Year = t2.Year + 1
JOIN world_life_expectancy t3 ON t1.Country = t3.Country AND t1.Year = t3.Year - 1
WHERE t1.Lifeexpectancy = '';

-- Update missing Lifeexpectancy using average of previous and next year
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2 ON t1.Country = t2.Country AND t1.Year = t2.Year + 1
JOIN world_life_expectancy t3 ON t1.Country = t3.Country AND t1.Year = t3.Year - 1
SET t1.Lifeexpectancy = ROUND((t2.Lifeexpectancy + t3.Lifeexpectancy) / 2, 1)
WHERE t1.Lifeexpectancy = '';
