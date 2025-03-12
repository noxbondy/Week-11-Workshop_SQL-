# SQL Join exercise
#
#
# 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first

SELECT * 
FROM city
WHERE name LIKE 'ping%' 
ORDER BY Population ASC;

# 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first

SELECT name, population
FROM city
WHERE name LIKE 'Ran%'
ORDER BY population DESC;

# 3: Count all cities

SELECT COUNT(*) AS city_count
FROM city;


# 4: Get the average population of all cities

SELECT AVG(population) AS average_population
FROM city;

# 5: Get the biggest population found in any of the cities
SELECT MAX(population) AS largest_population
FROM city;

# 6: Get the smallest population found in any of the cities

SELECT MIN(population) AS smallest_population
FROM city;

# 7: Sum the population of all cities with a population below 10000

SELECT SUM(population) AS total_population
FROM city
WHERE population < 10000;

# 8: Count the cities with the countrycodes MOZ and VNM

SELECT countryCode, COUNT(*) AS cityCount
FROM city
WHERE countryCode IN ('MOZ', 'VNM')
GROUP BY countryCode;

# 9: Get individual count of cities for the countrycodes MOZ and VNM

SELECT CountryCode, count(city) AS city
FROM city
WHERE CountryCode IN ('MOZ', 'VNM')
GROUP BY CountryCode;

# 10: Get average population of cities in MOZ and VNM

SELECT CountryCode, AVG(population) AS avg_population
FROM city
WHERE CountryCode IN ('MOZ', 'VNM')
GROUP BY CountryCode;

# 11: Get the countrycodes with more than 200 cities

SELECT CountryCode
FROM city
GROUP BY CountryCode
HAVING COUNT(id) > 200;

# 12: Get the countrycodes with more than 200 cities ordered by city count

SELECT CountryCode, COUNT(*) AS city_count
FROM city
GROUP BY CountryCode
HAVING COUNT(*) > 200
ORDER BY city_count DESC;

# 13: What language(s) is spoken in the city with a population between 400 and 500 ?

SELECT c.Name AS City, cl.Language
FROM city c
JOIN countrylanguage cl ON c.CountryCode = cl.CountryCode
WHERE c.Population BETWEEN 400 AND 500;

# 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them

SELECT c.city_name, l.language
FROM City c
JOIN Languages l ON c.city_name = l.city_name
WHERE c.population BETWEEN 500 AND 600;

# 15: What names of the cities are in the same country as the city with a population of 122199 (including the that city itself)

SELECT name
FROM city
WHERE ID = (
    SELECT ID
    FROM city
    WHERE Population = 122199
)
ORDER BY name;

# 16: What names of the cities are in the same country as the city with a population of 122199 (excluding the that city itself)

SELECT name
FROM city
WHERE name = (
    SELECT name
    FROM city
    WHERE Population = 122199
    LIMIT 1
)
AND Population != 122199;

# 17: What are the city names in the country where Luanda is capital?

SELECT name
FROM City c
JOIN Countries co ON c.country_ID = co.country_ID
WHERE co.capital = 'Luanda';

# 18: What are the names of the capital cities in countries in the same region as the city named Yaren

SELECT c1.city_name AS CapitalCity
FROM city c1
JOIN countries co1 ON c1.country_id = co1.country_id
JOIN regions r1 ON co1.region_id = r1.region_id
WHERE c1.city_name IN (SELECT c2.city_name
                        FROM city c2
                        JOIN countries co2 ON c2.country_id = co2.country_id
                        JOIN regions r2 ON co2.region_id = r2.region_id
                        WHERE c2.city_name = 'Yaren')
AND c1.city_name <> 'Yaren';

# 19: What unique languages are spoken in the countries in the same region as the city named Riga

SELECT DISTINCT l.language
FROM languages l
JOIN country c ON l.country_id = c.id
JOIN regions r ON c.region_id = r.id
WHERE r.name = (
    SELECT r.Name
    FROM country c
    JOIN regions r ON c.region_id = r.id
    WHERE c.Name = 'Latvia'
);

# 20: Get the name of the most populous city

SELECT name
FROM city
ORDER BY Population DESC
LIMIT 1;

