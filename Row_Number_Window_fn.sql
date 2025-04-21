SELECT TOP (1000) [student_id]
      ,[last_name]
      ,[first_name]
      ,[class_code]
      ,[Grade_pt]
  FROM [Students].[dbo].[students_table]

  ---use row_number() to assign row numbers
  select class_code, student_id, first_name, last_name, grade_pt,
		 ROW_NUMBER() over(order by grade_pt) as row_no
  from students_table
  where class_code in ('FR', 'JR')
  ---without partition by, the rows are assigned numbers 1 to n

    select class_code, student_id, first_name, last_name, grade_pt,
		 ROW_NUMBER() over(partition by class_code order by grade_pt) as row_no
  from students_table
  where class_code in ('FR', 'JR')
  ---with partition by, the rows are assigned numbers 1-n for each partition. e.g 1-3 for class FR then 1-2 for class JR, etc

  ---using  a derived table and row_number()
  with Results as(
	select ROW_NUMBER()
	over(order by grade_pt) as row_no,
	class_code, grade_pt
	from students_table
				)
	select * from results
	where row_no between 8 and 10

---cn we use row_number to find the 2nd top grade?
with numbering as(
select ROW_NUMBER()
	over(order by grade_pt desc) as row_no,
first_name, last_name, grade_pt
from students_table)

select * from numbering
 where row_no  between 1 and 5

 ---ORDERED ANALYTICS
 select grade_pt, class_code, last_name,
 sum(grade_pt) over(partition by class_code) as Total,
 AVG(grade_pt) over(partition by class_code) as avg_grade
 from students_table