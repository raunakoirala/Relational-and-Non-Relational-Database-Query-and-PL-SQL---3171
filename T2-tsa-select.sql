--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T2-tsa-select.sql

--Student ID: 32509987
--Student Name: Raunak Koirala
--Unit Code: 32509987
--Applied Class No: A02

/* Comments for your marker:




*/

/*2(a)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    t.town_id,
    t.town_name,
    p.poi_type_id,
    pt.poi_type_descr,
    COUNT(p.poi_id) AS num_poi
FROM
    tsa.town t
    JOIN tsa.point_of_interest p ON t.town_id = p.town_id
    JOIN tsa.poi_type pt ON p.poi_type_id = pt.poi_type_id
GROUP BY
    t.town_id,
    t.town_name,
    p.poi_type_id,
    pt.poi_type_descr
HAVING
    COUNT(p.poi_id) > 1
ORDER BY
    t.town_id,
    pt.poi_type_descr;



/*2(b)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    m.member_id,
    m.member_gname || ' ' || m.member_fname AS member_name,
    m.resort_id,
    r.resort_name,
    COUNT(*) AS num_recommendations
FROM
    tsa.member m
    JOIN tsa.member m2 ON m.member_id = m2.member_id_recby
    JOIN tsa.resort r ON m.resort_id = r.resort_id
GROUP BY
    m.member_id,
    m.member_gname || ' ' || m.member_fname,
    m.resort_id,
    r.resort_name
ORDER BY
    m.resort_id,
    m.member_id;



/*2(c)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    p.poi_id,
    p.poi_name,
    CASE WHEN MAX(r.review_rating) IS NULL THEN 'NR' ELSE TO_CHAR(MAX(r.review_rating)) END AS max_rating,
    CASE WHEN MIN(r.review_rating) IS NULL THEN 'NR' ELSE TO_CHAR(MIN(r.review_rating)) END AS min_rating,
    CASE WHEN AVG(r.review_rating) IS NULL THEN 'NR' ELSE TO_CHAR(AVG(r.review_rating)) END AS avg_rating
FROM
    tsa.point_of_interest p
    LEFT JOIN tsa.review r ON p.poi_id = r.poi_id
GROUP BY
    p.poi_id,
    p.poi_name
ORDER BY
    p.poi_id;





/*2(d)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    p.poi_name,
    pt.poi_type_descr,
    t.town_name,
    LPAD('Lat: ' || TO_CHAR(t.town_lat, 'FM999.999999'), 15, ' ') ||
        ' Long: ' || TO_CHAR(t.town_long, 'FM999.999999') AS town_location,
    COUNT(r.review_id) AS reviews_completed,
    CASE
        WHEN COUNT(r.review_id) = 0 THEN 'No reviews completed'
        ELSE TO_CHAR(COUNT(r.review_id) * 100 / SUM(COUNT(r.review_id)) OVER (), 'FM999.99') || '%'
    END AS percent_reviews
FROM
    tsa.point_of_interest p
    JOIN tsa.poi_type pt ON p.poi_type_id = pt.poi_type_id
    JOIN tsa.town t ON p.town_id = t.town_id
    LEFT JOIN tsa.review r ON p.poi_id = r.poi_id
GROUP BY
    p.poi_name,
    pt.poi_type_descr,
    t.town_name,
    t.town_lat,
    t.town_long
ORDER BY
    t.town_name,
    COUNT(r.review_id) DESC,
    p.poi_name;



/*2(e)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
  r.resort_id,
  r.resort_name,
  m1.member_no,
  m1.member_gname || ' ' || m1.member_fname AS member_name,
  TO_CHAR(m1.member_date_joined, 'DD-MON-YYYY') AS date_joined,
  m2.member_no || ' ' || m2.member_gname || ' ' || m2.member_fname AS recommending_member,
  '$' || TO_CHAR(ROUND(mc.mc_total)) AS total_charges
FROM
  TSA.member m1
  JOIN TSA.RESORT r ON m1.resort_id = r.resort_id
  JOIN TSA.MEMBER_CHARGE mc ON m1.member_id = mc.member_id
  JOIN TSA.member m2 ON m1.member_id_recby = m2.member_id
WHERE
  r.resort_id NOT IN (
    SELECT resort_id
    FROM TSA.RESORT
    JOIN TSA.TOWN ON TSA.RESORT.town_id = TSA.TOWN.town_id
    WHERE TSA.TOWN.town_name = 'Bryon Bay' AND TSA.TOWN.town_state = 'NSW'
  )
  AND mc.mc_total < (
    SELECT AVG(mc_total)
    FROM TSA.MEMBER_CHARGE
    WHERE member_id = m1.member_id
  )
ORDER BY
  r.resort_id, m1.member_no;



/*2(f)*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer


SELECT
  r.resort_id,
  r.resort_name,
  p.poi_name,
  p.poi_street_address,
  t2.town_name AS poi_town,
  t2.town_state AS poi_state,
  p.poi_open_time,
  geodistance(t1.town_lat, t1.town_long, t2.town_lat, t2.town_long) AS distance
FROM
  TSA.RESORT r
  JOIN TSA.TOWN t1 ON r.town_id = t1.town_id
  JOIN TSA.POINT_OF_INTEREST p ON p.town_id = t1.town_id
  JOIN TSA.TOWN t2 ON p.town_id = t2.town_id
WHERE
  geodistance(t1.town_lat, t1.town_long, t2.town_lat, t2.town_long) <= 100
ORDER BY
  r.resort_name,
  distance;








