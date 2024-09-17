## SQL Data Cleaning and Tableau Data Visualization Exploratory Project

### [Part 1. Data Cleaning using SQL](https://github.com/undralnaran/undral_portfolio/blob/main/agriculture_data_cleaning.sql) 
Dataset was obtained from [Kaggle](https://www.kaggle.com/datasets/kdstoys/agricultural-products-sales-data-2022-2023). This dataset provides comprehensive information on agricultural product sales, supply chain metrics, and pricing across various categories, including Vegetables, Fruits, Grains, Dairy, and Livestock, for the years 2022 and 2023. It contains detailed records for over 8,000 transactions, capturing essential data points  such as product IDs, product names, categories, price per kilogram, units shipped, units sold, units on hand, supplier information, farm locations, and sale dates. One thing to note about this dataset is that, data is from 4 farms in each state and in each product category. 
</p>Original dataset visual:</p>

![Original dataset](https://github.com/user-attachments/assets/83f49f7b-9e7f-4cf7-a68a-0081d94f6eec)

</p>All data cleaning efforts were done by staging the original dataset by creating identical table, in order to eliminate the risk of permanently altering the original dataset. </p>
</p>There are 4 main parts that took place to prapare cleaning, analysis ready dataset.</p>
</p> 1. Remove duplicates: </p>
</p>Used ROW_NUMBER to assign a row number comparing every single column to make sure accuracy. Any row that has a number other than 1 signifies the row is a duplicate. Checked if there is any rows that has a row number greater than 1 by creating CTE. Result showed there was no duplicates. </p>
</p> 2. Standardize the data: </p>
</p>Firstly, all the rows were updated using trim to remove possible leading and trailing empty spaces. </p>
</p>Secondly, data column had text data type; thereofre, was updated to date data type to help ensure date analysis accuracy. </p>
</p> 3. Null values or blank values: </p>
</p>Used WHERE, IS NULL, OR '' to check if there was any black on null values. Result showed there was none. </p>
</p> 4. Remove unnecessary columns or making necessary changes: 
</p>Firstly, all the units measures were in kilograms. Since the dataset is from farms in the US, those unit measures were transformed into pounds by creating new columns and updating with new calculation (multiplied by 2.2046). The result was rounded to an integer.</p>
</p>Secondly, farm_location column had both the town and the state of the farm together, separated by comma. This needed to be separated in order to analyze state level analysis. This was done using SUBSTRING_INDEX.</p>
</p>Third, product_id was removed because it wasn't necessary for any analysis.</p>
</p>Finally, after performing all the above, created new staged table one final time with all the new calculated columns. Consequently, removed unnecessary columns and left with the analysis ready new dataset. </p>
Final dataset visual:

![Final dataset](https://github.com/user-attachments/assets/ee2befac-a0d2-463a-b74d-bafe05b36ce3)

### [Part 2. Data Visualization using Tableau](https://github.com/undralnaran/undral_portfolio/blob/main/Portfolio.twb)

The final cleaned dataset with values in pound was visualized using Tableau. This exploratory visualization approached 4 key insights to give high level but detailed understanding of the farming supply chain from all fifty states.   

1. REVENUE: Gross revenue sorted by each state 2022 vs. 2023. 5 most earned states changed almost entirely between 2022 and 2023 except only Tennessee. Average revenue of the top 5 most earned states increased by about 0.3 million from 2022 to 2023 while it decreased for the rest of the 45 states by about 0.15 million.
   
![image](https://github.com/user-attachments/assets/c2435d94-32cc-4a17-8a47-bc4b09a34e66)
![image](https://github.com/user-attachments/assets/3dfb8f03-c9a9-4462-b635-d7418c22ca08)

3. TOP PERFORMING PRODUCTS: Top 5 selling products remained the same in both years as Lamb, Beef, Cheese, Pork and Butter. 

![image](https://github.com/user-attachments/assets/892817f6-24e5-43cd-80cb-20c6f9807389)
![image](https://github.com/user-attachments/assets/4dbb1e51-45c2-4607-b257-bfcc9ce9044a)

3. SUPPLY CONSISTENCY: Category quarterly units shipped count showed that the supply remained relatively stable all across the board for all product categories in 2022 and 2023 aggregated.

![image](https://github.com/user-attachments/assets/71ae2223-41c9-4d20-a8ea-7ab015c7db35)

4. REVENUE vs. ORDER COUNT: First half of the chart showed Total Sales ( or total revenue) in each category with Average Prices and Average Sales. Average Prices stayed relatively stable. Second half of the chart showed count of the fullfilled orders. This showed the demand also stayed relatively stable. 

![image](https://github.com/user-attachments/assets/f8cba8da-b81f-4184-989f-4b70ccf47a02)



