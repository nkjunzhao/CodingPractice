-- Join operation

-- Q1
/*The first example shows the goal scored by a player with the last name 'Bender'. The * 
says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime

Modify it to show the matchid and player name for all goals scored by Germany. To identify
 German players, check for: teamid = 'GER'*/

SELECT matchid, player
  FROM goal
  WHERE teamid = 'GER';
  
-- Q2
/*From the previous query you can see that Lars Bender's scored a goal in game 1012. Now 
we want to know what teams were playing in that match.

Notice in the that the column matchid in the goal table corresponds to the id column in 
the game table. We can look up information about game 1012 by finding that row in the game table.

Show id, stadium, team1, team2 for just game 1012*/

SELECT id, stadium, team1, team2
  FROM game
  WHERE id = 1012;
  
-- Q3
/*show the player, teamid, stadium and mdate for every German goal.*/

-- Solution 1 USE JOIN
SELECT player, teamid, stadium, mdate
 FROM goal
 JOIN game 
 ON id = matchid and teamid = 'GER';

-- Solution 2, no need to use Join

SELECT player, teamid, stadium, mdate
 FROM goal, game
 WHERE id = matchid and teamid = 'GER';
 
-- Q4
/*Show the team1, team2 and player for every goal scored by a player called Mario player
 LIKE 'Mario%'*/
 
SELECT team1, team2, player
  FROM game
  JOIN goal
  ON id = matchid
  WHERE player LIKE 'Mario%';
  
-- Q5
/*Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10*/

SELECT player, teamid, coach, gtime
  FROM goal
  JOIN eteam
  ON teamid = id
  WHERE gtime <=10;
  
-- Q6 (important)
/*List the the dates of the matches and the name of the team in which 'Fernando Santos' 
was the team1 coach.*/

-- Solution 1 use JOIN
SELECT mdate, teamname
  FROM game
  JOIN eteam
  ON team1 = eteam.id
  WHERE coach= 'Fernando Santos';
  
-- Solution 2 no use of JOIN
SELECT mdate, teamname
  FROM game, eteam
  WHERE team1 in (
    SELECT id 
      FROM eteam
      WHERE coach = 'Fernando Santos') and team1 = eteam.id;
      
-- Q7
/*List the player for every goal scored in a game where the stadium was 
'National Stadium, Warsaw'*/

SELECT player
  FROM goal
  JOIN game
  ON id = matchid
  WHERE stadium = 'National Stadium, Warsaw';
  
-- Q8 (important)
/*show the name of all players who scored a goal against Germany.*/

-- Solution 1
SELECT DISTINCT player
  FROM goal
  JOIN game
  ON id = matchid 
  WHERE (team1=teamid and team2='GER') or (team2=teamid and team1='GER');
  
-- Solution 2
SELECT DISTINCT player
  FROM goal
  JOIN game
  ON id = matchid 
  WHERE teamid<>'GER' and (team2='GER' or team1='GER');
  
-- Q9 (important)
/*Show teamname and the total number of goals scored.*/

SELECT teamname, COUNT(*)
   FROM eteam
   JOIN goal ON teamid=id
   GROUP BY teamname;
   
-- Q10 
/*Show the stadium and the number of goals scored in each stadium.*/

SELECT stadium, COUNT(*)
  FROM game
  JOIN goal ON game.id = goal.matchid
  GROUP BY stadium;
  
-- Q11 (important)
/*For every match involving 'POL', show the matchid, date and the number of goals scored.*/

SELECT matchid, mdate, count(*)
  FROM goal
  JOIN game ON matchid=id
  WHERE team1='POL' or team2='POL'
  GROUP BY matchid,mdate;

-- Q12 (important)
/*For every match where 'GER' scored, show matchid, match date and the number of goals 
scored by 'GER'*/

SELECT matchid, mdate, count(*)
  FROM goal
  JOIN game on matchid = id
  WHERE teamid = 'GER'
  GROUP BY matchid, mdate;
  
-- Q13 (important)
/*List every match with the goals scored by each team as shown. This will use "CASE WHEN"
which has not been explained in any previous exercises.
mdate	team1	score1	team2	score2
1 July 2012	ESP	4	ITA	0
10 June 2012	ESP	1	ITA	1
10 June 2012	IRL	1	CRO	3
...
Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears 
in score1, otherwise there is a 0. You could SUM this column to get a count of the goals 
scored by team1. Sort your result by mdate, matchid, team1 and team2.*/

/*NOTE: Need to use LEFT JOIN instead of JOIN. Otherwise the match which both teams score
0 would not be shown in the query result.*/

SELECT mdate, team1, 
              SUM(CASE WHEN team1 = teamid THEN 1 ELSE  0 END) AS score1,
              team2,
              SUM(CASE WHEN team2 = teamid THEN 1 ELSE  0 END) AS score2
  FROM game
  LEFT JOIN goal
  ON game.id = goal.matchid
  GROUP BY mdate, team1, team2
  ORDER BY mdate, matchid, team1, team2;
  