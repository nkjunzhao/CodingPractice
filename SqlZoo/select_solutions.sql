--SELECT solutions

--
--SELECT basics
--

-- Q1  
/*The example uses a WHERE clause to show the population of 'France'. Note that strings 
(pieces of text that are data) should be in 'single quotes';
Modify it to show the population of Germany*/

SELECT population 
  FROM world
  WHERE name = 'Germany';
  
-- Q2 
/*Checking a list The word IN allows us to check if an item is in a list. The example 
shows the name and population for the countries 'Brazil', 'Russia', 'India' and 'China'.
Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.*/

SELECT name, population 
  FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');
  
-- Q3
/*Which countries are not too small and not too big? BETWEEN allows range checking (range 
specified is inclusive of boundary values). The example below shows countries with an area
 of 250,000-300,000 sq. km. Modify it to show the country and the area for countries with 
 an area between 200,000 and 250,000.*/
 
SELECT name, area 
  FROM world
  WHERE area BETWEEN 200000 AND 250000;
  
--
--SELECT from WORLD
--
  
-- Q1
/*Observe the result of running this SQL command to show the name, continent and 
population of all countries.*/

SELECT name, continent, population 
  FROM world;
  
-- Q2
/*Show the name for the countries that have a population of at least 200 million. 200 
million is 200000000, there are eight zeros.*/

SELECT name 
  FROM world
  WHERE population >= 200000000;
  
-- Q3
/*Give the name and the per capita GDP for those countries with a population of at least 
200 million.*/

SELECT name, gdp/population as per_capita_GDP
  FROM world
  where population >= 200000000;
  
-- Q4
/*Show the name and population in millions for the countries of the continent 'South 
America'. Divide the population by 1000000 to get population in millions.*/

SELECT name, population/1000000 population_m
  FROM world
  WHERE continent = 'South America';
  
-- Q5
/*Show the name and population for France, Germany, Italy*/

SELECT name, population
  FROM world
  WHERE name in ('France', 'Germany', 'Italy');
  
-- Q6
/*Show the countries which have a name that includes the word 'United'*/

SELECT name
  FROM world
  WHERE name like '%United%';
  
-- Q7
/*Two ways to be big: A country is big if it has an area of more than 3 million sq km or 
it has a population of more than 250 million. Show the countries that are big by area or 
big by population. Show name, population and area.*/

SELECT name, population, area
  FROM world
  WHERE area > 3000000 or population > 250000000;
  
-- Q8
/*Exclusive OR (XOR). Show the countries that are big by area or big by population but 
not both. Show name, population and area.

Australia has a big area but a small population, it should be included.
Indonesia has a big population but a small area, it should be included.
China has a big population and big area, it should be excluded.
United Kingdom has a small population and a small area, it should be excluded.
*/

SELECT name, population, area
  FROM world
  WHERE (area > 3000000 and population <= 250000000) or (area <= 3000000 and population > 250000000);
  
-- Q9
/*Show the name and population in millions and the GDP in billions for the countries of 
the continent 'South America'. Use the ROUND function to show the values to two decimal places.

For South America show population in millions and GDP in billions both to 2 decimal places.
*/

SELECT name, ROUND(population/1000000,2) as pop_m, ROUND(gdp/1000000000, 2) as gdp_b 
  FROM world
  WHERE continent = 'South America';
  
-- Q10
/*Show the name and per-capita GDP for those countries with a GDP of at least one trillion
 (1000000000000; that is 12 zeros). Round this value to the nearest 1000.

Show per-capita GDP for the trillion dollar countries to the nearest $1000.*/

SELECT name, ROUND(gdp/1000/population)*1000 as per_capita_GDP
  FROM world
  WHERE gdp >= 1000000000000;
  
-- Q11
/*Greece has capital Athens.

Each of the strings 'Greece', and 'Athens' has 6 characters.

Show the name and capital where the name and the capital have the same number of characters.

You can use the LENGTH function to find the number of characters in a string*/

SELECT name, capital
  FROM world
 WHERE LENGTH(name)=LENGTH(capital);
 
-- Q12
/*The capital of Sweden is Stockholm. Both words start with the letter 'S'.

Show the name and the capital where the first letters of each match. Don't include 
countries where the name and the capital are the same word.
You can use the function LEFT to isolate the first character.
You can use <> as the NOT EQUALS operator.*/

SELECT name, capital
  FROM world
  WHERE LEFT(name,1) = LEFT(capital,1) and name<>capital;

-- Q13
/*Equatorial Guinea and Dominican Republic have all of the vowels (a e i o u) in the name.
 They don't count because they have more than one word in the name.

Find the country that has all the vowels and no spaces in its name.

You can use the phrase name NOT LIKE '%a%' to exclude characters from your results.
The query shown misses countries like Bahamas and Belarus because they contain at least 
one 'a'*/

SELECT name
  FROM world
  WHERE name LIKE '%a%' and name LIKE '%e%' and name LIKE '%i%' and name LIKE '%o%' 
        and name LIKE '%u%' and name NOT LIKE '% %';
  

--
-- SELECT from Nobel
--

-- Q1
/*Change the query shown so that it displays Nobel prizes for 1950.*/

SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950;
 
-- Q2
/*Show who won the 1962 prize for Literature.*/

SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature';
   
-- Q3
/*Show the year and subject that won 'Albert Einstein' his prize.*/

SELECT yr, subject
  FROM nobel
  WHERE winner = 'Albert Einstein';
  
-- Q4
/*Give the name of the 'Peace' winners since the year 2000, including 2000.*/

SELECT winner
  FROM nobel
  WHERE subject = 'Peace' and yr>=2000;
  
-- Q5
/*Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 
1989 inclusive.*/

SELECT yr, subject, winner
  FROM nobel
  WHERE subject = 'Literature' and yr BETWEEN 1980 and 1989;
  
-- Q6
/*Show all details of the presidential winners:

Theodore Roosevelt
Woodrow Wilson
Jimmy Carter
Barack Obama*/

SELECT yr, subject, winner
  FROM nobel
  WHERE winner in ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama');
  
-- Q7
/*Show the winners with first name John*/

SELECT winner
  FROM nobel
  WHERE winner LIKE 'John %';

-- or better to use
SELECT winner
  FROM nobel
  WHERE winner REGEXP '^John *';

-- Q8
/*Show the year, subject, and name of Physics winners for 1980 together with the 
Chemistry winners for 1984.*/

SELECT yr, subject, winner
  FROM nobel
  WHERE (subject = 'Physics' and yr=1980) or (subject = 'Chemistry' and yr=1984);

-- Q9
/*Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine*/

SELECT yr, subject, winner
  FROM nobel
  WHERE yr=1980 and subject NOT IN ('Chemistry', 'Medicine');
  
-- Q10
/*Show year, subject, and name of people who won a 'Medicine' prize in an early year 
(before 1910, not including 1910) together with winners of a 'Literature' prize in a 
later year (after 2004, including 2004)*/

SELECT yr, subject, winner
  FROM nobel
  WHERE (subject = 'Medicine' and yr < 1910) or (subject = 'Literature' and yr>=2004); 
  
-- Q11 
-- NOTE: 'LIKE' is case insensitive. 
/*Find all details of the prize won by PETER GRÜNBERG*/

SELECT yr, subject, winner
  FROM nobel
  WHERE winner LIKE ('PETER GR_NBERG');
  
-- Q12
/*Find all details of the prize won by EUGENE O'NEILL

Escaping single quotes*/

SELECT yr, subject, winner
  FROM nobel
  WHERE winner LIKE ('EUGENE O\'NEILL');

-- Q13
/*Knights in order

List the winners, year and subject where the winner starts with Sir. Show the the most 
recent first, then by name order.*/

SELECT winner, yr, subject
  FROM nobel
  WHERE winner LIKE 'Sir%' 
  ORDER BY yr DESC, winner;
  
-- Q14
/*The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 
0 or 1.

Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry 
and Physics last.*/

SELECT winner, subject
  FROM nobel
   WHERE yr=1984
   ORDER BY subject IN ('Physics','Chemistry'),subject,winner;

--
--SELECT within SELECT
--

-- Q1
/*List each country name where the population is larger than that of 'Russia'.*/

SELECT name
  FROM world
  WHERE population > (
    SELECT population FROM world WHERE name='Russia');
  
-- Q2
/*Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

Per Capita GDP*/

SELECT name
  FROM world
  WHERE continent = 'Europe' and gdp/population > (
    SELECT gdp/population
        FROM world
        WHERE name ='United Kingdom');
  
-- Q3
/*List the name and continent of countries in the continents containing either Argentina 
or Australia. Order by name of the country.*/

SELECT name, continent
  FROM world
  WHERE continent in (
    SELECT DISTINCT continent 
       FROM world 
       WHERE name in ('Argentina' , 'Australia'))
  ORDER BY name;
  
-- Q4
/*Which country has a population that is more than Canada but less than Poland? Show the 
name and the population.*/

SELECT name, population
  FROM world
  WHERE population > (
    SELECT population
      FROM world 
      WHERE name = 'Canada')
  AND population <
    (SELECT  population
      FROM world 
      WHERE name = 'Poland');
      
-- Q5
/*Germany (population 80 million) has the largest population of the countries in Europe. 
Austria (population 8.5 million) has 11% of the population of Germany.

Show the name and the population of each country in Europe. Show the population as a 
percentage of the population of Germany.

Decimal places
Percent symbol %*/

SELECT name, CONCAT(ROUND(population/(
   SELECT population 
     FROM world
     WHERE name = 'Germany')*100),'%')
  FROM world
  WHERE continent = 'Europe';
  
-- Q6
/*Which countries have a GDP greater than every country in Europe? [Give the name only.] 
(Some countries may have NULL gdp values)*/

SELECT name
  FROM world
  WHERE gdp > ALL(
    SELECT gdp 
      FROM world
      WHERE continent = 'Europe' and gdp IS NOT NULL);
    
-- Q7 (important)
/*Find the largest country (by area) in each continent, show the continent, the name and 
the area:*/

-- Solution 1
SELECT a.continent, a.name, a.area
  FROM world a
  LEFT JOIN world b
  ON a.continent = b.continent and a.area<b.area
  WHERE b.area IS NULL;
  
-- Solution 2
SELECT a.continent, a.name, a.area
  FROM world a
  WHERE a.area = (
    SELECT MAX(b.area)
      FROM world b
      WHERE a.continent = b.continent);

-- Solution 3
SELECT continent, name, area
  FROM world a
  WHERE a.area >= ALL(
    SELECT area
    FROM world b
    WHERE a.continent = b.continent);
 
-- PostgreSQL solution
SELECT continent, name, area
 FROM (
   SELECT *, ROW_NUMBER() OVER(PARTITION BY continent ORDER BY area DESC)
     FROM world) AS a 
   WHERE ROW_NUMBER =1;
   
-- Q8 (important)
/*List each continent and the name of the country that comes first alphabetically.*/

--Solution 1
SELECT a.continent, a.name
  FROM world a
  LEFT JOIN world b
  ON a.continent = b.continent and a.name>b.name
  WHERE b.name IS NULL; 
  
-- Solution 2
SELECT continent, name
  FROM world a
  WHERE a.name <= ALL(
    SELECT b.name
      FROM world b
      WHERE a.continent=b.continent);  
      
-- Q9 (important)
/*Find the continents where all countries have a population <= 25000000. Then find the 
names of the countries associated with these continents. Show name, continent and 
population.*/

-- Solution 1
SELECT name, continent, population 
  FROM world
  WHERE continent IN (
    SELECT continent
    FROM world
    GROUP BY continent
    HAVING MAX(population) <= 25000000);
    
-- Solution 2
SELECT name, continent, population 
  FROM world a
  WHERE 25000000 >= ALL(
    SELECT population
    FROM world b
    WHERE a.continent=b.continent);
    
-- Q10 (important)
/*Some countries have populations more than three times that of any of their neighbours 
(in the same continent). Give the countries and continents.*/

SELECT name, continent
  FROM world a
  WHERE population >= ALL(
    SELECT 3*population
        FROM world b
        WHERE a.continent = b.continent and a.name <>b.name);
  
