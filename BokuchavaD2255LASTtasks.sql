SELECT st.name, st.surname, hb.name
FROM student st, hobby hb, std_hobby sh
WHERE sh.id_stud = st.id AND sh.id_hob = hb.id

SELECT st.name, st.surname, sh.date_start
FROM student st, std_hobby sh
WHERE st.id = sh.id_stud AND sh.date_end IS NULL
ORDER BY sh.date_start
LIMIT 1


SELECT DISTINCT st.score, st.name, st.surname, st.date_burth
FROM student st
INNER JOIN
	(
		SELECT SUM(hb.risk) as r_summ, sh.id_stud
		FROM hobby hb, 
			std_hobby sh
		WHERE hb.id= sh.id_hob AND sh.date_end IS NULL
		GROUP BY sh.id_stud
	)t
ON st.id = t.id_stud
AND t.r_summ > 9
WHERE st.score > 
	(
		SELECT AVG(score)::numeric(3,2)
		FROM student
	)

	
	
	
SELECT st.name, st.surname, st.n_g, st.date_burth, tt.monthes, tt.name
FROM student st
INNER JOIN
(SELECT (to_char(sh.date_end, 'MM')::numeric(10,0) + to_char(sh.date_end, 'YYYY')::numeric(10,0) * 12) - (to_char(sh.date_start, 'MM')::numeric(10,0) + to_char(sh.date_start, 'YYYY')::numeric(10,0) * 12) as monthes, sh.id_stud, hb.name
FROM std_hobby sh, hobby hb
WHERE hb.id = sh.id) tt
ON tt.id_stud = st.id

SELECT st.name, st.surname, st.n_g, st.date_burth
FROM student st
INNER JOIN
(SELECT count(sh.id_hob), sh.id_stud
FROM std_hobby sh, hobby hb
WHERE hb.id = sh.id_hob
GROUP BY sh.id_stud
HAVING count(sh.id_hob) >1) tt
ON tt.id_stud = st.id
WHERE 3 = ((to_char('2024-03-19'::date, 'YYYY')::int * 12 * 30 + to_char('2024-03-19'::date, 'MM')::int * 30 + to_char('2024-03-19'::date, 'DD')::int) - (to_char(st.date_burth, 'YYYY')::int * 12 * 30 + to_char(st.date_burth, 'MM')::int * 30 + to_char(st.date_burth, 'DD')::int))/ 30 / 12

SELECT DISTINCT st.n_g, avg(st.score)::numeric(3,2)
FROM student st
INNER JOIN(SELECT DISTINCT sh.id_stud
		  FROM std_hobby sh, hobby hb
		  WHERE sh.id_hob = hb.id AND sh.date_end IS NULL) tt
ON tt.id_stud = st.id
GROUP BY st.n_g

SELECT hb.name, hb.risk, -1 * (to_char(tt.dlit, 'YYYY')::numeric(5,0) * 12 + to_char(tt.dlit, 'MM')::numeric(5,0)) + (to_char(now(), 'YYYY')::numeric(5,0) * 12 + to_char(now(),'MM')::numeric(5,0))
FROM hobby hb
INNER JOIN(
SELECT sh.id_hob, min(sh.date_start) as dlit, sh.id_stud
FROM std_hobby sh
GROUP BY sh.id_stud, sh.id_hob
HAVING sh.id_stud = 3
LIMIT 1) tt
ON tt.id_hob = hb.id

SELECT hb.name
FROM student st
INNER JOIN std_hobby sh on sh.id_stud = st.id
INNER JOIN hobby hb on hb.id = sh.id_hob
WHERE st.score = (SELECT max(st.score)
				 FROM student st)
				 
SELECT hb.name
FROM hobby hb
INNER JOIN std_hobby sh on sh.id_hob = hb.id AND sh.date_end IS NULL
INNER JOIN student st on st.id = sh.dfid_stud
WHERE SUBSTRING(st.n_g::varchar, 1,1) = '2' AND st.score >= 3 AND st.score < 4

10

SELECT SUBSTRING(st.n_g::varchar,1,1) as course
FROM student st
INNER JOIN(SELECT SUBSTRING(st.n_g::varchar,1,1) as course, count(st.id) as countofstd
		  FROM student st
		  	INNER JOIN(SELECT sh.id_stud, count(sh.id_hob)
		  	FROM std_hobby sh
			WHERE sh.date_end IS NULL
		  	GROUP BY sh.id_stud
		  	HAVING count(sh.id_stud) > 1) tt
		  ON tt.id_stud = st.id
		  GROUP BY SUBSTRING(st.n_g::varchar,1,1)) ttend
ON SUBSTRING(st.n_g::varchar,1,1) = ttend.course
INNER JOIN(SELECT SUBSTRING(st.n_g::varchar,1,1) as course, count(st.id) as countofstd
		  FROM student st
		  GROUP BY SUBSTRING(st.n_g::varchar,1,1)) ttnext
ON SUBSTRING(st.n_g::varchar,1,1) = ttnext.course
WHERE ttnext.countofstd / 2 + ttnext.countofstd % 2 <= ttend.countofstd
GROUP BY SUBSTRING(st.n_g::varchar,1,1)

11

SELECT DISTINCT st.n_g
FROM student st
INNER JOIN(SELECT st.n_g, count(st.id) as countofstd, sum(st.score)
		  FROM student st
		  WHERE st.score >= 4
		  GROUP BY st.n_g) tt
ON st.n_g = tt.n_g
INNER JOIN(SELECT st.n_g, count(st.id) as countofstd
		  FROM student st
		  GROUP BY st.n_g) ttt
ON st.n_g = ttt.n_g
WHERE ttt.countofstd / 100 * 60 <= ttt.countofstd

12

SELECT count(sh.id_stud), SUBSTRING(st.n_g::varchar, 1,1)
FROM std_hobby sh, student st
WHERE sh.date_end IS NULL AND sh.id_stud = st.id
GROUP BY SUBSTRING(st.n_g::varchar,1,1)


13

SELECT st.id, st.name, st.surname, st.date_burth, SUBSTRING(st.n_g::varchar,1,1) as course
FROM student st
WHERE st.score = 5
EXCEPT SELECT DISTINCT stb.id, stb.name, stb.surname, stb.date_burth, SUBSTRING(stb.n_g::varchar,1,1) as course
FROM std_hobby sh, student stb
WHERE stb.id = sh.id_stud AND sh.date_end IS NULL
ORDER BY course, date_burth

14

CREATE OR REPLACE VIEW Student_5yearhobby AS
SELECT st.*
FROM student st, std_hobby sh
WHERE st.id = sh.id_stud AND sh.date_end IS NULL AND (to_char('2025-05-10'::date, 'YYYY')::int * 12 * 30 + to_char('2025-05-10'::date, 'MM')::int * 30 + to_char('2025-05-10'::date, 'DD')::int - to_char(sh.date_start, 'YYYY')::int * 12 * 30 + to_char(sh.date_start, 'MM')::int * 30 + to_char(sh.date_start, 'DD')::int) / 30 / 12 >= 5

15

SELECT hb.name, tt.countofhob
FROM hobby hb
INNER JOIN
(SELECT count(sh.id_stud) as countofhob, sh.id_hob
FROM std_hobby sh
 WHERE sh.date_end IS NULL
GROUP BY sh.id_hob) tt
ON tt.id_hob = hb.id

16

SELECT hb.name
FROM hobby hb
INNER JOIN
(SELECT count(sh.id_stud) as countofhob, sh.id_hob
FROM std_hobby sh
GROUP BY sh.id_hob) tt
ON tt.id_hob = hb.id
ORDER BY tt.countofhob DESC
LIMIT 1

17

SELECT DISTINCT st.*
FROM student st, std_hobby sh
INNER JOIN
(
SELECT hb.name, hb.id
FROM hobby hb
INNER JOIN
(SELECT count(sh.id_stud) as countofhob, sh.id_hob
FROM std_hobby sh
GROUP BY sh.id_hob) tt
ON tt.id_hob = hb.id
ORDER BY tt.countofhob DESC
LIMIT 1
) tt
ON sh.id_hob = tt.id
WHERE sh.id_stud = st.id

18

SELECT DISTINCT hb.id
FROM hobby hb
WHERE hb.risk = (SELECT max(risk)
				FROM hobby)
LIMIT 3

19

SELECT st.name,st.surname
FROM student st
INNER JOIN
(SELECT DISTINCT sh.id_stud, extract(day from (justify_days(now() - sh.date_start))) as countofdays
FROM std_hobby sh
WHERE sh.date_end IS NULL
ORDER BY countofdays DESC) tt
ON tt.id_stud = st.id
ORDER BY countofdays DESC LIMIT 10

20

SELECT DISTINCT st.n_g
FROM student st
INNER JOIN(
SELECT st.name,st.surname, st.id
FROM student st
INNER JOIN
(SELECT DISTINCT sh.id_stud, extract(day from (justify_days(now() - sh.date_start))) as countofdays
FROM std_hobby sh
WHERE sh.date_end IS NULL
ORDER BY countofdays DESC) tt
ON tt.id_stud = st.id
ORDER BY countofdays DESC LIMIT 10
) tt
ON tt.id = st.id

21

CREATE OR REPLACE VIEW ST_score_down AS
SELECT st.id, st.name, st.surname
FROM student st
ORDER BY st.score DESC

22

CREATE OR REPLACE VIEW PopHb6 AS
SELECT hb.name as hobbyname, count(sh.id_stud) as countofstd, SUBSTRING(st.n_g::varchar,1,1) as course
FROM hobby hb, std_hobby sh, student st
WHERE sh.id_hob = hb.id and sh.id_stud = st.id
GROUP BY hb.name, SUBSTRING(st.n_g::varchar,1,1)
ORDER BY SUBSTRING(st.n_g::varchar,1,1)

SELECT max(countofstd) as maxstd, course
FROM PopHb6
GROUP BY course

CREATE OR REPLACE VIEW TopHb AS
SELECT DISTINCT ph.course, ph.hobbyname
FROM PopHb6 ph
INNER JOIN(SELECT max(countofstd) as maxstd, course
FROM PopHb6
GROUP BY course) tt
ON tt.maxstd = ph.countofstd and tt.course = ph.course

23

CREATE OR REPLACE VIEW Cour2TopRiskHob AS
SELECT hobbyname, tt.risk
FROM TopHb th
INNER JOIN (SELECT hb.risk, hb.name
		   FROM hobby hb) tt
ON tt.name = th.hobbyname
WHERE course = '2'
ORDER BY tt.risk DESC

24

CREATE OR REPLACE VIEW CountStd AS
SELECT SUBSTRING(st.n_g::varchar,1,1), count(st.id)
FROM student st
GROUP BY SUBSTRING(st.n_g::varchar,1,1)

CREATE OR REPLACE VIEW CountOtl AS
SELECT count(st.id) as otl,SUBSTRING(st.n_g::varchar,1,1) as course
FROM student st
WHERE st.score = 5.0
GROUP BY SUBSTRING(st.n_g::varchar,1,1)

SELECT cs.substring as course, co.otl, cs.count as stdcount
FROM CountOtl co, CountStd cs
WHERE co.course = cs.substring

25

CREATE OR REPLACE VIEW MostPopHob AS
SELECT hb.name
FROM hobby hb
INNER JOIN
(SELECT sh.id_hob, countr(sh.id_stud) as cc
FROM std_hobby sh
GROUP BY sh.id_hob
ORDER BY cc DESC
LIMIT 1) tt
ON tt.id_hob = hb.id

26

--См. предыдущие представления

27

SELECT max(st.score), min(st.score), avg(st.score)::numeric(5,4), SUBSTRING(st.name,1,1)
FROM student st
GROUP BY SUBSTRING(st.name,1,1)
HAVING max(st.score) > 3.6
ORDER BY SUBSTRING(st.name,1,1) DESC

28

SELECT SUBSTRING(st.n_g::varchar,1,1), st.surname, max(st.score), min(st.score)
FROM student st
GROUP BY SUBSTRING(st.n_g::varchar,1,1), st.surname
ORDER BY SUBSTRING(st.n_g::varchar,1,1) DESC

29

SELECT DISTINCT to_char(st.date_burth, 'YYYY'), count(sh.id_hob)
FROM student st, std_hobby sh
WHERE st.id = sh.id_stud
GROUP BY to_char(st.date_burth, 'YYYY')

30

SELECT SUBSTRING(st.name,1,1), max(hb.risk), min(hb.risk)
FROM student st, std_hobby sh, hobby hb
WHERE st.id = sh.id_stud and hb.id = sh.id_hob
GROUP BY SUBSTRING(st.name,1,1)

31

SELECT to_char(st.date_burth, 'MM'), avg(st.score)::numeric(3,2)
FROM student st, std_hobby sh, hobby hb
WHERE st.id = sh.id_stud and hb.id = sh.id_hob and hb.name = 'Танцы'
GROUP BY to_char(st.date_burth, 'MM')

32

SELECT DISTINCT (('Имя: ' || st.name || ' Фамилия: ' || st.surname || ' Группа: ' || st.n_g)) as dataofstds
FROM student st, std_hobby sh, hobby hb
WHERE st.id = sh.id_stud and hb.id = sh.id_hob

33

SELECT CASE
		WHEN count(st.surname) > 0 THEN count(st.surname)::varchar
		ELSE 'Не найдено'
		END AS countofstd
FROM student st
WHERE st.surname like '%ов%'

34

CREATE VIEW heshtegs2 AS
SELECT SUBSTRING(st.surname || '##########', 1, 10) as surname
FROM student st

35

SELECT TRIM(both '#' from h.surname)
FROM heshtegs2 h

36

SELECT '2018-05-01'::date - '2018-04-01'::date

38

SELECT to_char(now(), 'YYYY')::int / 100 + 1 as senctuary, now()::date - '2021-01-01'::date as days, extract(week from now()) as week

37

SELECT  ((extract(day from (now()::date))::int / 7 * 7) + 7) - (extract(day from(now()::date))::int) - 1 as daystosat


39

SELECT st.name, st.surname, hb.name,
CASE
	WHEN sh.date_end IS NULL THEN  'Занимается'
	ELSE 'Не занимается'
	END AS StatusOfHobby
FROM student st, hobby hb, std_hobby sh
WHERE st.id = sh.id_stud and hb.id = sh.id_hob

40

SELECT * FROM crosstab('SELECT DISTINCT st2.score::int, st.n_g 
					   FROM student st, student st2
					   GROUP BY st2.score, st.n_g
					   ORDER BY st2.score::int') AS student(SCORE int, "1286" int, "2281" int, "2015" int, "3286" int, "2282" int, "3085" int, "2013" int, "2285" int, "3545" int, "1298" int, "1085" int)

