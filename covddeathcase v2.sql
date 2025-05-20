
--select location, date, total_cases, new_cases, total_deaths, population from CovidDeaths
--order by 1,2
Select * from CovidDeaths
where continent is not null
order by 3,4

select location, date, total_cases,total_deaths, population , (total_deaths/total_cases)*100 Death_percentage
from CovidDeaths
where location like 'Africa'
where continent is not null
order by 1,2
----Looking at Total cases vs population
-----Show what percentage of population ot Covid
select location, date, total_cases, population , (total_deaths/population)*100 as Death_Percentage
from CovidDeaths where continent is not null
---where location like 'Africa'
order by 1,2
--looking at countries with Highest infection rate compared to population
Select location, population, Max(total_cases) as Highest_Infection_count, Max(total_cases/population)*100 as Percentage_population_infected
from CovidDeaths
where total_cases is not null 
and continent is null
Group by location,population
order by Percentage_population_infected desc

----Showing Countries with Highest  Death Count per population
Select location, Max(total_deaths) as TotalDeathcount
from CovidDeaths 
where continent is not null
and total_deaths is not null
Group by location 
order by TotalDeathcount desc

---lets break down the things
Select continent, Max(total_deaths) as TotalDeathcount
from CovidDeaths 
where continent is  not null
and total_deaths is not null
Group by continent
order by TotalDeathcount desc

---showing continent wiyh highest death count
Select continent, Max(total_deaths) as TotalDeathcount
from CovidDeaths 
where continent is  not null
and total_deaths is not null
Group by date
order by 1,2

-- global number
select sum(new_cases) as total_cases, sum(new_deaths) as total_deaths ,(sum(new_deaths)/sum(new_cases))*100 as new_Death_Percentage
from CovidDeaths where continent is not null
--Group by date
order by 1,2
---where location like 'Africa


