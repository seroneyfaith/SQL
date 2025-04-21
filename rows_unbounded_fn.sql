SELECT TOP (1000) [StoreID]
      ,[Date]
      ,[Division]
      ,[Units]
      ,[Revenue]
  FROM [BigData].[dbo].[BigData]

create nonclustered index ind_bigdata on bigdata(date, division, Units, Revenue)

select Date, Division, revenue,
		sum(revenue) over(partition by division order by revenue rows unbounded preceding) as ytd_rev
from BigData

with yearly_data
as(
select YEAR(date) as Y_ear, division, sum(revenue) as Yearly_Revenue, sum(units) Yearly_Units
from BigData
group by Division, YEAR(date)
)

---rows 2 preceding calculates a moving window of 3: current row and two preceding
select Y_ear, division,Yearly_revenue,
		sum(Yearly_revenue) over(order by y_ear rows 2 preceding)
		as sum2_preceding
from yearly_data

---use partition by to reset the count
select Y_ear, division,Yearly_revenue,
		sum(Yearly_revenue) over(partition by y_ear order by y_ear rows 2 preceding)
		as sum2_preceding
from yearly_data

---rows between current row and unbounded following shows the csum but reverses the year and revenue columns(descending)
select Y_ear, Yearly_Revenue,
		sum(Yearly_Revenue) over(order by Y_ear rows between current row and unbounded following) 
		as remaining_rev
from yearly_data

select Y_ear, division, Yearly_Revenue,
		sum(Yearly_Revenue) over(order by Y_ear rows unbounded preceding) as Running_Total
from yearly_data