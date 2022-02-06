
-- The 2 sellers, each month, with the highest turnover (invoiced)
 
  SELECT Numero_employe, Nom, Prenom, CA, Rang, date
FROM (SELECT date_format(p.paymentDate,'%Y-%m-%d') AS date,
            emp.employeeNumber AS Numero_employe,
            emp.lastName AS Nom,
            emp.firstName AS Prenom,
            SUM(p.amount) AS CA,
            ROW_NUMBER() OVER (PARTITION BY YEAR(p.paymentDate), MONTH(p.paymentDate) 
      ORDER BY SUM(p.amount) DESC) AS rang
      FROM payments p
      JOIN customers cs ON p.customerNumber = cs.customerNumber
      JOIN employees emp ON emp.employeeNumber = cs.salesRepEmployeeNumber 
      GROUP BY Numero_employe, date
      ORDER BY YEAR(p.paymentDate)DESC, MONTH(p.paymentDate)DESC, rang ASC
     ) AS py
     WHERE rang < 3;
     
-- The 2 sellers, each month, with the highest turnover (ordered)     
     
 SELECT Numero_employe, Nom, Prenom, Ventes, Rang, date
FROM (SELECT date_format(o.orderDate,'%Y-%m-%d') AS date,
            emp.employeeNumber AS Numero_employe,
            emp.lastName AS Nom,
            emp.firstName AS Prenom,
            SUM(od.quantityOrdered * od.priceEach) AS Ventes,
            ROW_NUMBER() OVER (PARTITION BY YEAR(o.orderDate), MONTH(o.orderDate) 
      ORDER BY SUM(od.quantityOrdered * od.priceEach) DESC) AS rang
      FROM orderdetails od
      JOIN orders o ON o.orderNumber = od.ordernumber
      JOIN customers cs ON o.customerNumber = cs.customerNumber
      JOIN employees emp ON emp.employeeNumber = cs.salesRepEmployeeNumber 
      GROUP BY date, Numero_employe 
      ORDER BY YEAR(o.orderDate)DESC, MONTH(o.orderDate)DESC, rang ASC
     ) AS py
     WHERE Rang < 3;
