select student_id, last_name,  first_name, Grade_pt,
	RANK() over(order by grade_pt) as ranked,
	dense_RANK() over(order by grade_pt) as dense_ranked
from students_table
---the difference is in the ties and next ranking.

---Rank always defaults to ASC when sorting.
---using parttition by with RANK()
select student_id, last_name,  first_name, class_code, Grade_pt,
	RANK() over(partition by class_code order by grade_pt desc) as ranked
from students_table


