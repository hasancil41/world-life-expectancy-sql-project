# World Life Expectancy SQL Project

## Overview

This project analyzes global life expectancy trends using SQL. It includes scripts for data cleaning and analysis applied to the `world_life_expectancy` dataset.

## Project Structure

- `scripts/data_cleaning.sql` — SQL queries for cleaning duplicates, handling missing values, and fixing inconsistencies.
- `scripts/analysis_queries.sql` — SQL queries for analysis such as min/max life expectancy, GDP impact, mortality trends, and improvements over time.

## Dataset

The dataset includes country-wise life expectancy, GDP, mortality rates, and development status over multiple years.

## Dataset Schema

The dataset contains the following columns:

| Column               | Description                        |
|----------------------|----------------------------------|
| Country              | Country name                     |
| Year                 | Year of record                   |
| Status               | Development status (Developed/Developing) |
| Life expectancy      | Average life expectancy (years)  |
| Adult Mortality      | Adult mortality rate              |
| Infant deaths       | Number of infant deaths           |
| Percentage expenditure | Health expenditure percentage     |
| Measles             | Measles cases                    |
| BMI                 | Average Body Mass Index           |
| Under-five deaths    | Deaths under five years of age    |
| Polio               | Polio vaccination coverage        |
| Diphtheria          | Diphtheria vaccination coverage   |
| HIV/AIDS            | HIV/AIDS death rate               |
| GDP                 | Gross Domestic Product            |
| Thinness 1-19 years | Thinness prevalence age 1-19      |
| Thinness 5-9 years  | Thinness prevalence age 5-9       |
| Schooling           | Average years of schooling        |
| Row_ID              | Unique row identifier             |

## Usage

1. Load the dataset into your SQL database.
2. Run `scripts/data_cleaning.sql` to clean and prepare the data.
3. Run `scripts/analysis_queries.sql` to perform analysis and gain insights.

## Key Insights

- Life expectancy improvements vary significantly by country and GDP.
- Developed countries tend to have higher life expectancy.
- GDP shows a positive correlation with life expectancy.

## Author

Hasan Cil  
[GitHub Profile](https://github.com/hasancil41)
