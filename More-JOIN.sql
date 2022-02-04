--#1 List the films where the yr is 1962 [Show id, title]
SELECT id, title
FROM movie
WHERE yr=1962

--#2 Give year of 'Citizen Kane'.
SELECT yr
FROM movie
WHERE title = 'Citizen Kane'

--#3 List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
SELECT id, title, yr
FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr

--#4 What id number does the actor 'Glenn Close' have?
SELECT id
FROM actor
WHERE name = 'Glenn Close'

--#5 What is the id of the film 'Casablanca'
SELECT id 
FROM movie
WHERE title = 'Casablanca'

--#6 Obtain the cast list for 'Casablanca'.
/*what is a cast list?
The cast list is the names of the actors who were in the movie.
Use movieid=11768, (or whatever value you got from the previous question)*/
SELECT name
FROM casting
JOIN actor ON id = actorid
WHERE movieid=11768

--#7 Obtain the cast list for the film 'Alien'
SELECT name
FROM casting
JOIN actor ON id = actorid
WHERE movieid = 
(SELECT id 
FROM movie
WHERE title =  'Alien')

--#8 List the films in which 'Harrison Ford' has appeared
SELECT m.title
FROM movie m
JOIN casting c ON m.id = c.movieid
JOIN actor a ON a.id = c.actorid
WHERE a.name = 'Harrison Ford'

--#9 List the films where 'Harrison Ford' has appeared - but not in the starring role. 
--[Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
SELECT m.title
FROM movie m
JOIN casting c ON m.id = c.movieid
JOIN actor a ON a.id = c.actorid
WHERE c.ord != 1 AND a.name = 'Harrison Ford'


--#10 List the films together with the leading star for all 1962 films.
SELECT DISTINCT m.title, a.name
FROM movie m
JOIN casting c ON m.id = c.movieid
JOIN actor a ON a.id = c.actorid
WHERE m.yr = 1962 AND c.ord = 1

--#11 Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

--#12 List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT title, name
FROM movie
JOIN casting ON(movieid=movie.id AND ord=1)
JOIN actor ON(actorid=actor.id)
WHERE movie.id IN(SELECT movieid FROM casting
WHERE actorid IN(SELECT id FROM actor WHERE name = 'Julie Andrews'))

--#13 Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
SELECT name
FROM actor
JOIN casting ON (id = actorid AND (SELECT COUNT(ord) FROM casting WHERE actorid = actor.id AND ord=1)>=15)
GROUP BY name

--#14 List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT title, COUNT(actorid) 
FROM movie 
JOIN casting ON movie.id = movieid 
WHERE yr = 1978
GROUP BY title 
ORDER BY COUNT(actorid) DESC, title

--#15 List all the people who have worked with 'Art Garfunkel'.
SELECT distinct actor.name
FROM movie
JOIN casting
ON casting.movieid = movie.id
JOIN actor
ON actor.id = casting.actorid
where movie.id in (select movieid from casting join actor on id =actorid where 
actor.name = 'Art Garfunkel') and actor.name <> 'Art Garfunkel'