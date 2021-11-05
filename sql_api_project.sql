-- csv file from the website https://transtats.bts.gov


-- Which tables do we need?

-- Show table
SELECT * FROM flights_api_proj_gr4  AS f


-- EDA in DBeaver
SELECT COUNT(*) FROM flights_api_proj_gr4;
SELECT MAX(flight_date), MIN(flight_date) FROM flights_api_proj_gr4;
SELECT COUNT(*) FROM flights_api_proj_gr4
WHERE cancelled = 1;

--
SELECT origin FROM flights_api_proj_gr4 
GROUP BY origin
HAVING origin IN['BOS', 'JFK', 'MIA', 'EWR', 'PHL'];

-- standard
SELECT a.tz AS origin_tz,
	   a.tz AS dest_tz,
	   a.name AS name,
	   f.origin,
	   f.dest,
	   f.dep_time,
	   f.arr_time,
	   f.air_time,
	   MAKE_TIME(FLOOR(f.dep_time/100)::int, (f.dep_time::int%100), 0) AS dep_time_f,
	   MAKE_TIME(FLOOR(f.arr_time/100)::int, (f.arr_time::int%100), 0) AS arr_time_f,
	   MAKE_TIME(FLOOR(f.arr_time/100)::int, (f.arr_time::int%100), 0) - MAKE_TIME(FLOOR(f.dep_time/100)::int, (f.dep_time::int%100), 0) AS calc_air_time,
	   MAKE_INTERVAL(mins => (f.air_time::int)) AS air_time_f
FROM flights_api_proj_gr4 f
LEFT JOIN airports a
	ON f.origin = a.faa;


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

