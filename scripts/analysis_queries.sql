# World Life Expectancy Project (Data Analysis)

Select *
From world_life_expectancy;

-- Min, Max Life Expectancy by Country
Select Country, 
Min(Lifeexpectancy), 
Max(Lifeexpectancy),
Round(Max(Lifeexpectancy)-Min(Lifeexpectancy),1) as Life_Increase_15_Years
From world_life_expectancy
Group By Country
Having Min(Lifeexpectancy)<>0
AND Max(Lifeexpectancy)<>0
Order By Life_Increase_15_Years Desc;

-- Avg Life Expectancy by Year
Select Year, Round(avg(Lifeexpectancy),2) AS Avg_Life_expectancy
From world_life_expectancy
Group By Year
Order By avg(Lifeexpectancy);

-- Top 10 Countries by Average GDP with Positive Life Expectancy
Select Country,
  Round(Avg(Lifeexpectancy),1) AS life_exp,
  Round(Avg(GDP),1) AS GDP
From world_life_expectancy
Group By Country
Having Round(Avg(Lifeexpectancy),1)>0 AND Round(Avg(GDP),1)>0
Order By GDP DESC
Limit 10;

-- GDP Impact on Life Expectancy: High vs Low GDP Group
Select
Sum(Case When GDP>=1500 Then 1 Else 0 End) High_Gdp_Count,
Round(Avg(Case When GDP>=1500 Then `Lifeexpectancy` Else Null End),2) High_Gdp_LifEx,
Sum(Case When GDP <=1500 Then 1 Else 0 End) Low_Gdp_Count,
Round(Avg(Case When GDP<=1500 Then `Lifeexpectancy` Else Null End),2) Low_Gdp_LifEx
From world_life_expectancy;

-- GDP Summary by Development Status
Select Status, Count(Distinct Country) Country_Count,
Sum(GDP) Total_Gdp, 
Max(GDP) Max_Gdp,
Min(GDP) Min_Gdp,
Avg(GDP) Avg_Gdp
From world_life_expectancy
Where GDP>0
Group By Status;

-- Rolling Total of Adult Mortality Over Time by Country
Select
Country, 
Year, 
Lifeexpectancy,
AdultMortality, 
Sum(AdultMortality) Over(Partition By Country Order BY Year) Rolling_Total
From world_life_expectancy;

-- Life Expectancy Improvement (2007 vs 2022)
SELECT t1.Country,
       t1.`Lifeexpectancy` AS Life_2007,
       t2.`Lifeexpectancy` AS Life_2022,
       Round((t2.`Lifeexpectancy`-t1.`Lifeexpectancy`),2) AS Improvement
From world_life_expectancy t1
     Join world_life_expectancy t2
     ON t1.Country=t2.Country
Where t1.Year=2007
	AND t2.Year=2022
    AND t1.`Lifeexpectancy`>0
    AND t1.`Lifeexpectancy`>0
Order By Improvement Desc;
