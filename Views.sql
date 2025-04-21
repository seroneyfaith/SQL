---views are virtual tables designed to to restrict access to certain columns, derive columns or Join Tables, and to restrict access 
---to certain rows (if a WHERE clause is used)
create view big_view
as
select storeid,
		date, 
		division,
		units
from BigData
where Division = 'Belts'

select * from big_view

---Rules: no order by clause, aggregations and derived cols need ALIASES.
create view big_view2
as
select storeid, date, division, sum(units) as total_units
from BigData
where Division = 'belts'
group by date, storeid, Division

 