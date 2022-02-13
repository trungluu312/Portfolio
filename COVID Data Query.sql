-- Total cases vs deaths up to date

SELECT location, continent, date, population, total_cases, total_deaths
FROM [COVID]..[COVID Deaths]
WHERE continent is not null
ORDER BY 1,2,3

-- Total deaths per countries, highest to lowest

SELECT location, max(cast(total_deaths AS int)) as HighestDeathCounts
FROM [COVID]..[COVID Deaths]
WHERE continent is not null
GROUP BY location
ORDER BY 2 desc

-- Total infected cases and deaths per continents, highest to lowest

WITH ContinentsData(location, population, TotalDeaths, TotalCases) AS
(SELECT location,population, max(cast(total_deaths AS int)) as TotalDeaths, max(cast(total_cases AS int)) as TotalCases
FROM [COVID]..[COVID Deaths]
WHERE continent is null
and location not in ('Upper middle income', 'High income', 'Lower middle income', 'Low income', 'International','European Union')
GROUP BY location,population
)

SELECT *, (TotalCases/population)*100 as PercentageInfectedPopulation
FROM ContinentsData
ORDER BY PercentageInfectedPopulation desc

-- Total deaths per Income level, highest to lowest

SELECT location, max(cast(total_deaths AS int)) as TotalDeaths
FROM [COVID]..[COVID Deaths]
WHERE continent is null
and location in ('Upper middle income', 'High income', 'Lower middle income', 'Low income')
GROUP BY location
ORDER BY 2 desc


-- VACCINATION DATA

-- Percentage of Population with at least 1 dose vaccinated& fully vaccinated
SELECT dea.location, dea.date, dea.population, vacci.people_vaccinated as Atleast1DoseVaccinated, vacci.people_fully_vaccinated,
(vacci.people_vaccinated/dea.population)*100 AS Percentage1DoseVaccinated, 
(vacci.people_fully_vaccinated/dea.population)*100 AS PercentageFullyVaccinated
FROM [COVID]..[COVID Deaths] dea
JOIN [COVID]..[COVID Vaccinations] vacci ON dea.location = vacci.location
										and dea.date = vacci.date
WHERE dea.continent is not null										
ORDER BY 1,2

-- Countries with highest Vaccination Percentage
SELECT dea.location, dea.population,
max((vacci.people_vaccinated/dea.population)*100) AS FirstDosePercentage, 
max((vacci.people_fully_vaccinated/dea.population)*100) AS PercentageFullyVaccinated
FROM [COVID]..[COVID Deaths] dea
JOIN [COVID]..[COVID Vaccinations] vacci ON dea.location = vacci.location
										and dea.date = vacci.date
WHERE dea.continent is not null
GROUP BY dea.location, dea.population
ORDER BY FirstDosePercentage desc

--Delete faulty Entries
DELETE FROM [COVID]..[COVID Deaths]
WHERE location in ('Gibraltar', 'Pitcaim')

-- Countries with number of administered Vaccine per capita, date
SELECT dea.location, dea.date,dea.population, vacci.total_vaccinations, (vacci.total_vaccinations/dea.population) as VaccinePerCapita
FROM [COVID]..[COVID Deaths] dea
JOIN [COVID]..[COVID Vaccinations] vacci ON dea.location = vacci.location
										and dea.date = vacci.date
WHERE dea.continent is not null
ORDER BY 1,2

-- Countries with highest number of administered Vaccine per capita and their Percentage of Vaccinated Population
SELECT dea.location,dea.population, max(vacci.total_vaccinations/dea.population) as VaccinePerCapita,
max((vacci.people_vaccinated/dea.population)*100) AS FirstDosePercentage, 
max((vacci.people_fully_vaccinated/dea.population)*100) AS PercentageFullyVaccinated
FROM [COVID]..[COVID Deaths] dea
JOIN [COVID]..[COVID Vaccinations] vacci ON dea.location = vacci.location
										and dea.date = vacci.date
WHERE dea.continent is not null
GROUP BY dea.location, dea.population
ORDER BY  VaccinePerCapita desc

-- TEMP TABLE

CREATE TABLE #CountriesVaccinationPercentage
(
Location nvarchar(255),
Date datetime,
Population numeric
--Vaccinated numeric,
--FullyVaccinated numeric,
--PercentageVaccinated numeric,
--PercentageFullyVaccinated numeric
)

INSERT INTO #CountriesVaccinationPercentage
SELECT dea.Location, dea.Date, dea.Population--, vacci.people_vaccinated as Vaccinated, vacci.people_fully_vaccinated as FullyVaccinated
--,(vacci.people_vaccinated/dea.population)*100 AS PercentageVaccinated
--,(vacci.people_fully_vaccinated/dea.population)*100 AS PercentageFullyVaccinated
FROM [COVID]..[COVID Deaths] dea
JOIN [COVID]..[COVID Vaccinations] vacci ON dea.location = vacci.location
										and dea.date = vacci.date
--WHERE dea.continent is not null										
--ORDER BY 1,2


--Create View
Create View CountriesPercentageVaccinated
AS
SELECT dea.Location, dea.Date, dea.Population, vacci.people_vaccinated as Vaccinated, vacci.people_fully_vaccinated as FullyVaccinated
,(vacci.people_vaccinated/dea.population)*100 AS PercentageVaccinated
,(vacci.people_fully_vaccinated/dea.population)*100 AS PercentageFullyVaccinated
FROM [COVID]..[COVID Deaths] dea
JOIN [COVID]..[COVID Vaccinations] vacci ON dea.location = vacci.location
										and dea.date = vacci.date
WHERE dea.continent is not null



-- World Data
SELECT dea.location, max(cast(dea.total_cases AS int)) AS TotalCases, max(cast(dea.total_deaths AS int)) AS TotalDeaths,
max(people_vaccinated) as TotalVaccinated,  max(people_fully_vaccinated) as TotalFullyVaccinated
FROM [COVID]..[COVID Deaths] dea
JOIN [COVID]..[COVID Vaccinations] vacci ON dea.location = vacci.location
WHERE dea.location like 'World'
GROUP BY dea.location




SELECT dea.location, dea.date,dea.population, (vacci.people_fully_vaccinated/dea.population*100) AS PercentageFullyVaccinated,
(dea.total_deaths/dea.total_cases*100) AS MortalityRate, (dea.total_cases/ dea.population*100) AS InfectedPercentage
FROM [COVID]..[COVID Deaths] dea
JOIN [COVID]..[COVID Vaccinations] vacci ON dea.location = vacci.location
										and dea.date = vacci.date
WHERE dea.location in ('Vietnam', 'Germany')





