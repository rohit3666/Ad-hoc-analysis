WITH CTE AS(
SELECT 
	p.division,
    	s.product_code,
    	p.product,
    	SUM(s.sold_quantity) AS total_sold_quantity,
    	DENSE_RANK() OVER(PARTITION BY division ORDER BY SUM(s.sold_quantity) DESC) AS rank_order 
FROM dim_product p
INNER JOIN fact_sales_monthly s USING(product_code)
WHERE fiscal_year = 2021 
GROUP BY 1,2,3 
ORDER BY 4 DESC
)
SELECT 
    	division,
    	product_code,
    	product,
    	total_sold_quantity,
	rank_order 
FROM CTE
WHERE rank_order IN (1,2,3);