-- Учет по остаткам для каждого товара

SELECT
	fluidity.product_id,
	sum(fluidity.count) as count
FROM
	store.document,
	(SELECT 
		income.product_id, 
		income.document_id, 
		income.count
	FROM 
		store.income
	UNION ALL
	SELECT 
		outcome.product_id, 
		outcome.document_id, 
		(outcome.count * -1) as count
	FROM 
		store.outcome
	) as fluidity
WHERE
	document.document_id = fluidity.document_id and
	document.document_id = fluidity.document_id 
	/* and document.date >= {BeginDate} and document.date <= {FinalDate} */
group by
	fluidity.product_id
	

-- Учет по бухгалтерскому движению средств по месяцам

SELECT
	to_char(document.date :: DATE, 'yyyy/mm'),
	sum(fluidity.income) as income
FROM
	store.document,
	(SELECT 
		income.product_id, 
		income.document_id, 
		(income.count * income.cost) as income
	FROM store.income
	UNION ALL
	SELECT 
		outcome.product_id, 
		outcome.document_id, 
		(outcome.count * outcome.cost * -1) as income
	FROM 
		store.outcome
	) as fluidity
WHERE
	document.document_id = fluidity.document_id and
	document.document_id = fluidity.document_id  
	/* and document.date >= {BeginDate} and document.date <= {FinalDate} */
GROUP BY
	to_char(document.date :: DATE, 'yyyy/mm')

	
	
