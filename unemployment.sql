-- Unemployment in India from 2010 to 2022

-- state wise monthly growth
select * from unemployment..state_m

-- India unemployment growth over time
select * from unemployment..india_d

-- Data Cleaning 
-- Change Date formating
--india table
select " Date", cast(" Date" as date)
from unemployment..india_d

alter table unemployment..india_d
add Date date

update unemployment..india_d
set Date=cast(" Date" as date)

select Date
from unemployment..india_d

--state table
select " Date"
from unemployment..state_m

alter table unemployment..state_m
add Date date

update unemployment..state_m
set Date=cast(" Date" as date)

select Date
from unemployment..state_m

-- Trim Extra Spaces

--india table
update unemployment..india_d
set " Frequency"=trim(" Frequency")
--state table
update unemployment..state_m
set " Frequency"=trim(" Frequency")

-- Handling NULL
--state table
select Longitude,Latitude,ISNULL(Longitude,'78.8718'),ISNULL(Latitude,'21.7679')
from unemployment..state_m
where Region='India'

update unemployment..state_m
set Longitude=ISNULL(Longitude,'78.8718')
where Region='India'

update unemployment..state_m
set Latitude=ISNULL(Latitude,'21.7679')
where Region='India'

-- Replace Values
select distinct(Region2)
from unemployment..state_m

select Region2
, case when Region2='#N/A' then 'India'
	else Region2
	end
from unemployment..state_m

update unemployment..state_m
set Region2=case when Region2='#N/A' then 'India'
			else Region2
			end

-- Drop Unwanted Column
alter table unemployment..india_d
drop column " Date"

alter table unemployment..state_m
drop column " Date"

-- Data Analyze
select * from unemployment..state_m

select * from unemployment..india_d

-- Heighest unemployment rate by region
select Region,MAX([ Estimated Unemployment Rate (%)]) as unemploy_Rate
from unemployment..state_m
group by Region
order by unemploy_Rate DESC

-- Validating Data by taking average of all Region in respect to India
select Date,avg([ Estimated Unemployment Rate (%)])
from unemployment..state_m
where Region<>'India'
group by Date
having Date='2016-01-31'
