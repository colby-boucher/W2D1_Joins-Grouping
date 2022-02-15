USE classicmodels;

-- Question 1
SELECT c.customerName AS 'Customer Name', CONCAT(e.firstName, " ", e.lastName) AS 'Sales Rep'
FROM customers AS c INNER JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
ORDER BY customerName;

-- Question 2
SELECT p.productName AS 'Product Name', SUM(od.quantityOrdered) AS 'Total # Ordered', SUM(od.quantityOrdered * od.priceEach) AS 'Total Sale'
FROM products AS p LEFT JOIN orderdetails AS od ON p.productCode = od.productCode
GROUP BY p.productCode
ORDER BY `Total Sale` DESC;

-- Question 3
SELECT UNIQUE status AS "Order Status", COUNT(status)
FROM orders 
GROUP BY status;

-- Question 4
SELECT p.productLine AS 'Product Line', SUM(od.quantityOrdered) AS "# Orders"
FROM products AS p JOIN orderdetails AS od 
GROUP BY p.productLine;


-- Question 5
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Sales Rep', COUNT(od.quantityOrdered) AS '# Orders',
CASE 
	WHEN SUM(od.quantityOrdered * od.priceEach) IS NULL THEN FORMAT(0, 2)
	ELSE FORMAT(SUM(od.quantityOrdered * od.priceEach), 2)
END AS 'Total Sales'
FROM employees AS e
LEFT JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN orders AS o ON c.customerNumber = o.customerNumber
LEFT JOIN orderdetails as od ON o.orderNumber = od.orderNumber
WHERE e.jobTitle = 'Sales Rep'
GROUP BY e.employeeNumber
ORDER BY `Total Sales` DESC;
/*This took way too long to figure out, but I ACTUALLY did it, 
 *it'll even work if all of an employee's orders were sold for free for some reason 
 */

-- Question 6, not sure why Grid View puts a comma in year values
SELECT MONTHNAME(o.orderDate) AS 'Month', YEAR(o.orderDate) AS 'Year', FORMAT(SUM(p.amount), 2) AS 'Payments Received'
FROM orders AS o
JOIN customers AS c ON o.customerNumber = c.customerNumber 
JOIN payments AS p ON c.customerNumber = p.customerNumber 
GROUP BY `Year`, `Month`;
/* If I'm understanding this correctly, customers have paid SIGNIFICANTLY less than what the items they've ordered are actually worth
(Try summing od.quantityordered * od.priceEach rather than just p.amount) */ 


