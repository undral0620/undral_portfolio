SELECT *
FROM agriculturedata;

-- Firstly, I will stage the original dataset by creating identical table, because I don't want to permanently alter the original data.
CREATE TABLE agriculturedata_staging 
LIKE agriculturedata;

INSERT agriculturedata_staging
SELECT *
FROM agriculturedata;

-- New table with exxact same dataset but I can work on this table without worrying about losing any information. 
SELECT *
FROM agriculturedata_staging;

-- Now I will start working from the staging table. In order to perform future analysis, I'll prepare this data in the following 4 steps. 
-- 1. Remove duplicates
-- 2. Standardize the data
-- 3. Null values or blank values
-- 4. Remove unnecessary columns or making necessary changes

-- 1. Removing duplicates. The plan is to utilize row_number to assign a row number if the row is unique. Any other number than 1 will signify the row is duplicate. 
-- Assigning row number.
SELECT *,
ROW_NUMBER () over(PARTITION BY product_id, product_name, category, price_per_kg, units_shipped_kg, units_sold_kg, units_on_hand_kg, supplier, farm_location,sale_date) AS row_num
FROM agriculturedata_staging;

-- Checking if there is any number other than 1. The result shows there is no duplicate. 
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER () OVER (PARTITION BY product_id, product_name, category, price_per_kg, units_shipped_kg, units_sold_kg, units_on_hand_kg, supplier, farm_location,sale_date) AS row_num
FROM agriculturedata_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- 2. Standardizing the data. Removing leading and trailing spaces first. 
UPDATE agriculturedata_staging 
SET product_id = TRIM(product_id);

UPDATE agriculturedata_staging 
SET product_name = TRIM(product_name);

UPDATE agriculturedata_staging 
SET category = TRIM(category);

UPDATE agriculturedata_staging 
SET price_per_kg = TRIM(price_per_kg);

UPDATE agriculturedata_staging 
SET units_shipped_kg = TRIM(units_shipped_kg);

UPDATE agriculturedata_staging 
SET units_sold_kg = TRIM(units_sold_kg);

UPDATE agriculturedata_staging 
SET units_on_hand_kg = TRIM(units_on_hand_kg);

UPDATE agriculturedata_staging 
SET supplier = TRIM(supplier);

UPDATE agriculturedata_staging 
SET farm_location = TRIM(farm_location);

UPDATE agriculturedata_staging 
SET sale_date = TRIM(sale_date);

-- The date column is in text tyoe. It needs to be in date type for future analysis to go smooth. Since it is already in correct SQL date format, I will update the data type rightaway without doing any transformation. 
ALTER TABLE agriculturedata_staging
MODIFY COLUMN sale_date DATE;

-- 3. Checking for null and blank values. If there is any rows that doesn't have numeric sales data, I will get rid of them in order to do proper calculation analysis. The result shows there is no record where those sales records are null or blank. 
SELECT *
FROM agriculturedata_staging
WHERE price_per_kg IS NULL OR price_per_kg = ''
	AND units_shipped_kg IS NULL OR units_shipped_kg = ''
	AND units_sold_kg IS NULL OR units_sold_kg = ''
	AND units_on_hand_kg IS NULL OR units_on_hand_kg = '';

-- 4. Making necessary changes. There are 4 columns that are in kilograms instead of pounds. Since the U.S. market prefers pounds as a measurement, these 4 columns need to be transformed to pounds. 
-- Creating new columns
ALTER TABLE agriculturedata_staging
ADD price_per_lb DOUBLE,
ADD units_shipped_lb DOUBLE,
ADD units_sold_lb DOUBLE,
ADD units_on_hand_lb DOUBLE;

-- Adding values to the new columns 
UPDATE agriculturedata_staging 
SET price_per_lb = ROUND((price_per_kg / 2.2046), 2);

UPDATE agriculturedata_staging 
SET units_shipped_lb = ROUND((units_shipped_kg * 2.2046));

UPDATE agriculturedata_staging 
SET units_sold_lb = ROUND((units_sold_kg * 2.2046));

UPDATE agriculturedata_staging 
SET units_on_hand_lb = ROUND((units_on_hand_kg * 2.2046));

-- Farm location needs to be separated by the town and the state. So we can analyze state information separately.
-- Adding new columns
ALTER TABLE agriculturedata_staging
ADD farm_state TEXT;

ALTER TABLE agriculturedata_staging
ADD farm_town TEXT;

-- Updating the new columns with the values.
UPDATE agriculturedata_staging 
SET farm_state = SUBSTRING_INDEX(farm_location, ',', - 1);

UPDATE agriculturedata_staging 
SET farm_town = SUBSTRING_INDEX(farm_location, ',', 1);

-- Creating the final staging table with all the cleaned data and columns I will use for the analysis.
CREATE TABLE agriculturedata_staging_lb 
LIKE agriculturedata_staging;

INSERT INTO agriculturedata_staging_lb
SELECT *
FROM agriculturedata_staging;

-- Deleting unnecessary columns.
ALTER TABLE agriculturedata_staging_lb
DROP product_id,
DROP price_per_kg,
DROP units_shipped_kg,
DROP units_sold_kg,
DROP units_on_hand_kg,
DROP farm_location;

--  This is the final dataset. 
SELECT *
FROM agriculturedata_staging_lb;






