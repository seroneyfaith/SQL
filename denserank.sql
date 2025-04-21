select sal, DENSE_RANK()over(order by cnt desc) as rnk
from(select sal, count(*) as cnt
		from Emp
		where DeptNo = 20
		group by Sal) x

select sal
from (select sal,
		DENSE_RANK() over(order by count(*) desc) as Rank
		from Emp
		where deptno = 20
		group by sal) as Ranked
		where rank=1