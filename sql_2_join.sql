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
SELECT cl.Language, ci.name, ci.Population as CityName
FROM city ci
         LEFT JOIN countrylanguage cl ON ci.CountryCode = cl.CountryCode
WHERE population BETWEEN 400 AND 500;


# 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them

SELECT ci.name, cl.language
FROM city ci
         JOIN countrylanguage cl ON ci.CountryCode = cl.CountryCode
WHERE ci.population BETWEEN 500 AND 600;

# 15: What names of the cities are in the same country as the city with a population of 122199 (including the that city itself)
SELECT ci.name as CityName, ci.countrycode, ci.population
FROM city ci
WHERE ci.CountryCode = (SELECT CountryCode FROM city WHERE population = 122199);
#Using LEFT JOIN
SELECT ci1.name, ci1.countrycode, ci1.population
FROM city ci2
         LEFT JOIN city ci1 ON ci2.CountryCode = ci1.CountryCode
WHERE ci2.Population = 122199;

# 16: What names of the cities are in the same country as the city with a population of 122199 (excluding the that city itself)

SELECT ci.name as CityName, ci.population
FROM city ci
WHERE ci.CountryCode = (SELECT CountryCode FROM city WHERE population = 122199)
  AND ci.population != 122199;



# 17: What are the city names in the country where Luanda is capital?

SELECT ci.name AS CityName, ci.CountryCode
from city ci
         JOIN country co ON ci.CountryCode = co.Code
WHERE co.Capital = (SELECT ID from city where name = 'Luanda');

SELECT ci.name AS CityName, ci.CountryCode
from city ci
         JOIN country co ON ci.CountryCode = co.Code
WHERE co.Capital = (SELECT ID from city where name = 'Luanda')
  AND ci.name != 'Luanda';

# 18: What are the names of the capital cities in countries in the same region as the city named Yaren

SELECT ci.name AS CapitalName
from country co
         JOIN city ci ON ci.ID = co.capital
WHERE co.Region = (SELECT co.Region
                   FROM country co
                            JOIN city ci ON ci.ID = co.Capital
                   WHERE ci.name = 'Yaren');

# 19: What unique languages are spoken in the countries in the same region as the city named Riga

SELECT DISTINCT cl.Language
FROM city ci
         JOIN country co ON ci.CountryCode = co.Code
         JOIN countrylanguage cl ON co.code = cl.CountryCode
WHERE co.Region = (SELECT Region FROM country WHERE Code = (SELECT CountryCode FROM city WHERE name = 'Riga'));

# 20: Get the name of the most populous city

SELECT name, population
FROM city
WHERE population = (SELECT MAX(population) FROM city);

