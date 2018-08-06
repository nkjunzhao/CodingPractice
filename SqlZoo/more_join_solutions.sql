-- More JOIN operation

-- Q1
/*List the films where the yr is 1962 [Show id, title]*/

SELECT id, title
  FROM movie
  WHERE yr = 1962;
  
-- Q2
/*Give year of 'Citizen Kane'.*/

SELECT yr
  FROM movie
  WHERE title = 'Citizen Kane';
  
-- Q3
/*List all of the Star Trek movies, include the id, title and yr (all of these movies 
include the words Star Trek in the title). Order results by year.*/

SELECT id, title, yr
  FROM movie
  WHERE title LIKE '%Star Trek%'
  ORDER BY yr;
  
-- Q4
/*What id number does the actor 'Glenn Close' have?*/

SELECT id
  FROM actor
  WHERE name = 'Glenn Close';
  
-- Q5
/*What is the id of the film 'Casablanca'*/

SELECT id
  FROM movie
  WHERE title = 'Casablanca';
  
-- Q6
/*Obtain the cast list for 'Casablanca'.

what is a cast list?
The cast list is the names of the actors who were in the movie.

Use movieid=11768, (or whatever value you got from the previous question)*/

SELECT name
  FROM actor
  JOIN casting
  ON id=actorid
  WHERE movieid = 11768;
  
-- Q7
/*Obtain the cast list for the film 'Alien'*/

SELECT name
  FROM actor
  JOIN casting
  ON id=actorid
  WHERE movieid = (SELECT id FROM movie WHERE title ='Alien' ) ;
  
-- Q8
/*List the films in which 'Harrison Ford' has appeared*/

SELECT title
  from actor
  JOIN casting
    ON actorid=actor.id
  JOIN movie
    ON movie.id =  movieid
   WHERE name = 'Harrison Ford';
   
-- Q9
/*List the films where 'Harrison Ford' has appeared - but not in the starring role. 
[Note: the ord field of casting gives the position of the actor. If ord=1 then this actor 
is in the starring role]*/

SELECT title
  FROM actor
  JOIN casting 
    ON actor.id=actorid
  JOIN movie
    ON movieid = movie.id
  WHERE actor.name = 'Harrison Ford' and ord<>1;
  
-- Q10
/*List the films together with the leading star for all 1962 films.*/

SELECT title, name
  FROM movie
  JOIN casting 
  ON movie.id=movieid
  JOIN actor 
  ON actor.id=casting.actorid
  WHERE yr=1962 and ord=1;

-- Q11
/*Which were the busiest years for 'John Travolta', show the year and the number of movies
 he made each year for any year in which he made more than 2 movies.*/

SELECT yr, count(*) as total
  FROM movie
  JOIN casting 
  ON movie.id =  casting.movieid
  JOIN actor 
  ON actor.id = casting.actorid
  WHERE name = 'John Travolta'
  GROUP by yr
  HAVING count(*)>2;
  
-- Q12 (important)
/*List the film title and the leading actor for all of the films 'Julie Andrews' played in.*/

-- Solution 1

SELECT title, name
  FROM movie
  JOIN casting
    ON (movie.id=casting.movieid AND casting.ord = 1)
  JOIN actor
    ON actor.id = casting.actorid
  WHERE movieid in 
    (SELECT movieid 
        FROM casting
        JOIN actor 
          ON actorid = actor.id
        WHERE actor.name = 'Julie Andrews' 
        GROUP by movieid
        ) ;

-- Solution 2        
SELECT title, name
  FROM movie
  JOIN casting
    ON (movie.id=casting.movieid AND casting.ord = 1)
  JOIN actor
    ON actor.id = casting.actorid
  WHERE movieid in 
    (SELECT movieid 
        FROM casting
        WHERE actorid = (
          SELECT actor.id
            FROM actor
            WHERE actor.name = 'Julie Andrews'
        )
    ) ;

-- Q13
/*Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.*/

SELECT actor.name
  FROM actor
  WHERE id IN (
    SELECT actorid
        FROM casting
        WHERE ord = 1
        GROUP BY actorid
        HAVING count(actorid)>=30)
  ORDER BY actor.name;
  
-- Q14
/*List the films released in the year 1978 ordered by the number of actors in the cast, then by title.*/

SELECT title, COUNT(actorid)
  FROM movie
  JOIN casting
    ON movie.id = casting.movieid
  WHERE yr = 1978
  GROUP BY movie.title
  ORDER BY COUNT(*) DESC, title;
  
-- Q15 (important)
/*List all the people who have worked with 'Art Garfunkel'.*/

-- Solution 1

SELECT DISTINCT actor.name
  FROM actor
  JOIN casting
    ON actor.id = casting.actorid
  WHERE name <> 'Art Garfunkel' and movieid IN (
     SELECT movieid
       FROM casting
       WHERE actorid = (
          SELECT id
            FROM actor
            WHERE name = 'Art Garfunkel')
      );
      
-- Solution 2

SELECT DISTINCT actor.name
  FROM actor
  JOIN casting
    ON actor.id = casting.actorid
  WHERE name <> 'Art Garfunkel' and movieid IN (
     SELECT movieid
       FROM casting
       JOIN actor
         ON casting.actorid = actor.id
         WHERE name = 'Art Garfunkel'
      );
