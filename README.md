# Urban Company Customer Sentiment & Review Analysis  

![Dashboard Screenshot](dashboard.png)  
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
2. **Services.csv** → Service details (Service, Subservice, Charges, City, Country, Source).  

---

## 🧾 SQL Analysis  

### 1. Monthly Review Trends  
```sql
SELECT DATE_TRUNC('month', date) AS review_month, COUNT(*) AS total_reviews
FROM urban_summary
GROUP BY review_month
ORDER BY review_month;
