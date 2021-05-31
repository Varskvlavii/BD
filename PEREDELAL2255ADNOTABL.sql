# 1 
select name, surname
from student
where (score<=4.5 and score>=4)

select name, surname
from student
where score between 4 and 4.5

# 2
select *
from student
where n_g::varchar like '3%'

# 3
select *
from student 
order by n_g desc, name desc

# 4
select *
from student 
where score >=4
order by score desc

# 5
select name, risk
from hobby
where name in ('Футбол', 'Фехтование')

# 6
select *
from std_hobby
where (date_start between '2004-01-01 00:00:00' and '2010-01-01 00:00:00') and (date_finish is NULL)

#7
select *
from student 
where score >=4.5
order by score desc

#8
select *
from student 
where score >=4
order by score desc
limit 5

#9

select name,
case 
when risk >=0.8 then 'очень высокий'
when risk >=0.6 and risk <0.8 then 'высокий'
when risk >=0.4 and risk <0.6 then 'средний'
when risk >=0.2 and risk <0.4 then 'низкий'
when risk <0.2 then 'очень низкий'
end
from hobby 


#10 
select *
from hobby
order by risk desc
limit 3 
#8
select *
from student 
where score >=4
order by score desc
limit 5

