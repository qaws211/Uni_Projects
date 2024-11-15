# Labour Force Participation Analysis

The file LFP_Data.gdt contains a subset of individuals from the SHIW (Survey on Household Income and Wealth) 2020 dataset. Further information on the variables can be found in the two  pdf files **Survey_Italian_Household_Income_and_Wealth_2020.pdf** and **LFP_Variables_Documentation.pdf** . .This repository contains an  analysis of the relationship between Labour Force Participation (LFP) and other socio-economic variables. The project explores this relationship by using StepWise Logistic Regressions.

## Project Structure

### Data and Documents
- **LFP_Data.gdt**: The dataset containing the initial variables.
- **LFP_Logistic_Regression_Analysis.pdf**: The project paper in English.
- **LFP_Variables_Documentation.pdf**: Description on all the variables considered.
- **Survey_Italian_Household_Income_and_Wealth_2020.pdf**: QUESTIONNAIRE FOR THE REFERENCE PERSON OF THE HOUSEHOLD

### Code Files
- **LFP_GRETL_Script.inp**: GRETL script for exploratory data analysis and logistic regressions written in hansl.


## Objectives

1. Build a model for labour force participation (binary variable "LFP") as a function of the suitable regressors in the dataset.
2. Find an interpretation of the results from a behavioural point of view.
3. Analyzethe difference in the determinants of male vs female labour force participation.

## Methodologies

1. **Exploratory Data Analysis**:
   - Excluded unreliable variables with too many NAs.
   - Trasformation of the variable STATCIV into dummy.

2. **Logistic Regression**:
   - Evaluated the impact of the remaining variables (e.g., NCOMP, SEX, SINGLE, ecc..) on LFP by using  a stepwise logistic regression model for the full sample dataset.
   - Evaluated the impact of the same variables on LFP by using  a stepwise logistic regression model distinguishing beetween male and female subsets.
   - Evaluated the impact of the same variables on LFP by using an interaction logistic regression  model for for the full sample dataset.


    
## Results Summary

- **Key Findings**: LFP is strongly correlated with SEX, STUDIO (especialy for females) and AREA5, while ETA doesn't play a big role.
- **Model Performance**: All four models seems good at predicting LFP.

## How to Use

1. Clone or download this repository.
2. Open and explore the dataset `LFP_Data.gdt`.
3. Use the provided LFP_GRETL_Script.inp to replicate the analysis.
4. Refer to the project paper LFP_Logistic_Regression_Analysis.pdf  for detailed documentation.

## Author


 **Alberto Sartini**

---

For any questions or feedback, feel free to contact me S1113674@studenti.univpm.it . 
