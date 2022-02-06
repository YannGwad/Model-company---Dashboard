
-- The number of products sold by category, and by month, with comparison and the rate of change
-- compared to the same month of the previous year.

SELECT PY . categorie, ventes_n, ventes_n1, variation_to_n1, date
FROM 
(
    SELECT PR. annee, mois, categorie, SUM(ventes_n) AS ventes_n, SUM(ventes_n1) AS ventes_n1,
    (SUM(ventes_n)-SUM(ventes_n1))/SUM(ventes_n1) AS variation_to_n1, date
    FROM
    (
        SELECT  DATE_FORMAT(orderdate, '%Y-%m-%d') AS date,
                YEAR(orderdate) AS annee, MONTH(orderdate) AS mois, productline AS categorie, SUM(od.quantityOrdered) AS ventes_n,0 AS ventes_n1
        FROM products AS p
        JOIN orderdetails as od ON od.productcode = p.productcode
        JOIN orders as o ON o.ordernumber = od.ordernumber
        GROUP BY annee, mois, categorie

        UNION ALL

        SELECT  DATE_FORMAT(orderdate, '%Y-%m-%d') AS date,
            YEAR(orderdate)+1 AS annee,MONTH(orderdate) AS mois, productline AS categorie, 0 AS ventes_n, SUM(od.quantityOrdered) AS ventes_n1
        FROM products AS p
        JOIN orderdetails as od ON od.productcode = p.productcode
        JOIN orders as o ON o.ordernumber = od.ordernumber
        GROUP BY annee, mois, categorie

    )PR
    GROUP BY annee, mois, categorie
    ORDER BY annee DESC, mois DESC

)PY
WHERE (annee = YEAR(NOW()) AND mois < MONTH(NOW())) OR annee < YEAR(NOW())
GROUP BY annee, mois, categorie
ORDER BY annee DESC, mois DESC;

