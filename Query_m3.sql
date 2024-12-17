 -- 1. Print part numbers and names for all parts
 SELECT Pno, Pname
 FROM PART;
 
-- 2. Print part numbers for parts that either blue or red in color
SELECT Pno
FROM PART
WHERE Color = 'Red' OR Color = 'Blue';

-- 3. Print all shipment infomration where the quantity is in the range 300 to 750 inclusive
SELECT *
FROM SHIPMENT
WHERE Qty BETWEEN 300 AND 750;

-- 4. Print the supplier information by cities in alphabetic order.
SELECT *
FROM SUPPLIER
ORDER BY City;

-- 5. Print the shipment information by price in descending numeric order.
SELECT *
FROM SHIPMENT 
ORDER BY Price DESC;

-- 6. Print the shipment by Pno in ascending order, then by Sno in descending order.
SELECT *
FROM SHIPMENT 
ORDER BY Pno ASC, Sno DESC;

-- 7. Print part numbers for all parts shipped by more than one supplier. Use count
SELECT Pno
FROM SHIPMENT
GROUP BY Pno HAVING COUNT(DISTINCT Sno) > 1;

-- 8. Print the total number of suppliers (regardless of whether they are currently shipping any parts)
SELECT COUNT(Sno)
FROM SUPPLIER;

-- 9. For each supplier currently shipping parts, print the total number of parts (i.e. sum of qty)  it has shipped.
SELECT Sno, SUM(Qty)
FROM SHIPMENT
GROUP BY Sno;

-- 10. Print supplier numbers for suppliers who ship P2 or P4.
SELECT Sno
FROM SHIPMENT
WHERE Pno = 'p2' OR 'p4';

-- 11. Print supplier numbers for suppliers who ship P2 and P4.
SELECT Sno 
FROM SHIPMENT 
WHERE Pno IN ('p2', 'p4') 
GROUP BY Sno HAVING COUNT(DISTINCT Pno) = 2;

-- 12. Print City where a supplier is located. Please eliminate all duplicate values and NULL.
SELECT DISTINCT City 
FROM SUPPLIER 
WHERE City IS NOT NULL;

-- 13. Print the part information whose name must be 3 characters, and either starts with ‘C’ or ends with ‘t’.
SELECT *
FROM PART
WHERE LENGTH(Pname) = 3 AND (Pname LIKE 'C%' OR Pname LIKE '%t');

-- 14. Print all information of the part(s) with the highest weight.
SELECT *
FROM PART
WHERE Weight = (SELECT MAX(Weight) FROM PART);

-- 15. Print all information of the part(s) that doesn’t have the lowest weight.
SELECT *
FROM PART
WHERE NOT Weight = (SELECT MIN(Weight) FROM PART);

