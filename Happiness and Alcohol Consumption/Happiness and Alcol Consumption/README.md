# Happiness and Alcohol Consumption

This repository contains an in-depth analysis of the relationship between happiness and alcohol consumption. The project explores whether increased alcohol consumption correlates with higher levels of happiness and investigates other factors that may influence happiness globally. The analysis includes various techniques such as exploratory analysis, linear regression, cluster analysis, PCA, logistic regression, and random forest.

## Project Structure

### Data and Documents
- **HappinessAlcoholConsumption.csv**: The dataset containing data on happiness scores, alcohol consumption (beer, wine, spirits), and other variables like HDI and GDP per capita.
- **hac_Paper_IT.pdf**: The project paper in Italian.
- **hac_Paper_ENG.pdf**: The project paper in English.
- **hac_ppt_presentation.pdf**: The presentation shown to the class summarizing the analysis.

### Code Files
- **hac_Explorative_Analysis.R**: R script for exploratory data analysis, including data cleaning, visualization, and basic insights.
- **hac_Cluster_Analysis.R**: R script for performing hierarchical and non-hierarchical clustering on the dataset.
- **hac_logistic_regression.R**: R script implementing logistic regression to predict the hemisphere of countries based on the dataset's variables.
- **hac_Random_Forest.R**: R script implementing the Random Forest algorithm to classify countries and assess feature importance.

## Objectives

1. Investigate whether higher alcohol consumption correlates with increased happiness.
2. Identify other significant variables influencing happiness globally.
3. Analyze clustering patterns among countries based on shared characteristics.
4. Test predictive models (logistic regression and Random Forest) to classify countries by hemisphere.

## Methodologies

1. **Exploratory Data Analysis**:
   - Studied distributions, detected anomalies, and visualized key patterns in the dataset.
   - Excluded unreliable variables like GDP per capita after careful evaluation.

2. **Linear Regression**:
   - Evaluated the impact of independent variables (e.g., HDI, beer, wine, and spirit consumption) on happiness scores.

3. **Cluster Analysis**:
   - Used hierarchical and K-means clustering to group countries based on their characteristics.
   - Validated clusters using silhouette scores and dendrograms.

4. **Principal Component Analysis (PCA)**:
   - Reduced dimensionality to identify key patterns and validate clustering results.

5. **Logistic Regression**:
   - Predicted the hemisphere of countries using variables like HDI, beer, and spirit consumption.

6. **Random Forest**:
   - Built a classification model to evaluate feature importance and compare it with logistic regression results.

## Results Summary

- **Key Findings**: HDI is strongly correlated with happiness, while alcohol consumption (beer, wine, and spirits) has limited impact.
- **Clustering Insights**: Countries group primarily by continent, with notable differences influenced by alcohol-related regulations, cultural factors, and religious restrictions.
- **Model Performance**: Logistic regression and Random Forest models provide moderate accuracy for hemisphere classification, with Random Forest showing slight improvements.

## How to Use

1. Clone or download this repository.
2. Open and explore the dataset `HappinessAlcoholConsumption.csv`.
3. Use the provided R scripts to replicate the analysis:
   - Start with `hac_Explorative_Analysis.R` for data exploration.
   - Proceed to clustering (`hac_Cluster_Analysis.R`), logistic regression (`hac_logistic_regression.R`), and Random Forest (`hac_Random_Forest.R`).
4. Refer to the project papers (`hac_Paper_IT.pdf` and `hac_Paper_ENG.pdf`) for detailed documentation.
5. Review the presentation (`hac_ppt_presentation.pdf`) for a concise summary of findings.

## Authors

- **Oscar Maria Bolletta**
- **Leonardo Galassi**
- **Alberto Sartini**

---

For any questions or feedback, feel free to contact me S1113674@studenti.univpm.it . Enjoy exploring the relationship between happiness and alcohol consumption!

