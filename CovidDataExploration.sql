/*
Covid 19 Data Exploration 

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/

SELECT * 
FROM PortifolioProject..CovidDeaths
Where continent is not null 
order by 3,4

--Select the data that will be used
Select Location, date, total_cases, new_cases, total_deaths, population
FROM PortifolioProject..CovidDeaths
Where continent is not null 
order by 1, 2

-- Total cases vs Total deaths
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortifolioProject..CovidDeaths
-- Where location like '%Brazil%'
Where continent is not null 
order by 1, 2

-- Total cases vs Population
-- Shows what percentage of population infected with Covid
Select Location, date, total_cases, Population, (total_cases/population)*100 as PercentPopulationInfected
FROM PortifolioProject..CovidDeaths
-- Where location like '%Brazil%'
order by 1, 2

-- Countries with Highest Infection Rate compared to Population
Select Location, Population, MAX(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
From PortifolioProject..CovidDeaths
Group by Location, Population
order by PercentPopulationInfected desc


-- Countries with Highest Death Count per Population
Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortifolioProject..CovidDeaths
Where continent is not null 
Group by Location
order by TotalDeathCount desc
-- if we break by continent...
Select Continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortifolioProject..CovidDeaths
Where continent is not null 
Group by Continent
order by TotalDeathCount desc

-- Continent with highest death count per population
Select Continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortifolioProject..CovidDeaths
Where continent is not null 
Group by Continent
order by TotalDeathCount desc

-- Global number
Select Date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM PortifolioProject..CovidDeaths
Where continent is not null 
Group by date
order by 1, 2

-- Total death
-- Global number
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM PortifolioProject..CovidDeaths
Where continent is not null 
order by 1, 2


-- Total Population vs Vaccinations (window function)
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
FROM PortifolioProject..CovidDeaths dea
 Join PortifolioProject..CovidVaccinations vac
	On dea.location =  vac.location
	and dea.date = vac.date
Where dea.continent is not null 
order by 2, 3

-- CTE
-- Using CTE to perform Calculation on Partition By in previous query
With PopVSVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
FROM PortifolioProject..CovidDeaths dea
 Join PortifolioProject..CovidVaccinations vac
	On dea.location =  vac.location
	and dea.date = vac.date
Where dea.continent is not null 
)
Select*, (RollingPeopleVaccinated/Population)*100
From PopVSVac

--TEMP TABLE
--Using Temp Table to perform Calculation on Partition By in previous query
DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
FROM PortifolioProject..CovidDeaths dea
 Join PortifolioProject..CovidVaccinations vac
	On dea.location =  vac.location
	and dea.date = vac.date
Select*, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated


--Creating view to store data for later visualizations
Create View PercentPopulationVaccinated as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
FROM PortifolioProject..CovidDeaths dea
 Join PortifolioProject..CovidVaccinations vac
	On dea.location =  vac.location
	and dea.date = vac.date
Where dea.continent is not null
--Order by 2, 3

Select*
From PercentPopulationVaccinated