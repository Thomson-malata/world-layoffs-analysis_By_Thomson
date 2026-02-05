# world-layoffs-analysis-By-Thomson-Malata
Analysis of global layoffs (2020–2023) by industry, company, funding, and stage.
 🌍 Global Layoffs Analysis (2020–2023)

## 📌 Project Overview

This project analyzes global layoffs data from 2020 to 2023 to identify trends across years, industries, company stages, and funding levels.

The objective was to understand:
- Which year recorded the highest layoffs
- Which industries were most affected
- Whether mature companies or startups were more impacted
- Whether funding influenced layoff decisions

---

## 📊 Dataset Description

**Table Name:** layoffs  

**Columns:**
- company (text)
- location (text)
- industry (text)
- total_laid_off (int)
- percentage_laid_off (decimal)
- date (date)
- stage (text)
- country (text)
- funds_raised_millions (int)

After data cleaning:
- 1995 rows retained
- Duplicates removed
- Dates standardized
- Percentage converted to decimal
- Null values handled appropriately

---

## 🧹 Data Cleaning Process

Key cleaning steps performed using SQL:

- Removed duplicate records
- Standardized country names (e.g., "United States.")
- Converted date column to proper DATE format
- Converted percentage_laid_off to DECIMAL(5,2)
- Investigated NULL values (approximately 350 rows had both total_laid_off and percentage_laid_off missing)
- Ensured consistent industry naming (e.g., Fin-tech vs Finance)

SQL scripts available in the `/sql` folder.

---

## 📈 Exploratory Data Analysis

### 1️⃣ Yearly Layoff Trends

- **2022 recorded the highest layoffs** (+915.36% increase from 2021)
- 2021 recorded the lowest layoffs (-80.46%)
- 2023 recorded the second highest layoffs (-21.78% compared to 2022)
- 2020 recorded the third highest

📌 This suggests a major corporate restructuring wave in 2022.

---

### 2️⃣ Top Industries in 2022 (Descending Order)

1. Retail (20,914 layoffs)
2. Consumer (19456 layoffs)
3. Healthcare (15058 layoffs)
4. Transportation (12727 layoffs)
5. Finance   (12684 layoffs)
6. Food      (11288 layoffs)
7. Real Estate (9932 layoffs)
8. Education   (8728 layoffs)
9. Cryptocurrency (8263 layoffs)
10. Other     (6296 layoffs)

Retail was the most impacted industry during the 2022 peak.

---

### 3️⃣ Top Companies by Layoffs (2022)

- Meta (11,000)
- Amazon (10150)
- Cisco (4100)
- Peloton (4084)
- Philips (4000)
- Carvana (4000)
- Twitter (3700)
- Better.com (3000)
- Byju's (2500)
- Gopuff (2300)

Meta contributed approximately **6.85%** of total 2022 layoffs, indicating layoffs were distributed across multiple firms rather than dominated by one company.

---

### 4️⃣ Layoffs by Company Stage

- Post-IPO companies recorded the highest overall layoffs (204,132)
- Post-IPO companies dominated 2022 with 79,373 layoffs
- Acquired companies recorded 27,576 layoffs
- Unknown stage accounted for 40,716 layoffs

📌 Insight:
Layoffs were primarily driven by mature, publicly listed companies rather than early-stage startups.

---

### 5️⃣ Funding vs Layoffs Analysis

A correlation analysis between total funding and total layoffs returned:

**Correlation coefficient (r) = 0.11**

This indicates a **weak relationship** between funding and layoffs.

📌 Interpretation:
Funding levels alone were not strong predictors of layoff decisions. External macroeconomic pressures and strategic restructuring likely played a larger role.

---

## 📊 Visualizations

Visualizations are available in the `/visualizations` folder:

- Yearly layoffs trend chart
- Top industries (2022)
- Layoffs by company stage
- Funding vs layoffs scatter plot

---

## 🛠 Tools Used

- SQL (Data Cleaning & Analysis)
- Excel (Data Visualization)
- GitHub (Project Documentation)

---

## 🧠 Conclusion

The 2022 layoff spike was largely driven by Post-IPO companies undergoing cost restructuring amid macroeconomic tightening.

Key findings suggest:
- Mature firms were more impacted than startups
- Industry exposure mattered (Retail heavily affected)
- Funding alone did not protect companies from layoffs

This analysis demonstrates end-to-end data handling:
from cleaning and transformation to statistical analysis and business interpretation.

---

## 📬 Contact

Thomson Malata  
Data & Business Analyst  
LinkedIn: https://www.linkedin.com/in/thomson-malata-466b522b1
Email: tomsonmalata643@gmail.com
