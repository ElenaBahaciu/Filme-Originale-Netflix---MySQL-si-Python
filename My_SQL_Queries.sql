USE netflix;

DESC netflix_originals;

#Select all rows in the table
SELECT * FROM netflix_originals;


#Select the lattest movie and the first made movie made by Netflix
(SELECT * 
	FROM netflix_originals
		ORDER BY Premiere DESC LIMIT 1)
UNION 
(SELECT *
	FROM netflix_originals
		ORDER BY Premiere LIMIT 1);
        

# Top 15 Netflix original movies. Show only title, IMDB score, genre and language
SELECT Title, IMDB_score, Genre, Language
	FROM netflix_originals
		ORDER BY IMDB_score DESC LIMIT 15;

# Best 10 movies in 2021
SELECT Title, Genre, IMDB_score, DATE_FORMAT(Premiere, '%M %Y') AS 'Premiere Date'
	FROM netflix_originals
		WHERE Premiere > '2021-01-01'
		ORDER BY IMDB_score DESC
		limit 10;

#How many movies each genre are in the table.
SELECT Genre, COUNT(*) AS Count
	FROM netflix_originals
    GROUP BY Genre
    ORDER BY Count DESC;
    
#Top 5 best Netflix documentaries
SELECT Title, Premiere, IMDB_Score, Language
	FROM netflix_originals
		WHERE Genre='Documentary'
        ORDER BY IMDB_Score DESC
        LIMIT 5;

#Create a table with number of movies released in each year and the average score on IMDB for the movies on respected years
SELECT
 Year(Premiere) AS Year,
 COUNT(*) AS 'Number of Movies',
 ROUND(AVG(IMDB_score),1) AS 'Average Score'
	FROM netflix_originals
    GROUP BY Year(Premiere)
    ORDER BY Year(Premiere) DESC;

#How many movies with a score highe then 8 are in the db? List the movies title and score - descending order. Show only title and IMDB score
SELECT COUNT(*) AS 'Number of Good Movies' 
	FROM netflix_originals
		WHERE IMDB_score>8;
        

SELECT Title, IMDB_score
	FROM netflix_originals
		WHERE IMDB_score>8
        ORDER BY IMDB_score DESC;
        
# Which is the predominant language in Netflix movies. Colums visible will be language and count
SELECT Language, COUNT(*) AS Count
	FROM netflix_originals
		GROUP BY Language
        ORDER BY Count DESC;

#Calculate the average runtime of movies. Select all rows where movie have a runtime higher then the average runtime
SELECT AVG(Runtime) AS 'Average Runtime'
	FROM netflix_originals;
    

SELECT Title, Genre, Runtime
	FROM netflix_originals
		WHERE Runtime>
			(SELECT AVG(Runtime) FROM netflix_originals);
		
    
	
#Create a new table for movies based on new category 'Film Type' that groups movies by the following: Interview, short film and feature film and see if any insights can be leveraged
SELECT 
	CASE
		WHEN Genre like '%interview' THEN 'Interview'
		WHEN Runtime <=40 THEN 'Short Film'
        WHEN Runtime >40 THEN 'Feature Film'
    END AS 'Film Type',
    COUNT(*) AS 'Number of Movies',
    ROUND(AVG(Runtime),1) AS 'Average Runtime',
    ROUND(AVG(IMDB_score),1) AS 'Average IMDB score',
    ROUND(MAX(IMDB_score),1) AS 'Highest IMDB score',
    ROUND(MIN(IMDB_score),1) AS 'Lowest IMDB score'
    FROM netflix_originals
    GROUP BY CASE
		WHEN Genre like '%interview' THEN 'Interview'
		WHEN Runtime <=40 THEN 'Short Film'
        WHEN Runtime >40 THEN 'Feature Film'
    END ;
    