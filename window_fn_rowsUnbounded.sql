select *  from  students_table

---use sum() over() to find the running total
select student_id, first_name, class_code, Grade_pt,
		sum(Grade_pt) over(order by grade_pt) as Sums
from students_table

---rows unbounded preceding() specifies  that this is a cumulative sum. Starts summing from row 1 to  row n
select student_id, first_name, class_code, Grade_pt,
		sum(Grade_pt) over(order by grade_pt rows unbounded preceding) as Sums
from students_table

---can be used to get a sequential  number
select *, sum(1) over(order by grade_pt) as sequence_numbs
from  students_table

select *, sum(1) over(order by grade_pt rows unbounded preceding) as sequence_numbs
from  students_table

---rows between 4 preceding and 4 preceding
select *, avg(grade_pt) over(order by grade_pt rows between 4 preceding and 4 preceding) as moving_diff
from students_table