/*	This is a csv file from the website https://transtats.bts.gov
	The timeline is from 2012-10-01 to 2012-11-30
	It contains flights data from six airports
	- ['BOS', 'EWR', 'JFK', 'MIA', 'PHI', 'SJU']
	- Boston (BOS)
	- Miami (MIA)
	- Newark (EWR)
	- New York (JFK)
	- Philadelphia (PHL)
	- Purto Rico (SJU)
*/

-- Show all data
SELECT * FROM flights_api_proj_gr4  AS f


-- get the latitude, longitude or city names for the airpots in the list
SELECT a.faa,
	   a.name AS name,
	   a.lat,
	   a.lon,
	   a.alt
FROM flights_api_proj_gr4 f
LEFT JOIN airports a
	ON f.origin = a.faa
GROUP BY a.faa, a.name, a.lat, a.lon, a.alt
HAVING faa IN ( 'BOS', 'EWR', 'JFK', 'MIA', 'PHI', 'SJU' )
ORDER BY faa;


-- time period and amount of data
SELECT MIN(flight_date), MAX(flight_date), COUNT(*) FROM flights_api_proj_gr4;


-- aggregated data: flights cancelled
SELECT flight_date, count(*) 
FROM flights_api_proj_gr4 f
GROUP BY flight_date, cancelled 
HAVING cancelled = 1
ORDER BY count(*) DESC
LIMIT 8;

-- Aggregated data: delay
SELECT AVG(dep_delay) AS dep_delay_avg,
	   MIN(dep_delay) AS dep_delay_min,
	   MAX(dep_delay) AS dep_delay_max,
	   AVG(arr_delay) AS arr_delay_avg,
	   MIN(arr_delay) AS arr_delay_min,
	   MAX(arr_delay) AS arr_delay_max,
	   (SELECT COUNT(*) FROM flights_api_proj_gr4 WHERE diverted = 1) AS diverted,
	   (SELECT COUNT(*) FROM flights_api_proj_gr4 WHERE cancelled = 1) AS cancelled
FROM flights_api_proj_gr4 f;


-- Which columns/data do we need?

SELECT flight_date,
	   origin,
	   dest,
	   -- dep_time,
	   MAKE_TIME(FLOOR(f.dep_time/100)::int, (f.dep_time::int%100), 0) AS dep_time_f, -- CONVERT DATA TYPE
	   -- arr_time,
	   MAKE_TIME(FLOOR(f.arr_time/100)::int, (f.arr_time::int%100), 0) AS arr_time_f,
	   MAKE_TIME(FLOOR(f.arr_time/100)::int, (f.arr_time::int%100), 0) - MAKE_TIME(FLOOR(f.dep_time/100)::int, (f.dep_time::int%100), 0) AS delta_air_time,
	   -- air_time,
	   MAKE_INTERVAL(mins => (f.air_time::int)) AS air_time_f,
	   -- dep_delay,
	   MAKE_INTERVAL(mins => (f.dep_delay ::int)) AS dep_delay_f,
	   -- arr_delay,
	   MAKE_INTERVAL(mins => (f.arr_delay ::int)) AS arr_delay_f,
	   airline, -- Difference between airlines
	   tail_number,
	   diverted,
	   cancelled
FROM flights_api_proj_gr4 f;


-- experimental
SELECT a.tz AS origin_tz,
	   a.tz AS dest_tz,
	   f.origin,
	   f.dest,
	   --f.dep_time,
	   --f.arr_time,
	   --f.air_time,
	   MAKE_TIME(FLOOR(f.dep_time/100)::int, (f.dep_time::int%100), 0) AS dep_time_f,
	   MAKE_TIME(FLOOR(f.arr_time/100)::int, (f.arr_time::int%100), 0) AS arr_time_f,
	   MAKE_TIME(FLOOR(f.arr_time/100)::int, (f.arr_time::int%100), 0) - MAKE_TIME(FLOOR(f.dep_time/100)::int, (f.dep_time::int%100), 0) AS calc_air_time,
	   MAKE_INTERVAL(mins => (f.air_time::int)) AS air_time_f
FROM flights_api_proj_gr4 f
LEFT JOIN airports a
	ON f.origin = a.faa
WHERE MAKE_TIME(FLOOR(arr_time/100)::int, (arr_time::int%100), 0) - MAKE_TIME(FLOOR(dep_time/100)::int, (dep_time::int%100), 0) != MAKE_INTERVAL(mins => (air_time::int));