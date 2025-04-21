---max() over() function shows the max value up to a point
select student_id, first_name,class_code, grade_pt,
		max(grade_pt) over(order by student_id rows unbounded preceding) as max_grade
from  students_table
---if the max grade was at row 1 then the rest of the rows return that first grade

---without rows unbounded preceding:
select student_id, first_name,class_code, grade_pt,
		max(grade_pt) over(order by student_id) as max_grade
from  students_table
---gives the same results set. Means you don't need rows unbounded preceding with max over()

---using partition by to reset:
select student_id, first_name,class_code, grade_pt,
		max(grade_pt) over(partition by class_code order by student_id) as max_grade
from  students_table

---the MIN OVER() window fn
select student_id, first_name,class_code, grade_pt,
		min(grade_pt) over(order by student_id rows unbounded preceding) as max_grade
from  students_table

---with partition by:
select student_id, first_name,class_code, grade_pt,
		min(grade_pt) over(partition by  class_code order by student_id rows unbounded preceding) as min_grade
from  students_table

---use min over and 'rows between 1 following and 1 following' to find the value in the next column
select student_id, first_name,class_code, grade_pt,
		min(grade_pt) over(order by student_id rows between 1 following and 1 following) as min_grade
from  students_table
---this is especially useful when finding the next date.