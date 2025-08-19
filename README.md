# Urban Company Customer Sentiment & Review Analysis  

![Dashboard Screenshot](https://github.com/khushal728/Urban_Company_CaseStudy/blob/main/Screenshot%202025-08-18%20211523.png)
*Urban Company Sentiment Analysis Dashboard built with Power BI*  

---

## 📌 Business Problem  
Urban Company (UC) receives thousands of customer reviews across multiple services.  
However, analyzing these reviews manually is **time-consuming** and provides **limited actionable insights**.  

**Business Need:**  
- Identify **sentiment patterns** in customer reviews (Positive, Neutral, Negative).  
- Understand **which services or subservices drive dissatisfaction**.  
- Provide **data-driven recommendations** to improve customer experience.  

---

## 🎯 Objectives  
- Perform **Sentiment Analysis** on customer reviews using Python.  
- Store and transform data in **PostgreSQL** for structured analysis.  
- Use **SQL queries** to derive insights (city-level, service-level, pricing-level).  
- Build an **interactive Power BI dashboard** for stakeholders.  

---

## 🛠️ Technologies Used  
- **Python** → Sentiment analysis (TextBlob) & preprocessing.  
- **PostgreSQL** → Data storage, transformations, SQL insights.  
- **Excel** → Initial exploration & cleaning.  
- **Power BI** → Dashboard & visualization.  

---

## 📂 Dataset  
We used two datasets:  
1. **UC_Reviews.csv** → Customer reviews (Date, Time, Rating, Review Title, Review Comment).  
2. **UC.csv** → Service details (Service, Subservice, Charges, City, Country, Source).  

---

## 🧾 SQL Analysis  

### 1. Monthly Review Trends  
```sql
SELECT DATE_TRUNC('month', date) AS review_month, COUNT(*) AS total_reviews
FROM urban_summary
GROUP BY review_month
ORDER BY review_month;
```
### 2. Subservices with Most Reviews
```sql
SELECT subservice_name, COUNT(*) AS review_count
FROM urban_summary
GROUP BY subservice_name
ORDER BY review_count DESC
LIMIT 10;
```

### 3. Most Expensive Subservices
```sql
SELECT subservice_name, MAX(subservice_charge) AS max_price
FROM urban_summary
GROUP BY subservice_name
ORDER BY max_price DESC
LIMIT 10;
```

### 4. City-Wise Ratings
```sql
SELECT city_name, ROUND(AVG(ratings), 2) AS avg_rating, COUNT(*) AS total_reviews
FROM urban_summary
GROUP BY city_name
ORDER BY avg_rating DESC;
```
### 5. Service Category Insights
```sql
SELECT service, COUNT(*) AS total_reviews, ROUND(AVG(ratings), 2) AS avg_rating
FROM urban_summary
GROUP BY service
ORDER BY total_reviews DESC;
```
### 6. Review Frequency by Hour
```sql
SELECT EXTRACT(HOUR FROM time::TIME) AS review_hour,
       COUNT(*) AS review_count
FROM urban_summary
GROUP BY review_hour
ORDER BY review_hour;
```
### 🧠 Sentiment Analysis with Python

We used TextBlob in Power BI (Python integration) to classify reviews:
```py
from textblob import TextBlob
import pandas as pd

df['polarity'] = df['review_comment'].apply(lambda x: TextBlob(str(x)).sentiment.polarity)
df['Sentiment'] = df['polarity'].apply(lambda x: 'Positive' if x > 0 
                                       else ('Negative' if x < 0 else 'Neutral'))
```
