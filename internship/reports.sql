-- Учет по остаткам

select 
	product.name
	sum(income.units) - sum(outcome.units)
from 
	product,
	income,
	outcome,
	document
where
	product.product_id = income.product_id and
	product.product_id = outcome.product_id and
	document.document_id = income.document_id and
	document.document_id = outcome.document_id and
	document.date >= {BeginDate} and
	document.date <= {FinalDate}
group by
	product.product_id
	
-- Учет по бухгалтерии
	
select 
	sum(income.units * income.cost) - sum(outcome.units * outcome.cost)
from
	document,
	income,
	outcome
where
	document.document_id = income.document_id and
	document.document_id = outcome.document_id
group by
	... (различные варианты группировки по годам, кварталам, месяцам, неделям, дням, часам)

	
	
