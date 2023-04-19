-- Ejercicio 2:  Select only the Names of all the Bands. Change the name of the column the data returns to Band Name.

SELECT bands.name AS 'Band Name'
FROM bands;

-- Ejercicio 3: Select the Oldest Album. Make sure to only return one result from this query, and that you are not returning any albums that do not have a release year.

SELECT * FROM albums
WHERE release_year IS NOT NULL
ORDER BY release_year
LIMIT 1;

-- Ejercicio 4: Get all Bands that have Albums. There are multiple different ways to solve this problem, but they will all involve a join.

SELECT DISTINCT bands.name AS 'Band Name'
FROM bands
JOIN albums ON bands.id = albums.band_id;

-- Ejercicio 5: Get all Bands that have No Albums. This is very similar to #4 but will require more than just a join.

SELECT bands.name AS 'Band Name'
FROM bands
LEFT JOIN albums ON bands.id = albums.band_id
GROUP BY albums.band_id
HAVING COUNT(albums.id) = 0;

-- Ejercicio 6: Get the Longest Album. This problem sounds a lot like #3 but the solution is quite a bit different. I would recommend looking up the SUM aggregate function.
-- Return the album name as Name, the album release year as Release Year, and the album length as Duration.

SELECT
  albums.name as Name,
  albums.release_year as 'Release Year',
  SUM(songs.length) as 'Duration'
FROM albums
JOIN songs on albums.id = songs.album_id
GROUP BY songs.album_id
ORDER BY Duration DESC
LIMIT 1;

-- Ejercicio 7:  Update the Release Year of the Album with no Release Year. Set the release year to 1986.
-- You may run into an error if you try to update the release year by using release_year IS NULL in the WHERE statement of your UPDATE. This is because MySQL Workbench by default will not let you update a table that has a primary key without using the primary key in the UPDATE statement. This is a good thing since you almost never want to update rows without using the primary key, so to get around this error make sure to use the primary key of the row you want to update in the WHERE of the UPDATE statement.

/* This is the query used to get the id */
/*
  SELECT * FROM albums where release_year IS NULL;
*/

UPDATE albums
SET release_year = 1986
WHERE id = 4;

-- Ejercicio 8: Insert a record for your favorite Band and one of their Albums

INSERT INTO bands (name)
VALUES ('Favorite Band Name');

/* This is the query used to get the band id of the band just added */
/*
  SELECT id FROM bands
  ORDER BY id DESC LIMIT 1;
*/

INSERT INTO albums (name, release_year, band_id)
VALUES ('Favorite Album Name', 2000, 8);

-- Ejercicio 9: Delete the Band and Album you added in #8. The order of how you delete the records is important since album has a foreign key to band.

/* This is the query used to get the album id of the album added in #8 */
/*
  SELECT id FROM albums
  ORDER BY id DESC LIMIT 1;
*/

DELETE FROM albums
WHERE id = 19;

/* This is the query used to get the band id of the band added in #8 */
/*
  SELECT id FROM bands
  ORDER BY id DESC LIMIT 1;
*/

DELETE FROM bands
WHERE id = 8;

-- Ejercicio 10: Get the Average Length of all Songs. Return the average length as Average Song Duration.

SELECT AVG(length) as 'Average Song Duration'
FROM songs;

-- Ejercicio 11: Select the longest Song off each Album. Return the album name as Album, the album release year as Release Year, and the longest song length as Duration

SELECT
  albums.name AS 'Album',
  albums.release_year AS 'Release Year',
  MAX(songs.length) AS 'Duration'
FROM albums
JOIN songs ON albums.id = songs.album_id
GROUP BY songs.album_id;

-- Ejercicio 12: Get the number of Songs for each Band. This is one of the toughest question on the list. It will require you to chain together two joins instead of just one.

SELECT
  bands.name AS 'Band',
  COUNT(songs.id) AS 'Number of Songs'
FROM bands
JOIN albums ON bands.id = albums.band_id
JOIN songs ON albums.id = songs.album_id
GROUP BY albums.band_id;
