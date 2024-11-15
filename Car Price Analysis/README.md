# Car Price Analysis
This repository contains a comprehensive analysis of car pricing factors, conducted as part of a consultancy-style project. The analysis focuses on the factors influencing car prices in the U.S. market, aiming to provide valuable insights for Geely Auto, a Chinese automotive company planning to enter the American market.
## Project Structure
  **car_price_analysis.csv**: The cleaned dataset used for the analysis, containing key quantitative variables relevant to the U.S. market.
  
  **car_price_analysis_presentation.ppt**: A presentation summarizing the key findings and insights from the analysis.
  
  **car_price_analysis.R**: The R script used to perform the statistical analysis, including data cleaning regression, clustering, and PCA.
  
  **README.md**: This file, providing an overview of the project and its components.

## Objectives
The primary goal of this analysis is to identify the factors that influence car prices in the U.S. market, which may differ significantly from those in the European market. This information will help Geely Auto adapt its product offerings and pricing strategies to meet local preferences and compete effectively with U.S. and European car manufacturers.
## Analysis Overview
1. **Linear Regression**:
A linear regression model was developed using variables such as horsepower, car length, compression ratio, and engine size. The model reveals that horsepower and engine size are highly significant in determining car prices, with R-Squared and Adjusted R-Squared values around 0.8, indicating strong explanatory power. A low p-value from the F-test led us to reject the null hypothesis, supporting the relevance of the chosen variables.

2. **Cluster Analysis**:
Hierarchical and non-hierarchical clustering methods (K-means and PAM) were used to categorize cars based on factors such as wheelbase, car length, horsepower, city MPG, price, and curb weight. Hierarchical clustering identified four main groups, while K-means and PAM identified three. Notably, one cluster contains high-priced, prestigious cars, suggesting that price could serve as an effective segmentation variable.

3. **Principal Component Analysis (PCA)**:
PCA showed that variables like curb weight, price, and city MPG correlated with the first principal component, which we interpreted as a measure of "luxury" or "prestige." The wheelbase variable played a crucial role in the second principal component, suggesting it may indicate the car’s suitability as a utility vehicle.

## Key Findings
The analysis concludes that key determinants of car prices in the U.S. market include cabin size, vehicle dimensions, engine power, and fuel consumption. For Geely Auto to succeed in this market, it is recommended that they focus on larger, moderately fuel-efficient vehicles to align with local preferences and stay competitive.
## Authors
**Alberto Sartini**

**Leonardo Galassi**
