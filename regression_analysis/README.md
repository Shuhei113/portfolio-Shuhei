# Regression Analysis Report – Factors Influencing GDP per Capita

This report was completed for the Regression Analysis I course in the second year of the Social Data Science program at Hitotsubashi University.  
Grade: A+

### 📄 Full R Script
[View R Script](gdp_regression.R)

###  Topic
A multivariate regression analysis to explore how various national-level socioeconomic and environmental factors affect GDP per capita, using data from 2021 (or 2020 when 2021 data were unavailable).

### Hypothesis and Theory
The hypothesis is that GDP per capita increases through structural transformation, particularly:
- Urbanization and decline in agricultural employment
- Increase in high-tech exports
- Industrialization, reflected in higher CO₂ emissions

These factors are tested through six different regression models, and further refined in a second round of models based on diagnostics and findings.

###  Variables Used

- **Dependent Variable (Y)**: `gdp` (GDP per capita)
- **Explanatory Variables**: 
  - `agri_emp`: Agricultural employment (selected as representative of economic transformation)
  - `co2_20`: CO₂ emissions per capita
  - `high_export`: High-tech exports
- **Control Variable**:
  - `pm25_20`: PM2.5 pollution (to isolate the effect of industrialization from environmental regulation gaps)

###  Summary Statistics and Visualizations

- Descriptive statistics using `summary()`
- Correlation matrix and heatmap visualization
- Scatterplots of GDP vs each key variable
- Discussion of variable selection based on theoretical linkage and correlation strength

###  Regression Models

- Seven models with different combinations of the three key explanatory variables and control variable
- Estimated using OLS with `lm()`
- Presented with `stargazer` for comparison

###  Key Findings

- **Agricultural employment** consistently has a significant negative effect on GDP
- **High-tech exports** positively and significantly affect GDP in nearly all models
- **CO₂ emissions** have no significant effect, likely due to mixed economic and regulatory interpretations
- **PM2.5** has strong negative significance, suggesting that poor air quality correlates with lower GDP

###  Regression Diagnostics

- Residual plots for all models
- Q-Q plots for normality checks
- VIF calculations for multicollinearity
- Based on diagnostics, CO₂ was excluded in later models and PM2.5 was upgraded to an explanatory variable

 *Written in Japanese with full inline explanation in the R script using `#` comments. Running this script will fully reproduce the analysis, plots, and interpretations.*

