--Deleting unimportant COLUMN
ALTER TABLE "DTG"
DROP COLUMN "data.column1";

ALTER TABLE "DTG"
DROP COLUMN "data.column3";

ALTER TABLE "DTG"
DROP COLUMN "data.column6"

ALTER TABLE "DTG"
DROP COLUMN "data.column11"

ALTER TABLE "DTG"
DROP COLUMN "data.column4"

--Renaming column header
ALTER TABLE
RENAME TABLE "data.column2" TO "Brand";
RENAME TABLE "data.column5" TO "Month";
RENAME TABLE "data.column7" TO "Customer_na";
RENAME TABLE "data.column2" TO "Brand";

--Data cleansing

UPDATE "DTG"
SET "Brand" = INITCAP(TRIM("Brand"));

UPDATE "DTG"
SET "Brand" = REPLACE("Brand", 'Vga ', '');

UPDATE "DTG"
SET "Brand" = REPLACE("Brand", ' Chair', '');

SELECT * FROM "DTG"
WHERE "Total_Sold" = 'AMOUNT';

DELETE FROM "DTG"
WHERE "Brand" = 'Brand';
 
DELETE FROM "DTG"
WHERE "Month" = 'Month';
 
DELETE FROM "DTG"
WHERE "Customer_Name" = 'CUSTOMER NAME';
 
DELETE FROM "DTG"
WHERE "Quantity_Sold" = 'QUANTITY';
 
DELETE FROM "DTG"
WHERE "Price_Per_Unit" = 'Price_Per_Unit';


--Changing data type
ALTER TABLE "DTG"
ALTER COLUMN "Total_Sold" TYPE NUMERIC(15,2)
USING "Total_Sold"::NUMERIC(15,2);

ALTER TABLE "DTG"
ALTER COLUMN "Price_Per_Unit" TYPE NUMERIC
USING "Price_Per_Unit"::NUMERIC;

ALTER TABLE "DTG"
ALTER COLUMN "Quantity_Sold" TYPE NUMERIC
USING "Quantity_Sold"::NUMERIC;
