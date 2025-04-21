--- Select all columns in the Student_Table if the Grade_Pt column 
---is greater than the Average Grade_Pt within its own Class_Code.

select * 
from students_table st1
where grade_pt >
(select avg(grade_pt)
from students_table st2
where st1.class_code = st2.class_code
group by class_code)

--- Write a correlated subquery that will bring back an answer set that returns all columns from the Course_Table if 
--that course is being taken by a student who has a greater than average grade point within their own class code.
select * from course_table ct1
where course_id in
(select course_id
from Stud_Course_Table
where student_id  in(
select student_id
from students_table s1
where Grade_pt>
(select AVG(Grade_pt)
from students_table s2
where s1.class_code = s2.class_code)
))