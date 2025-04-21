select * from Emp

select DATEADD(day,-5,hiredate) as hd_minus_5d,
		dateadd(day,5,hiredate) as hd_plus_5d,
		dateadd(month,-5,HireDate) as hd_minus_5m,
		DATEADD(month,5,HireDate) as hd_plus_5m,
		DATEADD(year,-5,HireDate) as hd_minus_5y,
		dateadd(year,5,hiredate) as hd_plus_5y
from Emp
where EName='Clark'

select DATEDIFF(day,smith_hd,miller_hd)
from(select hiredate as smith_hd
		from Emp
		where EName='Smith')x,
	(select hiredate as miller_hd
		from Emp
		where EName='Miller')y



SELECT 
    COALESCE(
        DAY(
            CAST(CONCAT(YEAR(GETDATE()), '-02-29') AS DATE)
        ),
        28
    ) AS DayOfMonth


select year(getdate()) as currentyear

---find number of days in a year
select datediff(d,curr_year,DATEADD(yy,1,curr_year))
from(
select DATEADD(d,-datepart(dy,getdate())+1,GETDATE())curr_year ---find first day of current year
)x

select dateadd(d,-DATEPART(dy,getdate())+1,GETDATE()) curr_year

SELECT DATEFROMPARTS(YEAR(GETDATE()), 1, 1)

select datepart(hour,getdate())

select dateadd(day,-day(dateadd(m,1,getdate())),getdate())

select DATEADD(day,-day(getdate())+1,getdate()) first_day,
		DATEADD(DAY,
					-day(DATEADD(m,1,GETDATE())),
					DATEADD(m,1,getdate()))last_day

---find all fridays in a year
