# Research Design Report – Loyalty Program Effects on Consumer Spending

This report was written for a Causal Inference course in the Social Data Science program at Hitotsubashi University during my third year.

###  Full Report (in Japanese)
[View PDF](research_design.pdf)

### Topic
An investigation into whether point-based loyalty programs embedded in mobile apps (e.g., Starbucks Rewards) have a **causal effect** on consumer spending behavior, through the lens of modern causal inference frameworks.

###  Frameworks used
- DAG (Directed Acyclic Graphs)
- Potential Outcomes Framework (Rubin Causal Model)
- Regression Analysis
- Propensity Score Matching (PSM)

### Summary
This report designs a research plan to test the causal effect of mobile app-based point systems on consumer spending, using the case of Starbucks Japan as an example.

Key components include:

- **Hypothesis**: Loyalty programs delivered through apps increase consumer spending by offering psychological rewards and incentives such as free drinks.
- **Causal Mechanism**: Programs enhance perceived value and encourage spending through goal-oriented behavior (e.g., collecting points).
- **Confounders Identified**: Brand loyalty, income level, and age may affect both app usage and spending; these are controlled for using DAGs and regression models.
- **Data Strategy**: Observational data (e.g., POS data) combined with survey responses are used to control for confounders and simulate a quasi-experimental design.
- **Methodology**: A Propensity Score Matching (PSM) approach is proposed to estimate the Average Treatment Effect (ATE) of app usage on spending. Matching is followed by robustness checks through multivariate regression and sensitivity analysis.
- **Feasibility**: Although a randomized controlled trial (RCT) would be ideal, the report proposes a realistic observational design with rigorous causal inference methods.

📌 *Written in Japanese (~8 pages) with conceptual rigor and practical feasibility in mind, intended to be a precursor to future empirical marketing research.*

