# Database Project – Online Retail (Normalized Schema and SQL Queries)

This project was submitted as a final assignment for the Database course at Hitotsubashi University.  
It demonstrates normalization, relational schema design, and SQL-based analysis using a real-world dataset.

###  Final Report (in Japanese)
[View PDF](database_report.pdf)

---

##  Project Overview

The original dataset (not included in this version) was based on a real-world online retail transaction log.  
It was normalized into four relational tables:

- `customer` — unique customers with country information  
- `product` — product catalog with description and price  
- `orders` — order header with date and customer ID  
- `order_detail` — order line items with quantity and product ID

These tables follow 3NF normalization principles.

---

##  Files

| File Name       | Description |
|----------------|-------------|
| `schema.sql`    | SQL script for creating all four normalized tables |
| `queries.sql`   | SQL script containing three analytical queries |
| `database_report.pdf` | Final written report (Japanese) including ER diagram, schema, and business insights |

---

## Queries Included

1. **Top-Selling Products** – Products ranked by total quantity sold  
2. **Top-Spending Customers** – Customers ranked by total purchase value  
3. **Countries by Order Count** – Countries ranked by total number of orders

---

##  How to Reproduce

You can run this project using SQLite:

```bash
sqlite3 retail.db
.read schema.sql
-- Then populate the tables using INSERT statements or .import if CSVs are available
.read queries.sql

