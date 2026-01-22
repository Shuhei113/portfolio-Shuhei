### Overview
This repository contains the Final Report for the Marketing Science course, completed during my third year at Hitotsubashi University. This assignment focuses on the practical application of statistical modeling techniques—specifically Survival Analysis and Confirmatory Factor Analysis (CFA)—using R.

Grade Achieved: A+ (Outstanding)

Format: Quarto (.qmd) rendered to HTML

Language: R

Note: This repository represents a directed academic assignment. The analysis follows specific prompts provided by the instructor to demonstrate technical proficiency in modeling and interpretation. Therefore, unlike an exploratory research project, it does not include a hypothesis generation phase.

### Assignment Requirements
The report addresses two primary problems as defined in the course requirements:

## Problem 1: Survival Analysis

Dataset: Customer churn data for "Service A" and variable definitions. (Data Source: Osaka University R Marketing Data - Chapter 9)

Tasks:

Effect of Direct Mail (DM): Using the Proportional Hazards Model, discuss how the duration until customer churn differs based on whether the customer received Direct Mail (DM) or not.

Demographics and Behavior: Using the Proportional Hazards Model, discuss how churn duration is influenced by customer demographics and behavioral characteristics.

## Problem 2: Factor Analysis

Dataset: Lead User data used in "Chapter 11: Measurement and Analysis of Consumer Attitudes."

Tasks:

1-Factor vs. 2-Factor Model: Conduct a Confirmatory Factor Analysis (CFA) assuming a single latent factor (named LU). Compare these results with the 2-factor CFA conducted in class lectures and discuss the differences in model fit indices.

Model Improvement: Conduct a 2-factor CFA excluding the item BE4 from the measurement scale constituting the behavioral factor (BE). Discuss the changes in model fit indices compared to the original model.


### Tools & Libraries Used
Language: R

Framework: Quarto / R Markdown

Key Libraries:

survival, flexsurv, survminer (Survival Analysis)

lavaan, semTools, lavaanPlot (Structural Equation Modeling / CFA)

dplyr, tidyverse (Data Manipulation)
