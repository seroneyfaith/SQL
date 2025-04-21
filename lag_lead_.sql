select year(date) as workyear, month(date) as months, division, sum(revenue) as Total_Rev
from BigData
where year(date) = '2000' and Division = 'handbags'
group by month(date), year(date), Division

---lets use lead to compare a month's revenue with the next month's revenue
select months, division, total_rev,
		lead(total_rev,1,0) over(order by months) as next_rev,
		Total_Rev-lead(total_rev,1,0) over(order by months)  as  lead_rev
from(
select year(date) as workyear, month(date) as months, division, sum(revenue) as Total_Rev
from BigData
where year(date) = '2000' and Division = 'handbags'
group by month(date), year(date), Division) x

---lag compares the previous row
select months, division, total_rev,
		lag(total_rev,1,0) over(order by months) as prev_rev,
		Total_Rev-lag(total_rev,1,0) over(order by months)  as  lag_rev
from(
select year(date) as workyear, month(date) as months, division, sum(revenue) as Total_Rev
from BigData
where year(date) = '2000' and Division = 'handbags'
group by month(date), year(date), Division) x

---offset of 2
select months, division, total_rev,
		lag(total_rev,2,0) over(order by months) as prev_rev,
		Total_Rev-lag(total_rev,2,0) over(order by months)  as  lag_rev
from(
select year(date) as workyear, month(date) as months, division, sum(revenue) as Total_Rev
from BigData
where year(date) = '2000' and Division = 'handbags'
group by month(date), year(date), Division) x
