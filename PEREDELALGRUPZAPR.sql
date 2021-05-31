#1
select n_g, count(*)
from student
group by n_g

#2
select n_g, max(score)
from student
group by n_g

#3
select surname,count(*)
from student
group by surname

#4
select count(*),to_char(date_burth,'YYYY')
from student
where to_char(date_burth,'YYYY') is not null
group by to_char(date_burth,'YYYY')
order by to_char(date_burth,'YYYY')

#5
select substring(n_g::varchar,1,1) , avg(score)
from student
group by substring(n_g::varchar,1,1)

#6
select n_g, max(score) 
from student
where substring(n_g::varchar,1,1) = '4'
group by n_g
order by max(score) desc
limit 1

#7
select n_g , avg(score)
from student
group by n_g
having avg(score) <=4
order by avg(score) desc

#8
select n_g, count(*), max(score), avg(score), min(score)
from student
group by n_g

#9
select name, surname , n_g, score
from student
where score = (select max(score) from student where n_g = 2222) and n_g = 2222

#10
select s.name, s.surname, s.score, s.n_g
from student s, (select n_g, max(score) as m from student group by n_g) t
where s.n_g = t.n_g and s.score = t.m