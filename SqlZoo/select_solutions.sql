--SELECT solutions

--
--SELECT basics
--

-- Q1  
SELECT population 
  FROM world
  WHERE name = 'Germany';
  
-- Q2 
SELECT name, population 
  FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');
  
-- Q3
SELECT name, area 
  FROM world
  WHERE area BETWEEN 200000 AND 250000;
  
--
--SELECT from WORLD
--
  
-- Q1
SELECT name, continent, population 
  FROM world;
  
-- Q2
SELECT name 
  FROM world
  WHERE population >= 200000000;
  
-- Q3
SELECT name, gdp/population as per_capita_GDP
  FROM world
  where population >= 200000000;
  
-- Q4
SELECT name, population/1000000 population_m
  FROM world
  WHERE continent = 'South America';
  
-- Q5
SELECT name, population
  FROM world
  WHERE name in ('France', 'Germany', 'Italy');
  
-- Q6
SELECT name
  FROM world
  WHERE name like '%United%';
  
-- Q7
SELECT name, population, area
  FROM world
  WHERE area > 3000000 or population > 250000000;
  
-- Q8
SELECT name, population, area
  FROM world
  WHERE (area > 3000000 and population <= 250000000) or (area <= 3000000 and population > 250000000);
  
-- Q9
SELECT name, ROUND(population/1000000,2) as pop_m, ROUND(gdp/1000000000, 2) as gdp_b 
  FROM world
  WHERE continent = 'South America';
  
-- Q10
SELECT name, ROUND(gdp/1000/population)*1000 as per_capita_GDP
  FROM world
  WHERE gdp >= 1000000000000;
  
-- Q11
SELECT name, capital
  FROM world
 WHERE LENGTH(name)=LENGTH(capital);
 
-- Q12
SELECT name, capital
  FROM world
  WHERE LEFT(name,1) = LEFT(capital,1) and name<>capital;

-- Q13
SELECT name
  FROM world
  WHERE name LIKE '%a%' and name LIKE '%e%' and name LIKE '%i%' and name LIKE '%o%' and name LIKE '%u%' and name NOT LIKE '% %';
  

--
-- SELECT from Nobel
--

-- Q1

SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950;
 
-- Q2
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature';
   
-- Q3
SELECT yr, subject
  FROM nobel
  WHERE winner = 'Albert Einstein';
  
-- Q4
SELECT winner
  FROM nobel
  WHERE subject = 'Peace' and yr>=2000;
  
-- Q5
SELECT yr, subject, winner
  FROM nobel
  WHERE subject = 'Literature' and yr BETWEEN 1980 and 1989;
  
-- Q6
SELECT yr, subject, winner
  FROM nobel
  WHERE winner in ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama');
  
-- Q7
SELECT winner
  FROM nobel
  WHERE winner LIKE 'John %';

-- or better to use
SELECT winner
  FROM nobel
  WHERE winner REGEXP '^John *';

-- Q8
SELECT yr, subject, winner
  FROM nobel
  WHERE (subject = 'Physics' and yr=1980) or (subject = 'Chemistry' and yr=1984);

-- Q9
SELECT yr, subject, winner
  FROM nobel
  WHERE yr=1980 and subject NOT IN ('Chemistry', 'Medicine');
  
-- Q10
SELECT yr, subject, winner
  FROM nobel
  WHERE (subject = 'Medicine' and yr < 1910) or (subject = 'Literature' and yr>=2004); 
  
-- Q11 
-- NOTE: 'LIKE' is case insensitive. 
SELECT yr, subject, winner
  FROM nobel
  WHERE winner LIKE ('PETER GR_NBERG');
  
-- Q12
SELECT yr, subject, winner
  FROM nobel
  WHERE winner LIKE ('EUGENE O\'NEILL');SELECT yr, subject, winner;

-- Q13
SELECT winner, yr, subject
  FROM nobel
  WHERE winner LIKE 'Sir%' 
  ORDER BY yr DESC, winner;
  
-- Q14
SELECT winner, subject
  FROM nobel
   WHERE yr=1984
   ORDER BY subject IN ('Physics','Chemistry'),subject,winner;

--
--SELECT within SELECT
--

-- Q1
SELECT name
  FROM world
  WHERE population > (
    SELECT population FROM world WHERE name='Russia');
  
-- Q2
SELECT name
  FROM world
  WHERE continent = 'Europe' and gdp/population > (
    SELECT gdp/population
        FROM world
        WHERE name ='United Kingdom');
  
-- Q3
SELECT name, continent
  FROM world
  WHERE continent in (
    SELECT DISTINCT continent 
       FROM world 
       WHERE name in ('Argentina' , 'Australia'))
  ORDER BY name;
  
-- Q4
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
SELECT name, CONCAT(ROUND(population/(
   SELECT population 
     FROM world
     WHERE name = 'Germany')*100),'%')
  FROM world
  WHERE continent = 'Europe';
  
-- Q6
SELECT name
  FROM world
  WHERE gdp > ALL(
    SELECT gdp 
      FROM world
      WHERE continent = 'Europe' and gdp IS NOT NULL);
    
-- Q7 (important)

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
SELECT name, continent
  FROM world a
  WHERE population >= ALL(
    SELECT 3*population
        FROM world b
        WHERE a.continent = b.continent and a.name <>b.name);
  
