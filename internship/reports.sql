-- Учет по остаткам для каждого товара в наличии (по ид)
SELECT
	fluidity.product_id,
	SUM(fluidity.count) as count
FROM
	(SELECT 
		income_item.product_id, 
		income_item.count,
		income.date
	FROM 
		store.income
	JOIN
		store.income_item
	ON
		income.document_id = income_item.document_id
	UNION ALL
	SELECT 
		outcome_item.product_id, 
		outcome_item.count * -1,
		outcome.date
	FROM 
		store.outcome
	JOIN
		store.outcome_item
	ON
		outcome.document_id = outcome_item.document_id
	) as fluidity
/* WHERE
	fluidity.date >= {BeginDate} and fluidity.date <= {FinalDate} */
GROUP BY
	fluidity.product_id
ORDER BY
	fluidity.product_id

	
/* Учет по остаткам для каждого товара в наличии (с именем товара)
Для отображения всех товаров заменить remind.count на COALESCE(remind.count, 0.0000) и JOIN на LEFT JOIN соответственно */
SELECT 
	product.product_id,
	product.name,
	remind.count
FROM
	store.product
JOIN
	(SELECT
		fluidity.product_id,
		SUM(fluidity.count) as count
	FROM
		(SELECT 
			income_item.product_id, 
			income_item.count,
			income.date
		FROM 
			store.income
		JOIN
			store.income_item
		ON
			income.document_id = income_item.document_id
		UNION ALL
		SELECT 
			outcome_item.product_id, 
			outcome_item.count * -1,
			outcome.date
		FROM 
			store.outcome
		JOIN
			store.outcome_item
		ON
			outcome.document_id = outcome_item.document_id
		) AS fluidity
	/* WHERE
		fluidity.date >= {BeginDate} and fluidity.date <= {FinalDate} */
	GROUP BY
		fluidity.product_id
	) AS remind
ON
	product.product_id = remind.product_id
ORDER BY
	product.product_id

	
-- Учет по бухгалтерскому движению средств по месяцам
SELECT
	to_char(document.date :: DATE, 'yyyy/mm') as date,
	SUM(fluidity.income) as income
FROM
	store.document,
	(SELECT 
		income.product_id, 
		income.document_id, 
		(income.count * income.cost * -1) as income
	FROM store.income
	UNION ALL
	SELECT 
		outcome.product_id, 
		outcome.document_id, 
		(outcome.count * outcome.cost) as income
	FROM 
		store.outcome
	) as fluidity
WHERE
	document.document_id = fluidity.document_id and
	document.document_id = fluidity.document_id  
	/* and document.date >= {BeginDate} and document.date <= {FinalDate} */
GROUP BY
	to_char(document.date :: DATE, 'yyyy/mm')
ORDER BY
	date