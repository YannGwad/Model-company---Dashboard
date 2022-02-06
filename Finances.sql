
-- Turnover of the orders of the last 2 months by country

SELECT  c.country AS zoneGeographique, DATE_FORMAT(p.paymentDate,'%Y-%m-%d') AS date, p.amount
FROM customers AS c
JOIN payments as p ON p.customerNumber = c.customerNumber
GROUP BY c.country
ORDER BY p.paymentDate DESC;

-- Orders that have not yet been payed

SELECT date, od.customerNumber as numero_client, od.customerName AS client, od.TotalCommande, creditLimit as credit_client, p.amount as paye, TotalCommande- p.amount AS RAP
    FROM (SELECT DATE_FORMAT(o.orderdate, '%Y-%m-%d') AS date, sum(od.quantityOrdered*od.priceEach) AS TotalCommande, o.customerNumber, o.orderNumber,c.customerName, o.orderDate, c.creditLimit
            FROM orders AS o
            INNER JOIN orderdetails AS od
            ON od.orderNumber=o.orderNumber
                LEFT JOIN customers AS c
                ON c.customerNumber = o.customerNumber
                GROUP BY customerNumber
            ORDER BY o.customerNumber) AS od
            
            LEFT JOIN payments AS p 
            on p.customerNumber = od.customerNumber
			GROUP BY od.customerNumber, date;
