USE netflix;

CREATE TABLE netflix_originals(
id INT AUTO_INCREMENT PRIMARY KEY,
Title VARCHAR(200) NOT NULL,
Genre VARCHAR(100) NOT NULL,
Premiere DATE NOT NULL,
Runtime INT NOT NULL,
IMDB_score decimal(4,2) NOT NULL,
Language VARCHAR(100) NOT NULL
);

DESC netflix_originals;

SELECT * FROM netflix_originals;