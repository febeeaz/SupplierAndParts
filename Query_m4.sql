-- 1. Print supplier numbers for suppliers who are located in the same city as supplier S1. Do not include S1 in the answer.
SELECT Sno
FROM SUPPLIER
WHERE city = (
	SELECT city FROM SUPPLIER WHERE Sno = "S1") and Sno != "S1";

-- 2. Print supplier numbers for suppliers who ship at least all those parts shipped by supplier S3.  Do not include S3 in the answer and do not "count".
SELECT DISTINCT Sno
FROM SHIPMENT
WHERE Pno IN (
	SELECT Pno FROM SHIPMENT WHERE Sno = "s3") and Sno != "s3";

-- 3. Print supplier numbers for suppliers who ship at least one type of red part.
SELECT DISTINCT Sno
FROM SHIPMENT
WHERE Pno IN (
	SELECT Pno FROM PART WHERE Color = "Red");

-- 4. Print supplier numbers for suppliers who do not ship any red parts.
SELECT DISTINCT Sno
FROM SUPPLIER
WHERE Sno NOT IN (
    SELECT DISTINCT Sno
    FROM SHIPMENT
    WHERE Pno IN (
        SELECT Pno 
        FROM PART 
        WHERE Color = 'Red'
    )
);

-- 5. Print supplier numbers for suppliers who ship ONLY red parts.
SELECT DISTINCT Sno
FROM SUPPLIER
WHERE Sno NOT IN (
    SELECT DISTINCT Sno
    FROM SHIPMENT
    WHERE Pno IN (
        SELECT Pno 
        FROM PART 
        WHERE Color = 'Red'
    )
)
AND Sno IN (
	SELECT DISTINCT Sno
	FROM SHIPMENT
	WHERE Pno IN (
		SELECT Pno FROM PART WHERE Color = "Red"));

-- 6. Print supplier names for suppliers who do not currently ship any parts.
SELECT Sname
FROM SUPPLIER 
WHERE Sno NOT IN (
	SELECT DISTINCT Sno 
    FROM SHIPMENT);

-- 7. Print supplier names for suppliers who ship at least one part that is also shipped by supplier S2.  Do not include S2 in the answer.
SELECT DISTINCT Sno
FROM SHIPMENT
WHERE Pno IN (
	SELECT Pno FROM SHIPMENT WHERE Sno = "s2") and Sno != "s2";

-- 8. Print supplier numbers for suppliers with status value less than the current average status value of all suppliers.
SELECT DISTINCT Sno 
FROM SUPPLIER
WHERE Status < (
	SELECT AVG(Status) FROM SUPPLIER);

-- 9. Print all the shipment information for the shipment(s) with the highest unit cost (i.e. price).
SELECT *
FROM SHIPMENT
WHERE Price = (
	SELECT MAX(Price)
    FROM SHIPMENT);
    
-- 10. Print all the shipment information for the shipment(s) with the highest total cost, (i.e. price*Qty).
SELECT *
FROM SHIPMENT
WHERE Price*Qty = (
	SELECT MAX(Price*Qty)
    FROM SHIPMENT);

-- 11. Print all the supplier information for the supplier(s) making the most money.  The supplier money is determined by the sum of all shipment cost.  Each shipment cost is found by the number of units being shipped times the price per unit.
SELECT *
FROM SUPPLIER
WHERE Sno IN (
    SELECT Sno
    FROM (
        SELECT Sno, SUM(Qty * Price) AS TotalCost
        FROM SHIPMENT
        GROUP BY Sno
    ) AS ShipmentCosts
    WHERE TotalCost = (
        SELECT MAX(TotalCost)
        FROM (
            SELECT SUM(Qty * Price) AS TotalCost
            FROM SHIPMENT
            GROUP BY Sno
        ) AS MaxCost
    )
);

-- 12. For each supplier (including the one who doesn’t ship any parts), print the supplier number and how many different parts shipped.  For example, S1 6; S2 2, ... 
SELECT S.Sno, COUNT(DISTINCT SH.Pno) AS DifPartsShipped
FROM SHIPMENT SH
RIGHT JOIN SUPPLIER S ON SH.Sno = S.Sno
GROUP BY S.Sno;

-- 13.	For each supplier (including the one who doesn’t ship any parts), print the supplier number, supplier name, total cost of all shipments, and how many different parts shipped.
SELECT S.Sno, S.Sname, SUM(SH.Qty * SH.Price) AS TotalCost, COUNT(DISTINCT SH.Pno) AS DifPartsShipped
FROM SHIPMENT SH
RIGHT JOIN SUPPLIER S ON SH.Sno = S.Sno
GROUP BY S.Sno;