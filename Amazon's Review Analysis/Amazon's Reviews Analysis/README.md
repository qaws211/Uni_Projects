# Amazon's Smartwatch Review Analysis

This repository contains a sentiment analysis of reviews of a smartwatch sold on Amazon.it.

## Project Structure

### Data and Documents
- **Smartwatch_Amazon_Reviews.csv**: The dataset obtained using [Scraping_Reviews.ipynb](https://colab.research.google.com/drive/1oC00Vs6nlD55SrJhb8Qz7P2m195spXhF?usp=sharing) file.

  where:
  
          Autore: who wrote the review
  
          Stelle: How many stars given to the product
  
          Data: date of the review
  
          Titolo: title of the review
  
          Recensione: original review (as read on the amazon website)
  
          Lingua: language in which the review was written
  
          Recensione_tradotta: review translated in italian
  


  

### Code Files
- **[Scraping_Reviews.ipynb](https://colab.research.google.com/drive/1oC00Vs6nlD55SrJhb8Qz7P2m195spXhF?usp=sharing)**: (This is a colab file) To collect data from Amazon.it, we used Beautiful Soup 4 library. 
- **[Review_Analysis.ipynb](https://colab.research.google.com/drive/1dvZ-lqj5Iddg0mCFpwQT_N0wVwUuhBJy)**: (This is a colab file) We applied NLTK to conduct a natural language analysis.


## Objective

1. Understand how the smartphone is judged, what is general sentiment of the reviews and build a marketing campaign
2. Simulate a marketing campaign with the aim of emphasising the positive aspects highlighted by users who have bought the product and improving on the negative aspects.

## Methodologies

1. **Web Scraping**:
Beautiful Soup4 allowed us to explore and
efficiently extract reviews directly from Amazon's product pages,
ensuring accurate and systematic data collection.

3. **Natural Language Processing**: NLTK library offers advanced language processing tools, allowing us to explore sentiments, word frequencies and
language patterns in reviews.

## Results
1. Most reviews give 4 or 5 stars, indicating high overall satisfaction.
2. Sentiment analysis reveals an overall positive tone, with recurring phrases like "Easy to use", "good price-quality ratio" and " long battery life"; while the fewer negative reviews foucs on " losing connection".


## Authors

- **Jacopo Bonanno**
- **Leandro Sciuto**
- **Leonardo Galassi**
- **Alberto Sartini**

---

For any questions or feedback, feel free to contact me S1113674@studenti.univpm.it . Enjoy exploring the relationship between happiness and alcohol consumption!
