---find out the proj that fall within a range
select * from projectdates

select id, projStart, projend 
from(
	select id, projStart, projend,
			LEAD(projstart)over(order by id) next_proj_start
	from projectdates
	)alias
where next_proj_start = projend