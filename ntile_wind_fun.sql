---the ntile function organizes rows into n number of groups
select last_name, Grade_pt, 
		NTILE(4) over(order by grade_pt) as "Tile"
from students_table
---This function divides the grades into  4 groups then tries as best as possible to distribute the tables equally into these four groups
