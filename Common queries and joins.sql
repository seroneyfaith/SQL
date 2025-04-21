select EName + ' works as a ' + Job as msg
from Emp
where DeptNo = 30

select cast(EmpNo as varchar) + ' works as a ' + job as msg
from Emp
where DeptNo = 20

select EName, Sal,
			case when Sal < 2000 then 'Underpaid'
				when Sal > 4000 then 'Overpaid'
			else 'OK'
			end as Status
from Emp	

select Top 5 EName, Job
from Emp
order by NEWID()

select coalesce(Comm, 0)
from Emp

select EName, Job
from Emp
where DeptNo in (20, 30)
	and EName like '%i%' and Job like '%er%'

select EName, Job
from Emp
order by SUBSTRING(Job,len(Job)-1,2) 

Create view V1
as 
select EName + ' ' + CONVERT(nvarchar(10), DeptNo) as data
from Emp

select * from v

---Lets order this alphanumeric data...
---order by Ename
select data 
from v
order by REPLACE(data,
		REPLACE(
		translate(data, '0123456789', '##########'),'#', ' '), ' ')

---order by DeptNo
select data from v
order by REPLACE(
			translate(data, '0123456789','##########'),'#',' ')

---sort nulls
select EName,Sal, Comm
	from(select EName, Sal, Comm, Case when comm is null then 0 else 1 end as is_null
			from Emp) x
order by is_null, Comm

Select e.EName, d.Loc
from Emp e, Dept d
where e.DeptNo = d.DptNo and
		DeptNo = 20

select DptNo from Dept
except
select DeptNo from Emp

select d.*
from Dept d left outer join Emp e
on (d.DptNo = e.DeptNo)
where e.DeptNo is null


select e.EName, d.Loc, eb.Received
from Emp e join Dept d
on (e.DeptNo = d.DptNo)
left join Emp_Bonus eb
on (e.EName = eb.EName)
order by 2

---using a subquery in the select statement to mimic the join
select e.EName, d.Loc,
(select eb.Received from dbo.Emp_Bonus eb where 
eb.EName = e.EName) as received
from Emp e, Dept d
where e.DeptNo = d.DptNo
order by 2

create view V2
as
select * from emp where DeptNo != 20
union all
select * from Emp where EName = 'Ward'

select * from V2 


select count(*) from emp
union
select count(*) from [Employee].[dbo].[V2]

select e.EName, d.Loc
from Emp e, Dept d
where e.DeptNo = d.DptNo and d.DptNo = 20

select e.EName, d.Loc
from Emp e, Dept d
where d.DptNo = 20 and e.DeptNo = d.DptNo 

select d.DeptName, d.DptNo, e.EName
from Emp e full outer join Dept d
on e.DeptNo = d.DptNo

select EName, Comm
from Emp
where coalesce(comm, 0) < (select comm from Emp where EName = 'Ward')


































