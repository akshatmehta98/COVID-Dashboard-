-- SELECT*
-- FROM[dbo].[CovidDeaths] 
-- order by 3,4
-- Testing tables 

--This shows total cases to total deaths
Select [location],[date],[population],[total_cases],[new_cases],[total_deaths]
    from [dbo].[coviddeaths]
    order BY 1,2

--seeing the deathrate for people who contracted covid, total_deaths and total_cases are set as float
Select [location],[date],[total_cases],[total_deaths],Cast(total_deaths AS float)/Cast(total_cases AS float)*100 as Deathrate
    from [dbo].[coviddeaths]
    Where [location] Like '%United States%'

--Seeing the infection rate ordered by country
Select [location], MAX(total_cases),MAX(Cast(total_cases AS float)/Cast(population AS float))*100 as PopulationInfected
    from [dbo].[coviddeaths]
    GROUP BY location,Population
    ORDER by PopulationInfected DESC

-- death count by country
Select [location], MAX(total_deaths) as TotalDeathCount
    from [dbo].[coviddeaths]
    Where continent is not null 
    GROUP BY [location]
    order by TotalDeathCount DESC

-- Death count by continent
Select [continent], MAX(total_deaths) as TotalDeathCount
    from [dbo].[coviddeaths]
    Where continent is NOT null 
    GROUP BY [continent]
    order by TotalDeathCount DESC


--Global Numbers 
Select SUM(new_cases) as totalcases, SUM(new_deaths) as totaldeaths,SUM(cast(new_deaths as float))/SUM(cast(new_cases as float))*100 as deathpercentage
    from [dbo].[coviddeaths]
    Where [continent] is not null 
    --Group by date 
    order by 1,2 

--population vs vaccination
Select deaths.continent, deaths.location, deaths.date, deaths.population, vaccinations.new_vaccinations
, SUM (cast(vaccinations.new_vaccinations as float)) OVER (PARTITION by deaths.LOCATION order by deaths.LOCATION, deaths.date) as rollingvaccinations
From coviddeaths as deaths 
join covidvaccinations as vaccinations 
    on deaths.location = vaccinations.[location]
    and deaths.date = vaccinations.[date]
where deaths.continent is not null 
order by 2,3

-- Queries for tableau


Select location, SUM(cast(new_deaths as float))totaldeathcount
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc




Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as float)) as total_deaths, SUM(cast(new_deaths as float))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2


Select Location, Population, MAX(total_cases) as HighestInfectionCount,   MAX(total_cases),MAX(Cast(total_cases AS float)/Cast(population AS float))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc


Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,   MAX(total_cases),MAX(Cast(total_cases AS float)/Cast(population AS float))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Group by Location, Population, date
order by PercentPopulationInfected desc

--Queries for tableau 


