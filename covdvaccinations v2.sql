
select*
from covidDeaths dea
join covidVaccinations vac
    on dea.location = vac.location
    and dea.date=vac.date
	
	-----population vs vaccination

with popvsVac (Continent, location, date, population, new_vaccinations,rollingpeoplevaccinated) 
as
(	
select dea.continent,dea.location,dea.date, dea.population, vac.new_vaccinations, sum(vac.new_vaccinations) 
over(partition by dea.location order by dea.location, dea.date) as rollingpeoplevaccinated,
(SUM(vac.new_vaccinations) OVER(PARTITION BY dea.location ORDER BY dea.date) / dea.population) * 100 AS percentpeoplevaccinate
from covidDeaths dea
join covidVaccinations vac
    on dea.location=vac.location
    and dea.date=vac.date
	where dea.continent is not null
	--order by 2,3
)
select * 
from popvsvac

---temp table


-- Create table
Drop table if exists percentagepopulationVaccination;
CREATE TABLE percentagepopulationVaccination (
    continent VARCHAR(255),
    location VARCHAR(255),
    date TIMESTAMP,
    population NUMERIC,
    new_vaccinations NUMERIC,
    rollingpeoplevaccinated NUMERIC,
    percentpeoplevaccinate NUMERIC
);

-- Insert data into the table
INSERT INTO percentagepopulationVaccination (
    continent, location, date, population, new_vaccinations, rollingpeoplevaccinated, percentpeoplevaccinate
)
SELECT 
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(vac.new_vaccinations) OVER (
        PARTITION BY dea.location 
        ORDER BY dea.date
    ) AS rollingpeoplevaccinated,
    (SUM(vac.new_vaccinations) OVER (
        PARTITION BY dea.location 
        ORDER BY dea.date
    ) / dea.population) * 100 AS percentpeoplevaccinate
FROM 
    covidDeaths dea
JOIN 
    covidVaccinations vac
ON 
    dea.location = vac.location
    AND dea.date = vac.date
--WHERE dea.continent IS NOT NULL
    AND vac.new_vaccinations IS NULL;

-- View the data
SELECT * FROM percentagepopulationVaccination;


-----CREATING VIEW TO STORE DATA FOR LATER VISUALIZATION
drop view if exists percentpopulationVaccinated;
Create view percentpopulationVaccinated as
SELECT 
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(vac.new_vaccinations) OVER (
        PARTITION BY dea.location 
        ORDER BY dea.date
    ) AS rollingpeoplevaccinated
	
	from

    covidDeaths dea
JOIN 
    covidVaccinations vac
ON 
    dea.location = vac.location
    AND dea.date = vac.date
--WHERE dea.continent IS NOT NULL
    AND vac.new_vaccinations IS NULL;

select *
from percentpopulationVaccinated;
	
	