# 📊 COVID-19 Data Exploration (SQL)
A SQL project to explore Covid-19 data with SQL techniques. You can use this as a study resource or as a foundation for your own data projects, even adding new queries or insights 💡.

Contributions are welcome! 

## Index 📌
- [About the project](#about)
- [How to run](#run)
- [Queries and analysis](#query)

## About the project <a name="about"></a>

This project explores Covid-19 data using SQL.

Techniques used:

- Joins to combine CovidDeaths and CovidVaccinations datasets
- CTEs and Temp Tables for intermediate calculations
- Window Functions for rolling sums
- Aggregate Functions to compute global totals
- Data type conversions for accurate analysis

The goal is to demonstrate SQL skills while analyzing global cases, deaths, population impact, and vaccination data.

## How to run <a name="run"></a>
Follow these instructions to run the queries in SQL Server:

Requirements:
- SQL Server 
- Access to the PortifolioProject database or import the datasets CovidDeaths and CovidVaccinations
- SQL Server Management Studio (SSMS) 

Steps:
- Clone or download this repository.
- Open sql/covid_data_exploration.sql in SSMS.
- Run the queries sequentially to explore different aspects:
  - Total cases vs deaths
  - Population infection rates
  - Rolling vaccinations per country
  - Global summaries and continent breakdowns
- Optional: Create the PercentPopulationVaccinated view for future visualizations.


## Queries and analysis 📁 <a name="query"></a>
The main SQL file contains the following sections:

- Data selection and filtering – only countries with continents.
- Total cases vs total deaths – calculate death percentages.
- Total cases vs population – percentage of population infected.
- Top countries by infection and death rates – global and continent-level.
- Global statistics – daily and cumulative totals.
- Vaccinations – rolling totals using window functions.
- CTEs and Temp Tables – alternative ways to calculate percentages.





