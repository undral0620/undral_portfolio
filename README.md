# SQL AgricultureData Cleaning and Tableau Data Visualization Exploratory Project

intro paragraph

## [Part 1. Data Cleaning using SQL](https://github.com/undralnaran/undral_portfolio/blob/main/agriculture_data_cleaning.sql) 
Dataset was obtained from [Kaggle](https://www.kaggle.com/datasets/kdstoys/agricultural-products-sales-data-2022-2023). This dataset provides comprehensive information on agricultural product sales, supply chain metrics, and pricing across various categories, including Vegetables, Fruits, Grains, Dairy, and Livestock, for the years 2022 and 2023. It contains detailed records for over 8,000 transactions, capturing essential data points  such as product IDs, product names, categories, price per kilogram, units shipped, units sold, units on hand, supplier information, farm locations, and sale dates. 
Original dataset visual:
![image](https://github.com/user-attachments/assets/24bac8ae-dedc-40a5-8a65-bd100e450a9e)

All data cleaning efforts were done by staging the original dataset by creating identical table, in order to eliminate the risk of permanently altering the original dataset. 
There are 4 main parts that took place to prapare cleaning, analysis ready dataset.
-- 1. Remove duplicates: 
	Used ROW_NUMBER to assign a row number comparing every single column to make sure accuracy. Any row that has a number other than 1 signifies the row is a duplicate. Checked if there is any rows that has a row number greater than 1 by creating CTE. Result showed there 		was no duplicates. 
-- 2. Standardize the data: 
	Firstly, all the rows were updated using trim to remove possible leading and trailing empty spaces. 
 	Secondly, data column had text data type; thereofre, was updated to date data type to help ensure date analysis accuracy. 
-- 3. Null values or blank values: 
	Used WHERE, IS NULL, OR '' to check if there was any black on null values. Result showed there was none. 
-- 4. Remove unnecessary columns or making necessary changes: 
	Firstly, all the units measures were in kilograms. Since the dataset is from farms in the US, those unit measures were transformed into pounds by creating new columns and updating with new calculation (multiplied by 2.2046). The result was rounded to an integer.
	Secondly, farm_location column had both the town and the state of the farm together, separated by comma. This needed to be separated in order to analyze state level analysis. This was done using SUBSTRING_INDEX.

 Finally, after performing all the above, created new staged table one final time with all the new calculated columns. Consequently, removed unnecessary columns and left with the analysis ready new dataset. 
 Final dataset visual:
 ![image](https://github.com/user-attachments/assets/4ab55f4f-4094-4fa8-8a1b-e188b45dba05)


## [Part 2. Data Visualization using Tableau](https://github.com/undralnaran/undral_portfolio/blob/main/Portfolio.twb)
