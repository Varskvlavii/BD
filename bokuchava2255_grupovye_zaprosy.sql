#BOKUCHAVA 2255.
#NUM1
select n_group, count(*)
from student
group by n_group 

#NUM2
select n_group, max(score)
from student
group by n_group

#NUM3
select surname,count(*)
from student
group by surname

#NUM4
select count(*),to_char(date_birth,'YYYY')
from student
where to_char(date_birth,'YYYY') is not null
group by to_char(date_birth,'YYYY')
order by to_char(date_birth,'YYYY')

#NUM5
select substring(n_group::varchar,1,1) , avg(score)
from student
group by substring(n_group::varchar,1,1)

#NUM6
select n_group, max(score) 
from student
where substring(n_group::varchar,1,1) = '4'
group by n_group
order by max(score) desc
limit 1

#NUM7
select n_group , avg(score)
from student
group by n_group
having avg(score) <=4
order by avg(score) desc

#NUM8
select n_group, count(*), max(score), avg(score), min(score)
from student
group by n_group

#NUM9
select name, surname , n_group, score
from student
where score = (select max(score) from student where n_group = 2222) and n_group = 2222

#NUM10
select s.name, s.surname, s.score, s.n_group
from student s, (select n_group, max(score) as m from student group by n_group) t
where s.n_group = t.n_group and s.score = t.m