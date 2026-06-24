
--Top 5 Districts by Tourist Arrivals

SELECT Top 5 
    [Type],
    District,
    SUM([Count]) AS Total_Visitors
FROM Tourist_Arrivals
GROUP BY
    [Type],
    District
ORDER BY
    Total_Visitors Desc;


---Top 5 states contributing the most domestic tourists to Kerala

SELECT Top 5
    State,
    SUM(Count) AS Visitors
FROM Domestic_Source
GROUP BY State
ORDER BY Visitors DESC;


---Top 10 Destination Tousrist Visited From 2020-2025
SELECT TOP 10
    Destination
FROM Destination
WHERE Destination <> 'Others'
GROUP BY Destination
ORDER BY SUM([Count]) DESC;

---Revenue Growth
WITH RevenueGrowth AS
(
    SELECT
        [Year],
        Total_Revenue,
        LAG(Total_Revenue) OVER (ORDER BY [Year]) AS Previous_Year
    FROM Revenue
)
SELECT
    [Year],
    Total_Revenue,
    Previous_Year,
    ROUND(
        (Total_Revenue - Previous_Year) * 100.0 / Previous_Year,
        2
    ) AS Growth_Percent
FROM RevenueGrowth;




--Top Contributing States


SELECT
    State,
    SUM([Count]) AS Visitors,
    RANK() OVER(
        ORDER BY SUM([Count]) DESC
    ) AS State_Rank
FROM Domestic_Source
GROUP BY State;


----Contribution of Each State to Revenue
SELECT
    d.Year,
    d.State,
    d.Count,
    r.Total_Revenue,
    ROUND(
        r.Total_Revenue * 1.0 / d.Count,
        2
    ) AS Revenue_Per_Visitor
FROM Domestic_Source d
JOIN Revenue r
    ON d.Year = r.Year
ORDER BY d.Year, Revenue_Per_Visitor DESC;


