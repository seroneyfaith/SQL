select * from students_table

select last_name, first_name,class_code, grade_pt,
		count(*) over(order by grade_pt rows unbounded preceding) as sequential_row
from  students_table

---without rows unbounded preceding
select last_name, first_name,class_code, grade_pt,
		count(*) over(order by grade_pt) as sequential_row
from  students_table
---is not the same because it counts the ties by skipping the number before

---breaking the sequence using partition by
select last_name, first_name,class_code, grade_pt,
		count(*) over(partition by class_code order by grade_pt rows unbounded preceding) as sequential_row
from  students_table

