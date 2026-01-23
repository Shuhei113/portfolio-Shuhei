---
title: "Consumer Choice Modeling"      # ← カードのタイトルになります
description: "Using Latent Class Analysis to optimize pricing strategy." # ← カードの説明文
date: "2025-11-13"                     # ← 日付（並び替え用）
categories: [R, Marketing, LCA]        # ← タグ
image: "images/graph.png"              # ← カードの画像（フォルダ内に画像があれば指定）
format: html                           # ← Webページとして表示するために必要
---


# Consumer Choice Modeling & Market Segmentation
## Application of Latent Class Analysis on Yoghurt Brand Choice

![R](https://img.shields.io/badge/Language-R-blue)
![Quarto](https://img.shields.io/badge/Tool-Quarto-9cf)
![Analysis](https://img.shields.io/badge/Method-Latent%20Class%20Analysis-orange)

### 📌 Project Overview
This project applies **Multinomial Logit Models (MNL)** and **Latent Class Analysis (LCA)** to analyze consumer heterogeneity in the yoghurt market. By analyzing scanner panel data, the study identifies distinct consumer segments based on price sensitivity and responsiveness to marketing activities (flyer ads), providing actionable insights for targeted pricing strategies.

This analysis was originally conducted as a mid-term project for the **Marketing Science** course at **Hitotsubashi University** and has been refactored and translated into English using **Quarto** for reproducibility.

### 🔍 Key Insights
* **Market Heterogeneity:** Consumers are not uniform; a single aggregate model fails to capture distinct preference structures.
* **Segmentation:** Identified **4 distinct consumer segments** using BIC for model selection.
* **Targeting Strategy:**
    * **Segment 2** (characterized by younger, married individuals) shows high sensitivity to both **price** and **flyer advertisements**.
    * **Strategic Implication:** Instead of uniform price cuts, marketing resources should be allocated to targeted flyer promotions aimed at Segment 2 to maximize ROI.

### 🛠 Methodology & Tools
* **Data Preprocessing:** Reshaping wide-format choice data into long-format for discrete choice modeling.
* **Multinomial Logit (MNL):** Baseline estimation of brand choice probabilities.
* **Latent Class Analysis (LCA):** Segmentation using the Expectation-Maximization (EM) algorithm to uncover hidden groups.
* **Model Selection:** Used **Bayesian Information Criterion (BIC)** to determine the optimal number of classes ($k=4$).

**Tech Stack:**
* **R** (`tidyverse`)
* **Modeling:** `mlogit`, `flexmix`
* **Reporting:** Quarto (Reproducible Reporting)

### 📂 Repository Structure (Click to View)
| File | Description |
| :--- | :--- |
| **[report.html](./report.html)** | 📊 **[Recommended]** The full analysis report rendered in HTML. View this for the complete narrative and visualizations. |
| **[report.qmd](./report.qmd)** | 📝 The Quarto source code. Contains all R code for data loading, cleaning, and modeling to ensure reproducibility. |
| **[original.pdf](./original.pdf)** | 🇯🇵 The original project report submitted in Japanese (Mid-term assignment). |
| **[data/](./data/)** | 📁 Directory containing the raw dataset (`chapter_06_choice.csv`). |

### 🚀 How to Reproduce
1.  Clone this repository.
2.  Open `[marketing_mid.qmd](./marketing_mid.qmd)` in RStudio.
3.  Ensure the required packages are installed:
    ```r
    install.packages(c("tidyverse", "mlogit", "flexmix", "quarto"))
    ```
4.  Render the file using Quarto to generate the HTML report.

---
**Author:** Shuhei Kuwabara
* Hitotsubashi University (Social Data Science)
* The London School of Economics and Political Science (General Course)
