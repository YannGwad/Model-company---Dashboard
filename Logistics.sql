
-- The stock of the 5 most ordered products.     

     SELECT productName, quantityOrdered  FROM products p, orderdetails o
     WHERE p.productCode=o.productCode 
     GROUP BY quantityOrdered
     ORDER BY quantityOrdered desc limit 5;
