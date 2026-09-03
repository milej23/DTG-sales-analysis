--Overview key metrics
SELECT 
	SUM("Total_Sold") AS total_sales,
	SUM("Quantity_Sold") AS total_unit_sold,
	COUNT(DISTINCT"Brand") AS total_brand,
	COUNT(DISTINCT"Customer_Name") AS total_customer,
	ROUND(AVG("Price_Per_Unit"),2) AS avg_price_per_unit
FROM "DTG";

--Total revenue by month
SELECT
    "Month",
    SUM("Total_Sold")    AS total_revenue,
    SUM("Quantity_Sold") AS total_units
FROM "DTG"
GROUP BY "Month"
ORDER BY "Month";

-- Month-over-month revenue growth
SELECT
    "Month",
    SUM("Total_Sold") AS revenue,
    SUM("Total_Sold") - LAG(SUM("Total_Sold")) OVER (ORDER BY "Month") AS mom_change,
    ROUND(
        100.0 * (SUM("Total_Sold") - LAG(SUM("Total_Sold")) OVER (ORDER BY "Month"))
        / NULLIF(LAG(SUM("Total_Sold")) OVER (ORDER BY "Month"), 0), 2
    ) AS mom_growth_pct
FROM "DTG"
GROUP BY "Month"
ORDER BY "Month";

--Top brand by sales
SELECT "Brand" , SUM("Total_Sold") AS total_sales
FROM "DTG"
GROUP BY "Brand"
ORDER BY total_sales DESC

--Top brand by quantity sold
SELECT "Brand" , SUM("Quantity_Sold") AS quantity
FROM "DTG"
GROUP BY "Brand"

-- Revenue by brand, broken down by month 
SELECT "Month", "Brand", SUM("Total_Sold") AS revenue
FROM "DTG"
GROUP BY "Month", "Brand"
ORDER BY "Month", "Brand";

-- Best-selling brand each month (by revenue)
SELECT "Month", "Brand", revenue
FROM (
    SELECT
        "Month",
        "Brand",
        SUM("Total_Sold") AS revenue,
        RANK() OVER (PARTITION BY "Month" ORDER BY SUM("Total_Sold") DESC) AS rnk
    FROM "DTG"
    GROUP BY "Month", "Brand"
) ranked
WHERE rnk = 1
ORDER BY "Month";

-- Top 10 customers by total spend
SELECT "Customer_Name", SUM("Total_Sold") AS total_spent
FROM "DTG"
GROUP BY "Customer_Name"
ORDER BY total_spent DESC
LIMIT 10;