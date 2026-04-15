import sqlite3

conn = sqlite3.connect("amazon.db")
df.to_sql("sales", conn, if_exists="replace", index=False)

query = """
SELECT Category, SUM(Amount) as Total_Sales
FROM sales
GROUP BY Category
ORDER BY Total_Sales DESC
"""

result = pd.read_sql(query, conn)
print(result)

query = """
SELECT City, SUM(Amount) as Total_Sales
FROM sales
GROUP BY City
ORDER BY Total_Sales DESC
LIMIT 10
"""

result = pd.read_sql(query, conn)
print(result)



query = """
SELECT strftime('%m', Date) as Month, SUM(Amount) as Sales
FROM sales
GROUP BY Month
ORDER BY Month
"""

result = pd.read_sql(query, conn)
print(result)

import matplotlib.pyplot as plt

query = """
SELECT City, SUM(Amount) as Total_Sales
FROM sales
GROUP BY City
ORDER BY Total_Sales DESC
LIMIT 10
"""

city_data = pd.read_sql(query, conn)

print(city_data)  # output

plt.figure()
plt.bar(city_data['City'], city_data['Total_Sales'])
plt.title("Top 10 Cities Sales")
plt.xlabel("City")
plt.ylabel("Sales")
plt.xticks(rotation=45)
plt.show()

query = """
SELECT strftime('%m', Date) as Month, SUM(Amount) as Sales
FROM sales
GROUP BY Month
ORDER BY Month
"""

monthly_data = pd.read_sql(query, conn)

print(monthly_data)  # output

plt.figure()
plt.plot(monthly_data['Month'], monthly_data['Sales'])
plt.title("Monthly Sales Trend")
plt.xlabel("Month")
plt.ylabel("Sales")
plt.show()
