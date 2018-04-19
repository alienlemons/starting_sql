Use the `oscar_nominees` table in Mode to complete the following 12 questions.

#Question 1
#What movies were made before 1990?

#Task 1: Order from smallest id to largest.


SELECT *                                  --Superb!
  FROM tutorial.oscar_nominees 
  WHERE year < 1990
  ORDER BY id ASC
  LIMIT 30;

  /*I had to add a limit in order for the id column to appear. Without a limit, it would be left off.*/ -- good move, always limit. its good practice. And damm i see you commenting skills lol

#Question 2
#What movies were made from 2000 to today?

#Task 1: Show the oldest movie in your first row.

SELECT *                                   --Superb!
  FROM tutorial.oscar_nominees 
  WHERE year > 2000
  AND year < 2018
  ORDER BY year ASC;

#Question 3
#Restrict the number of rows in your output to 20 after id: 50.

#Task 1: Show movie, year, and id.
#Task 2: Order from oldest movie to youngest.

SELECT                                      --Superb!
    movie, 
    year, 
    id
  FROM tutorial.oscar_nominees 
  WHERE id >= 50
  ORDER BY year ASC
  LIMIT 21;

  /*It says "Restrict the number of rows in your output to 20 after id: 50." This suggests to me that they wanted to include 50, then add 20 addtl. rows (hence a total count of 21)*/ --this is my bad wording, but you got the overall idea lol

#Question 4
#What actor had a leading role in Hotel Rwanda? 

Don Cheadle and Sophie Okonedo were both nominated. It is unclear whether or not they had leading roles. 

Task 1: Pull id, winner, nominee, and movie columns. 

SELECT 
    id, 
    winner, 
    nominee, 
    movie columns
  FROM tutorial.oscar_nominees 
  WHERE movie = 'Hotel Rwanda';

--Close, we could have viewed the Category column to find `actor in a leading role`
--One way to find values is:
--SELECT DISTINCT Category
--FROM tutorial.oscar_nominees


#Question 5
#Which film and year was Marlon Brandos last Oscar win? 

1972

#Task 1: Pull only one row.

SELECT *                                              --Superb!
  FROM tutorial.oscar_nominees 
  WHERE nominee = 'Marlon Brando'
  AND winner = true
  ORDER BY year DESC
  LIMIT 1;

#Question 6
#Which nominees, whos name starts with the letter "R" have movies before 1979?

/*Robert De Niro
Richard Farnsworth
Richard Burton
Richard Dreyfuss
Robert De Niro
Ronee Blakley
Robert De Niro
Randy Quaid
Robert Redford
Robert Duvall
Richard Jaeckel
Roy Scheider
Ryan O'Neal
Richard Castellano
Rupert Crosse
Richard Burton
Ruth Gordon
Ron Moody
Rod Steiger
Richard Burton
Robert Shaw
Ruth Gordon
Richard Burton
Rod Steiger
Richard Burton
Rex Harrison
Rex Harrison
Rachel Roberts
Richard Harris
Rita Moreno
Robert Vaughn
Rosalind Russell
Russ Tamblyn
Red Buttons
Rock Hudson
Robert Stack
Rod Steiger
Richard Burton
Robert Strauss
Richard Burton
Ralph Richardson
Richard Todd
Richard Widmark
Ronald Colman
Rosalind Russell
Robert Ryan
Rosalind Russell
Ray Milland
Robert Mitchum
Rosalind Russell
Ronald Colman
Robert Montgomery
Ruth Hussey
Raymond Massey
Robert Donat
Robert Morley
Robert Donat
Ralph Bellamy
Robert Montgomery
Roland Young*/ --awesome commenting

SELECT 
    year,                                               -Superb!
    nominee, 
    movie
  FROM tutorial.oscar_nominees 
  WHERE year <= 1978
  AND nominee like 'R%'
  ORDER BY year DESC;

#Task 1: Retrieve year, nominee, and movie.

#Task 2: Have row 1 start with the youngest movie.

#Question 7
#Find all nominees who did not win an Oscar in the category 'actor in a leading role' and 'actress in a leading role' before 1993.

#Task 1: Show only 5 rows.

#Task 2: Don't include William Hurt.

#Task 3: Order from largest id to smallest.

SELECT *
  FROM tutorial.oscar_nominees 
  WHERE year < 1993 
  AND NOT ((category = 'actor in a leading role' OR category = 'actress in a leading role') AND winner = true)
  AND nominee != 'William Hurt'
  ORDER BY id DESC
  LIMIT 5;

  /*The questions says "Find all nominees who did not win an Oscar in the category 'actor in a leading role' and 'actress in a leading role' before 1993." I could have sorted based on only these two categories, but the way the question is worded suggests to me that we should ALSO include nominees from other categories because they did not technically win either by definition.*/
--ahh i see where u are coming from. The answer is still solid however the use of 'OR' selects one or the other, an 'AND' would have been better as it doesnt include both categories. link: https://www.techonthenet.com/mysql/or.php

#Question 8
#Which movie starts with "T" and ends with "c" and whose nominee fills out this criteria 'K_t_ _%' and the movie is between 1960 and 1998?


SELECT *                                                --Superb!
  FROM tutorial.oscar_nominees 
  WHERE year > 1960
  AND year < 1998
  AND movie like 'T%c'
  AND nominee like 'K_t_ _%';
  
 Movie is titanic

#Question 9
#Who were the nominee winners from 2000 to 2005 in the category, 'actor in a leading role' and 'actress in a leading role'?

Adrien Brody
Charlize Theron
Denzel Washington
Halle Berry
Hilary Swank
Jamie Foxx
Nicole Kidman
Sean Penn

SELECT *
  FROM tutorial.oscar_nominees 
  WHERE winner = true
  AND year > 2000
  AND  year < 2005
  AND (category = 'actor in a leading role' OR category = 'actress in a leading role')
  
--Close, with 'year > 2000' we start looking at nominees after 2000 so 2001. and the ending can be built like this too.
--category IN (
--    'actor in a leading role'
--    ,'actress in a leading role'
--    )
#Question 10
Who won an oscar between Tom Hanks and Nicolas Cage in the years 1990, 1999, and 1993? 


SELECT *
  FROM tutorial.oscar_nominees 
  WHERE 
  (year = 1990 OR year = 1999 OR year = 1993)
  AND
  (nominee = 'Tom Hanks' OR nominee = 'Nicolas Cage')
  ORDER by year DESC;

  Tom Hanks won
--Super good job pulling off the OR in the nominee logic. That one was tough, butso very close in the year. I think we have to review 'OR' logic
--year IN ( . -- a possible way
--    1990
--    ,1999
--    ,1993
--    )

#Question 11
Which nominees, whose names start with an "S" did not win an Oscar for the 'actress in a leading role' and 'actor in a leading role' between 2000 and 2010.


SELECT *
  FROM tutorial.oscar_nominees 
  WHERE nominee like 'S%'
  AND NOT 
  (category = 'actress in a leading role' AND winner = true)
  AND NOT                                              -- so a cool thing we can fix is, you are duplicating code. You add 'winner = true' and categories twice. we can rework it with 'IN' functions
  (category = 'actor in a leading role' AND winner = true)
  AND
  year > 2000 
  AND
  year < 2010
  AND 
  year != 2003
  AND 
  year != 2007;

Task 1: Do not include years 2003 and 2007.
Salma Hayek
Sean Penn
Sissy Spacek
Sophie Okonedo
Stanley Tucci

--SELECT nominee --the use of operators that u used was a better move.
--FROM tutorial.oscar_nominees
--WHERE year BETWEEN 2000
--    AND 2010
--  AND year NOT IN (
--    2003
--    ,2004
--    )
--  AND category NOT IN (
--   'actor in a supporting role'
--    ,'actress in a supporting role'
--    )
--  AND nominee LIKE 'S%'
--  AND winner = 'false'

#Question 12
Display year, category, nominee, and movie columns only. Order year from oldest to youngest and nominees from z to a. Only select movies from 1950,1960,1970,1980, and 1990.

SELECT 
    year, 
    category, 
    nominee,
    movie
  FROM tutorial.oscar_nominees 
  WHERE year = 1950 OR year = 1960 OR year = 1970 OR year = 1980 OR year = 1990 -- same use of IN but suberb!!
  ORDER BY 
    year ASC,  
    nominee DESC;

Group by year, then by nominee.
