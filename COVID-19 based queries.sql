-- This is my first step into the Data Analyst journey.

-- I have written a few queries myself and watched videos to find interesting questions to solve.

-- As you go further down, you’ll notice some queries achieve the same results but are written in different ways.

-- I've worked on medium to advanced queries in this file. I had written some basic ones too, but unfortunately, I forgot to save them. 😅

-- If you're reading this, I'm truly thankful to you.






--most deaths in any country

WITH LatestData AS (

    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY country ORDER BY date DESC) AS rn
    FROM PortfolioProject.dbo.CovidDeaths
)
SELECT 
    country, 
    total_cases, 
    population, 
    total_deaths
FROM LatestData
WHERE 
    rn = 1 AND
    continent IS NOT NULL    
ORDER BY total_deaths DESC;






-- population vs death cases for India

SELECT 
    country, 
    date, 
    total_cases, 
    total_deaths, 
    CASE
        WHEN total_cases = 0 THEN NULL
        ELSE (total_deaths * 1.0 / total_cases) * 100
    END AS death_percent
FROM 
    PortfolioProject.dbo.CovidDeaths
WHERE 
    country = 'India' 
ORDER BY 
    death_percent DESC;






-- looking at total_cases vs total_population 

select country , date , total_Cases , population , (total_cases/population)*100 as casePerPop 

from PortfolioProject.dbo.CovidDeaths
where country = 'India'

order by Date desc;








-- looking for which country or countries have highest infection rate

SELECT 
    country, 
    population, 
    MAX(total_cases) AS HighestEffectRate, 
    MAX((total_cases * 1.0 / population) * 100) AS PercentagePopulationInfected
FROM 

PortfolioProject.dbo.CovidDeaths

GROUP BY 
    country, population
ORDER BY 
    PercentagePopulationInfected desc;





-- Looking at countries with  Highest deathcount per population 

SELECT
    country,
    MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM
    PortfolioProject.dbo.CovidDeaths
WHERE
    continent IS NOT NULL
GROUP BY
    country
ORDER BY
    TotalDeathCount DESC;





/*I forgot importing continent column so I will be adding it to the covid deaths table

    ALTER TABLE PortfolioProject.dbo.CovidDeaths
    ADD code nvarchar(255);

    UPDATE CD
    SET CD.continent = CV.continent
    FROM PortfolioProject.dbo.CovidDeaths CD
    JOIN PortfolioProject.dbo.CovidVaccinations CV 
    ON CD.country = CV.country;

 looking at continents with  Highest deathcount per population */




SELECT
    country,
    MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM
    PortfolioProject..CovidDeaths
WHERE
    continent IS NULL
    and total_Deaths is not null
GROUP BY
    country
ORDER BY
    TotalDeathCount DESC;






-- Global Numbers

SELECT 
    date,
    SUM(new_cases) AS TotalCases,
    SUM(CAST(new_deaths AS INT)) AS TotalDeaths,
    (SUM(CAST(new_deaths AS INT)) * 100.0) / NULLIF(SUM(CAST(new_cases AS INT)), 0) AS DeathRatePercent
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
order by totalcases desc





-- Total Populations vs Total Vaccinated people

SELECT 
    CD.continent, 
    CD.country,
    MAX(CD.population) AS population,
    SUM(CAST(CV.new_vaccinations AS FLOAT)) AS TotalVaccinated
FROM PortfolioProject.dbo.CovidDeaths AS CD
JOIN PortfolioProject.dbo.CovidVaccinations AS CV
    ON CD.country = CV.country AND CD.date = CV.date
WHERE CD.continent IS NOT NULL
GROUP BY CD.continent, CD.country
ORDER BY TotalVaccinated desc;


---- 


SELECT 
    CD.continent, 
    CD.country,
    CV.date,
    FORMAT(CD.population, 'N0') AS population,
    FORMAT(CEILING(CAST(ISNULL(CV.new_vaccinations, 0) AS FLOAT)), 'N0') AS NewVaccinated
FROM PortfolioProject.dbo.CovidVaccinations AS CV
JOIN PortfolioProject.dbo.CovidDeaths AS CD
    ON CD.country = CV.country AND CD.date = CV.date
WHERE CD.continent IS NOT NULL
AND CV.date = (
    SELECT MAX(subCV.date)
    FROM PortfolioProject.dbo.CovidVaccinations AS subCV
    WHERE subCV.country = CV.country
)
ORDER BY CD.continent, CD.country;


-----

SELECT 
    dea.continent, dea.country, 
    MAX(dea.date) AS LatestDate,
    MAX(dea.population) AS population,
    SUM(TRY_CAST(vac.new_vaccinations AS BIGINT)) AS TotalVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
    ON dea.country = vac.country
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
GROUP BY dea.continent, dea.country
ORDER BY dea.continent, dea.country;



-- Using CTE's 

WITH PopvsVac (Continent, country, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS
(
    SELECT 
        dea.continent, 
        dea.country, 
        dea.date, 
        dea.population, 
        vac.new_vaccinations,
        SUM(TRY_CAST(vac.new_vaccinations AS FLOAT)) 
            OVER (PARTITION BY dea.country ORDER BY dea.country , dea.date) AS RollingPeopleVaccinated
    FROM PortfolioProject..CovidDeaths dea
    JOIN PortfolioProject..CovidVaccinations vac
        ON dea.country = vac.country
        AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
)
select * , (RollingPeopleVaccinated/Population)*100
FROM PopvsVac
ORDER BY 2, 3;




--temp table


drop table if exists #PercentPopulationVaccinated
Create table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinated numeric,
RollingPeopleVaccinated numeric)


insert into #PercentPopulationVaccinated
    SELECT 
        dea.continent, 
        dea.country, 
        dea.date, 
        dea.population, 
        vac.new_vaccinations,
        SUM(TRY_CAST(vac.new_vaccinations AS FLOAT)) 
            OVER (PARTITION BY dea.country ORDER BY dea.country , dea.date) AS RollingPeopleVaccinated
    FROM PortfolioProject..CovidDeaths dea
    JOIN PortfolioProject..CovidVaccinations vac
        ON dea.country = vac.country
        AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL

select * , (RollingPeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinated



-- Created B Trees for both the Tables

CREATE INDEX idx_deaths_country_date ON PortfolioProject..CovidDeaths(country, date);
CREATE INDEX idx_deaths_continent ON PortfolioProject..CovidDeaths(continent);
CREATE INDEX idx_vacc_country_date ON PortfolioProject..CovidVaccinations(country, date);


--- Making View to use it for later use...


Create View PercentPopulationVaccinated

as
    SELECT 
        dea.continent, 
        dea.country, 
        dea.date, 
        dea.population, 
        vac.new_vaccinations,
        SUM(TRY_CAST(vac.new_vaccinations AS FLOAT)) 
            OVER (PARTITION BY dea.country ORDER BY dea.country , dea.date) AS RollingPeopleVaccinated
    FROM PortfolioProject..CovidDeaths dea
    JOIN PortfolioProject..CovidVaccinations vac
        ON dea.country = vac.country
        AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL

   
   -- running the view
    
    select * from PercentPopulationVaccinated
