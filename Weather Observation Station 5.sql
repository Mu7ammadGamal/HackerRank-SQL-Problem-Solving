SELECT CITY, LENGTH(CITY) AS LEN FROM STATION
ORDER BY LEN ASC, CITY
LIMIT 1;

SELECT CITY, LENGTH(CITY) AS LEN FROM STATION
ORDER BY LEN DESC, CITY
LIMIT 1;
